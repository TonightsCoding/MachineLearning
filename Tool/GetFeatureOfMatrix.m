function res = GetFeatureOfMatrix(matrix, featureX, featureY, pixelCnt, featureCnt)
   % res - Merkmale-Matrix zeilenweise ausgegeben
   % matrix - Gewichtsmatrix
   % featureX - Position Merkmal in X-Richtung - horizontal
   % featureY - Position Merkmal in Y-Richtung - vertikal
   % pixelCnt - Anzahl der Pixel pro Merkmal
   % featureCnt - Anzahl der Merkmale
   
   if (featureX >= featureCnt) || (featureY >= featureCnt)
      error('Merkmal ist nicht verfügbar');
   end
   
   featureMatrix = matrix(1+pixelCnt*featureY:pixelCnt+pixelCnt*featureY, 1+pixelCnt*featureX:pixelCnt+pixelCnt*featureX);
   res = featureMatrix;
end