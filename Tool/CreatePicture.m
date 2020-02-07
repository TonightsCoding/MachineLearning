function M = CreatePicture(pixel, feature, noise, input, name)
   % pixel - Anzahl der Pixel pro Merkmal
   % feature - Anzahl der Merkmale
   % noise - Verrauschungsgrad zwischen 0 und 100%
   % input - Merkmale-Matrix, welche Bereiche aktiv sein sollen
   % name - Name der Ausgabedatei
   
   Pixel_H = pixel; % Anzahl der Pixel horizontal pro Merkmal
   Pixel_V = pixel; % Anzahl der Pixel vertikal pro Merkmal
   Feature_H_Max = feature; % Anzahl der Merkmale horizontal
   Feature_V_Max = feature; % Anzahl der Merkmale vertikal
   Noise_Level = uint8(noise); % Werte von 0 bis 100 sind erlaubt
   if Noise_Level > 100 && 0 < Noise_Level
      error('noise level is not allowed')
   end
   if pixel*feature > 2^16-1
      error('Pixelbreite des Bildes ist zu groß.')
   end
   
   % Merkmale-Matrix
   I = uint8(input);
   if max(max(input)) > 1
      error('in the input matrix are only allowed 0 and 1')
   end
   I = 255 - (I .* 255); % S/W-Bild und invertieren

   % Berechnen der maximalen Werte
   Pixel_H_Max = Pixel_H * Feature_H_Max;
   Pixel_V_Max = Pixel_V * Feature_V_Max;
   Pixel = Pixel_H_Max * Pixel_V_Max;
   M = uint8(ones(Pixel_V_Max, Pixel_H_Max) .* 255); % Pixel-Matrix

   % Merkmale-Matrix auf Pixel-Matrix skalieren
   for v_pixel = 0:Pixel_V_Max - 1
      v_feature = idivide(uint16(v_pixel), Pixel_V, 'floor');
      for h_pixel = 0:Pixel_H_Max - 1
         h_feature = idivide(uint16(h_pixel), Pixel_H, 'floor');
         M(v_pixel + 1, h_pixel + 1) = I(v_feature + 1, h_feature + 1);
      end
   end

   % Rauschen hinzufuegen
   N = uint8(randi([0 99], Pixel_V_Max, Pixel_H_Max));
   for v_pixel = 1:Pixel_V_Max
      for h_pixel = 1:Pixel_H_Max
         if N(v_pixel, h_pixel) < Noise_Level
            M(v_pixel, h_pixel) = 255 - M(v_pixel, h_pixel);
         end
      end
   end

   imwrite(M, [name '.bmp']);
end