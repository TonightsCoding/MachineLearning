function pixelMatrix = GetPixelMatrix(pixelCnt, featureCnt, noise, featureMatrix, name)
   % Funktion skaliert uebergebene Merkmale-Matrix in eine Pixel-Matrix
   %
   % pixelCnt - Anzahl der Pixel in x-Richtung pro Merkmal - mindestens 1
   % featureCnt - Anzahl der Merkmale in x-Richtung - mindestens 1
   % noise - Verrauschungsgrad zwischen 0 und 100%
   % featureMatrix - Merkmale-Matrix, welche Bereiche aktiv sein sollen
   % filename - optional - Name der Ausgabedatei
   
   % Ueberpruefung der Merkmale-Matrix
   sizeInput = size(featureMatrix);
   if (sizeInput(1) ~= featureCnt)
      error('featureCnt passt nicht zu featureMatrix')
   end
   clear sizeInput
   if max(max(featureMatrix)) > 1
      error('in the featureMatrix are only allowed 0 and 1')
   end
   
   % Ueberpruefung der maximal erlaubten Bildbreite
   % es koennen nur uint16-Werte beruecksichtigt werden
   if pixelCnt*featureCnt > 2^16-1
      error('Pixelbreite des Bildes ist zu groß.')
   end
   
   % Ueberpruefung des erlaubten Noise-Level-Bereichs -> 0 bis 100
   if ((noise > 100) && (0 < noise))
      error('noise level is not allowed')
   end
   noise = uint8(noise/2); % 50 ist maximal verrauscht
   
   % Umbenennungen fuer eventuelle Erweiterung in x- und y-Richtung
   pixelCntX = pixelCnt; % Anzahl der Pixel pro Merkmal in x-Richtung
   pixelCntY = pixelCnt; % Anzahl der Pixel pro Merkmal in y-Richtung
   featureCntX = featureCnt; % Anzahl der Merkmale horizontal
   featureCntY = featureCnt; % Anzahl der Merkmale vertikal   
   
   % Berechnen der maximalen Werte
   pixelCntX_N = pixelCntX * featureCntX; % Zaehler in x-Richtung
   pixelCntY_N = pixelCntY * featureCntY; % Zaehler in y-Richtung
   
   % Erstellen der Pixel-Matrix und Rausch-Matrix
   pixelMatrix = uint8(ones(pixelCntY_N, pixelCntX_N) .* 255);
   noiseMatrix = uint8(randi([0 99], pixelCntY_N, pixelCntX_N));

   % Umwandlung der Merkmale-Matrix in S/W-Bild
   featureMatrix = uint8(featureMatrix);
   featureMatrix = 255 - (featureMatrix .* 255);
   
   % Befuellung der Pixel-Matrix
   % Skalieren der Merkmale-Matrix auf Pixel-Matrix
   for iPixY = 0:(pixelCntY_N - 1)
      iFeatY = idivide(uint16(iPixY), pixelCntY, 'floor');
      for iPixX = 0:(pixelCntX_N - 1)
         iFeatX = idivide(uint16(iPixX), pixelCntX, 'floor');
         pixelMatrix(iPixY + 1, iPixX + 1) = featureMatrix(iFeatY + 1, iFeatX + 1);
      end
   end
   % Rauschen hinzufuegen
   for iPixY = 1:pixelCntY_N
      for iPixX = 1:pixelCntX_N
         if (noiseMatrix(iPixY, iPixX) < noise)
            pixelMatrix(iPixY, iPixX) = 255 - pixelMatrix(iPixY, iPixX);
         end
      end
   end

   % optional Bild speichern
   if (~isempty(name))
      imwrite(pixelMatrix, [name '.bmp']);
   end
end