close all, clear all

pixelCnt = 8;               % Anzahl der Pixel in x-Richtung pro Merkmal - mindestens 1
featureCnt = 5;             % Anzahl der Merkmale in x-Richtung - mindestens 1
slope = 75;                 % Steigung der Aktivierungs-Funktion (gauss) [50]
weightType = 'Mul2';         % Typ der Gewichtsmatrix
lowerBound = -0.5;            % (optional) Untere Grenze der Gewichts-Matrix (default = -1) 
upperBound = 0.5;             % (optional) Obere Grenze der Gewichts-Matrix (default = 1)

[weightMatrix, vWeightMatrix, hWeightMatrix] = GetGaussWeights(pixelCnt, featureCnt, slope, weightType, lowerBound, upperBound);
% weightMatrix - erzeugte Gewichtsmatrix, 
%                Ueberlagerung aus vWeightMatrix und WeightMatrix mittels type
% vWeightMatrix - (optional) Ausgabe Gewichtsmatrix der vertikalen Funktion
% hWeightMatrix - (optional) Ausgabe Gewichtsmatrix der horizontalen Funktion

% Plot der Gewichte getrennt vertikal und horizontal 
% und anschliessend Ergebnis mit Angabe des Verwendeten Verfahrens
figure
hold on
subplot(2,2,1)
mesh(vWeightMatrix)
title('Vertikale Gewichtsmatrix')
subplot(2,2,2)
mesh(hWeightMatrix)
title('Horizontale Gewichtsmatrix')
subplot(2,2,3)
mesh(weightMatrix)
title(['Ergebnis Gewichtsmatrix mit "',weightType,'"'])
