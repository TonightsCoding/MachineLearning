close all, clear all

% Merkmale-Eingangs-Matrix
I1 = [0 0 1 0 0]; % Zeile 1
I2 = [0 0 1 0 0]; % Zeile 2
I3 = [1 1 1 1 1]; % Zeile 3
I4 = [0 0 1 0 0]; % Zeile 4
I5 = [0 0 1 0 0]; % Zeile 5

featureMatrix = uint8([I1; I2; I3; I4; I5]);
pixelMatrix = GetPixelFeatureMatrix(8, 5, 10, featureMatrix, '');