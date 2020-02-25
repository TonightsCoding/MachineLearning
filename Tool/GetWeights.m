function [weights, vWeightMatrix, hWeightMatrix] = GetWeights(pixelCnt, featureCnt, slope, type, lower, upper)
   % weights - Rueckgabe der Gewichtsmatrix
   % pixelCnt - Anzahl der Pixel pro Merkmal
   % featureCnt - Anzahl der Merkmale
   % slope - Steilheit der Fkt, Randrauschen unterdruecken 1 bis 100%
   % type - Art wie die Gewichte erstellt werden - Mul, Add oder AddMul
   % lower - Die untere Grenze der Gewichte (default = -1)
   % upper - Die obere Grenze der Gewichte (default = 1)
   
   if nargin == 4
       lower = -1;
       upper = 1;
   elseif nargin == 5
       error('Bitte zweite Grenze fuer die Gewichte angeben oder auf die Vorgabe von Gewichten verzichten');
   end
   if ((upper - lower) <= 0)
       error('Reichweite der Gewichtsgrenzen ist negativ oder gleich null => GetWeights(..., upper, lower) vertauscht?')
   end
   if (slope < 1) || (slope > 100)
      error('Rauschwert ist nicht erlaubt');
   end
   
   vN = pixelCnt * featureCnt;
   hN = pixelCnt * featureCnt;
   sigma = -0.0019*(slope - 1) + 0.2;
   GaussFunction = @(x, s, x0)(1/(sqrt(2*pi).*s))*exp(-((x-x0).^2)/(2.*s.^2));

   % Einteilung bestimmen
   v = linspace(-0.3,0.3,vN);
   h = linspace(-0.3,0.3,hN);

   % 2 Gaussfunktionen mit festem Sigma im Raum
   % Sigma zwischen 0.01 und 0.2 waehlen
   vGauss = GaussFunction(v, sigma, 0); % x-Achse, v-Balken
   hGauss = GaussFunction(h, sigma, 0); % y-Achse, h-Balken

   % initiale Gewichts-Matrix erstellen
   vWeightMatrix = zeros(hN, vN);

   % ersten Gauss in Gewichts-Matrix schreiben
   for i = 1:hN
       % auf 1 Normieren und in Matrix schreiben
       vWeightMatrix(i, 1:end) = vGauss./max(vGauss);
   end
   if (nargout == 3)
       hWeightMatrix = zeros(hN, vN);
       for j = 1:hN
           hWeightMatrix(1:end, j) = hGauss./max(hGauss);
       end 
   end
   
   % zweite temporaere Matrix erzeugen zur Ueberlagerung von (v_Gauss & h_Gauss)
   tempWeightMatrix = zeros(hN, vN);

   % fuer (type == MulAdd) zusaetzliche Matrix erzeugen
   if strcmp(type, 'AddMul')
     addMulWeightMatrix = zeros(hN, vN);
   end

   % Unterscheidung in for-Schleife je nach Art der Ueberlagerung (weightType)
   
   if strcmp(type, 'Mul')
      for i = 1:vN
         tempWeightMatrix(1:end, i) = vWeightMatrix(1:end, i) .* (hGauss./max(hGauss))';
         tempWeightMatrix(1:end, i) = tempWeightMatrix(1:end, i) .* 2 - 1;
      end
   elseif strcmp(type, 'Add')
      for i = 1:vN
         tempWeightMatrix(1:end, i) = (vWeightMatrix(1:end, i) + (hGauss./max(hGauss))')./2;
         tempWeightMatrix(1:end, i) = tempWeightMatrix(1:end, i) .* 2 - 1;
      end
   elseif strcmp(type, 'AddMul')
      for i = 1:vN
         % v-Gauss und h-Gauss multiplizieren
         addMulWeightMatrix(1:end, i) = (vWeightMatrix(1:end, i) .* (hGauss./max(hGauss))') - 1;
         % v-Gauss und h-Gauss addieren
         tempWeightMatrix(1:end, i) = (vWeightMatrix(1:end, i) + (hGauss./max(hGauss))') - 1;
         % mittlere Erhoehung entfernen
         tempWeightMatrix(1:end, i) = tempWeightMatrix(1:end, i) - addMulWeightMatrix(1:end, i);
         % skalieren
         tempWeightMatrix(1:end, i) = tempWeightMatrix(1:end, i) .* 2 - 1;
      end
   else
      error('Weighttype for generation unknown, use Mul, Add or AddMul')
   end

   if(lower == 0 && upper == 1)
     tempWeightMatrix = tempWeightMatrix + 1;
     tempWeightMatrix = tempWeightMatrix ./ 2;
   elseif(not(lower == -1 && upper == 1)) % fuer andere Grenzen als 0..1 oder -1..1
     if(-lower == upper) % fuer symmetrische Grenzen um Null (e.g. -2..2)
         tempWeightMatrix = tempWeightMatrix.*upper;
     else % auf 0..2 verschieben und anschliessend mit (half_range) skalieren und verschieben
         tempWeightMatrix = tempWeightMatrix + 1;
         halfRange = ((upper - lower)/2);
         tempWeightMatrix = tempWeightMatrix .* halfRange;
         tempWeightMatrix = tempWeightMatrix + lower;            
     end        
   end
    
   weights = tempWeightMatrix;
    
end
