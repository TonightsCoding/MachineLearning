close all, clear all

pixelCnt = 64;
featureCnt = 7;
noise = 10;
inFeatureType = 'Cross';

% Merkmale-Eingangs-Matrix
% Crossing
%I1 = [0 0 1 0 0]; % Zeile 1
%I2 = [0 0 1 0 0]; % Zeile 2
%I3 = [1 1 1 1 1]; % Zeile 3
%I4 = [0 0 1 0 0]; % Zeile 4
%I5 = [0 0 1 0 0]; % Zeile 5
%featureMatrix = uint8([I1; I2; I3; I4; I5]);

% Line
%I1 = [1 0 0 0 0]; % Zeile 1
%I2 = [0 1 0 0 0]; % Zeile 2
%I3 = [0 0 1 0 0]; % Zeile 3
%I4 = [0 0 0 1 0]; % Zeile 4
%I5 = [0 0 0 0 1]; % Zeile 5
%featureMatrix = uint8([I1; I2; I3; I4; I5]);

% Example 1
%I1 = [1 1 1 0 1 1 1]; % Zeile 1
%I2 = [1 0 0 1 0 1 0]; % Zeile 2
%I3 = [1 0 0 1 0 1 0]; % Zeile 3
%I4 = [1 1 1 0 0 1 0]; % Zeile 4
%I5 = [1 0 0 1 0 1 0]; % Zeile 5
%I6 = [1 0 0 1 0 1 0]; % Zeile 6
%I7 = [1 1 1 0 0 1 0]; % Zeile 7
%featureMatrix = uint8([I1; I2; I3; I4; I5; I6; I7]);

% Example 2
I1 = [0 1 1 0 1 1 0]; % Zeile 1
I2 = [0 1 1 0 1 1 0]; % Zeile 2
I3 = [0 1 1 0 1 1 0]; % Zeile 3
I4 = [0 0 1 0 1 0 0]; % Zeile 4
I5 = [1 0 0 0 0 0 1]; % Zeile 5
I6 = [1 1 1 1 1 1 1]; % Zeile 6
I7 = [0 0 1 1 1 0 0]; % Zeile 7
featureMatrix = uint8([I1; I2; I3; I4; I5; I6; I7]);

% Merkmale-Eingangs-Matrix automatisiert
%featureMatrix = GetInputFeatureMatrix(featureCnt, inFeatureType);

pixelMatrix = GetPixelFeatureMatrix(pixelCnt, featureCnt, noise, featureMatrix, strcat('Picture_Example4_noise_', int2str(noise), '_pixelCnt_', int2str(pixelCnt), '_featureCnt_', int2str(featureCnt)));