close all, clear all

functionMaxValue = 6;
bias = -1;
pixel = 8;
feature = 5;
noise = 60;
slope = 50;
threshold = 0.65;

% Merkmale-Eingangs-Matrix
I1 = [0 0 1 0 0]; % Zeile 1
I2 = [0 0 1 0 0]; % Zeile 2
I3 = [1 1 1 1 1]; % Zeile 3
I4 = [0 0 1 0 0]; % Zeile 4
I5 = [0 0 1 0 0]; % Zeile 5

% Merkmale-Eingangs-Matrix
%I1 = [1 1 1 1 1]; % Zeile 1
%I2 = [1 1 1 1 1]; % Zeile 2
%I3 = [1 1 1 1 1]; % Zeile 3
%I4 = [1 1 1 1 1]; % Zeile 4
%I5 = [1 1 1 1 1]; % Zeile 5

inputFeatures = uint8([I1; I2; I3; I4; I5]); % Erstelle Merkmale-Eingangs-Matrix
weightMatrix = CreateWeights(pixel, feature, slope, 'Add'); % Pixel, Merkmale, Steilheit, Art
figure
hold on
subplot(2,2,1)
mesh(weightMatrix)
title('Gewichtsmatrix')
outputFeatures = zeros(5, 5); % Erstelle Merkmale-Ausgangs-Matrix
outputFeaturesSum = zeros(5,5); % Erstelle Merkmale-Ausgangs-Matrix mit Summe aus Pixeln pro Merkmal
inputMatrix = GetPixelMatrix(pixel, feature, noise, inputFeatures, '');
subplot(2,2,2)
imshow(inputMatrix)
title('Eingangs-Merkmale-Matrix')
inputMatrix = (255 - inputMatrix)/255;

% Erstelle Plot von der Sigmoidfunktion 
x = -functionMaxValue:0.01:functionMaxValue;
y = SigmoidFunction(x, bias);
subplot(2,2,3)
plot(x,y)
title('Sigmoidfunktion mit ausgewerteten Merkmalen')
axis([x(1) x(end) min(y) max(y)])

for yi=0:1:(feature-1)
   for xi=0:1:(feature-1)
      % Erstelle Gewichte in Form eines Spaltenvektors
      weights = GetFeatureOfMatrix(weightMatrix, xi+1, yi+1, pixel, feature+1); % Matrix, x-Pos, y-Pos, Pixel, Merkmal
      weights = ConvMatrixToColumn(weights);

      % Erstelle Eingänge in Form eines Spaltenvektors
      inputs = GetFeatureOfMatrix(inputMatrix, xi+1, yi+1, pixel, feature+1);
      inputs = ConvMatrixToColumn(inputs);
      
      % Berechne Neuronenausgang
      [inputFeaturesNew, output] = GetNeuronOutput(inputs, weights, bias, functionMaxValue, 'sigmoid'); % Eingangszustand, Gewichte, Bias, MaxWert, Art
      
      if output > threshold
         outputFeatures(yi+1, xi+1) = 1;
      else
         outputFeatures(yi+1, xi+1) = 0;
      end
      
      % Zeichne Merkmal in Plot
      hold on
      subplot(2,2,3)
      if outputFeatures(yi+1, xi+1) == inputFeatures(yi+1, xi+1)
         plot(sum(inputFeaturesNew), output, '*')
      else
         plot(sum(inputFeaturesNew), output, 'o', 'color', 'r')
      end
      
      outputFeaturesSum(yi+1, xi+1) = sum(inputFeaturesNew);
   end
end

outputMatrix = GetPixelMatrix(pixel, feature, 0, outputFeatures, '');
subplot(2,2,4)
imshow(outputMatrix)
title('Ausgangs-Merkmale-Matrix')
