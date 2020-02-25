close all, clear all

pixelCnt = 8;               % Anzahl der Pixel in x-Richtung pro Merkmal - mindestens 1
featureCnt = 5;             % Anzahl der Merkmale in x-Richtung - mindestens 1
slope = 75;                 % Steigung der Aktivierungs-Funktion (gauss) [50]
weightType = 'MulAdd';         % Typ der Gewichtsmatrix
lowerBound = -0.3;            % (optional) Untere Grenze der Gewichts-Matrix (default = -1) 
upperBound = 1.1;             % (optional) Obere Grenze der Gewichts-Matrix (default = 1)

weightMatrix = GetWeights(pixelCnt, featureCnt, slope, weightType, lowerBound, upperBound);
