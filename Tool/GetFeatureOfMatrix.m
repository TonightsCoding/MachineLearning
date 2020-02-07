function feature = GetFeatureOfMatrix(matrix, featureX, featureY, pixelCnt, featureCnt)
   % Funktion teilt die uebergebene Matrix in Merkmale ein und gibt nur
   % ein Merkmal zurueck
   %
   % feature - zurueckgegebene Matrix eines Merkmals (Mermale-Matrix)
   % matrix - Matrix mit allen Merkmalen
   % featureX - Position des Merkmals in X-Richtung - startet mit 1
   % featureY - Position des Merkmals in Y-Richtung - startet mit 1
   % pixelCnt - Anzahl der Pixel in x-Richtung pro Merkmal - mindestens 1
   % featureCnt - Anzahl der Merkmale in x-Richtung - mindestens 1
   
   % Ueberpruefen der Uebergabeparamter
   % featureX und featureY muessen mit 1 beginnen
   if (featureX <= 0) 
      error('featureX muss mit 1 beginnen');
   end
   if (featureY <= 0) 
      error('featureY muss mit 1 beginnen');
   end
   % pixelCnt und featureCnt muessen mindestens 1 sein
   if (pixelCnt <= 0) 
      error('pixelCnt muss mindestens 1 sein');
   end
   if (featureCnt <= 0) 
      error('featureCnt muss mindestens 1 sein');
   end
   % Mermalverfuegbarkeit testen
   if (featureX > featureCnt) || (featureY > featureCnt)
      error('Merkmal ist nicht verfuegbar');
   end
   
   featureX = featureX - 1;
   featureY = featureY - 1;  
   
   rangeMinY = 1+pixelCnt*featureY;
   rangeMaxY = pixelCnt+pixelCnt*featureY;
   rangeMinX = 1+pixelCnt*featureX;
   rangeMaxX = pixelCnt+pixelCnt*featureX;
   
   featureMatrix = matrix(rangeMinY:rangeMaxY, rangeMinX:rangeMaxX);
   feature = featureMatrix;
end