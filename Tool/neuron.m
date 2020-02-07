clear all, close all

pixelInputs = ones(64, 1); % Spaltenvektor der Eing�nge
weightsMatrix = CreateWeights(8, 5, 50, 'Add'); % komplette Gewichtsmatrix
mesh(weightsMatrix)
weights = GetFeatureOfMatrix(weightsMatrix, 2, 2, 8, 5); % Gewichte f�r Eing�nge
weights = ConvMatrixToColumn(weights);
sigmoidMaxValue = 6; % Maximaler Wert der Unterst�tz wird von der Sigmoidfunktion
bias = 0;

sigmoidFunction = @(t)(1./(1+exp(-(t+bias))));

% �berpr�fen, ob die Anzahl der Eing�nge zusammen passen.
if (length(pixelInputs) ~= length(weights))
   error('Anzahl der angegebenen Eing�nge und der Eing�nge m�ssen gleich sein.')
end

% Eing�nge mit Gewichten multiplizieren
% Gewichte auf Sigmoidfunktion skalieren
pixelMulWeights = weights .* pixelInputs;
%sum(pixelMulWeights)
while (sum(pixelMulWeights) > sigmoidMaxValue) || (-sigmoidMaxValue > sum(pixelMulWeights))
   pixelMulWeights = pixelMulWeights ./ 2;
end
%sum(pixelMulWeights)

x = -sigmoidMaxValue:0.01:sigmoidMaxValue;
y = sigmoidFunction(x);
figure
hold on
plot(x,y)
plot(sum(pixelMulWeights), sigmoidFunction(sum(pixelMulWeights)), '*')
title('Sigmoidfunktion mit ausgewertetem Merkmal')
axis([x(1) x(end) min(y) max(y)])
