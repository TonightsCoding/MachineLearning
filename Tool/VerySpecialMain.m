close all, clear all

functionMaxValue = 10;
bias = -2;
pixel = 8;
feature = 5;
noise = 20;
slope = 90;
threshold = 0.95;

% Merkmale-Eingangs-Matrix
I1 = [0 0 1 0 0]; % Zeile 1
I2 = [0 0 1 0 0]; % Zeile 2
I3 = [1 1 1 1 1]; % Zeile 3
I4 = [0 0 1 0 0]; % Zeile 4
I5 = [0 0 1 0 0]; % Zeile 5

sigmoidFunction = @(t)(1./(1+exp(-(t+bias))));

inputFeatures = uint8([I1; I2; I3; I4; I5]); % Erstelle Merkmale-Eingangs-Matrix
% DIE EINZIG WAHRE GEWICHTSMATRIX
weightMatrix = 2 .* (CreateWeights(pixel, feature, slope, 'Add') - 0.5 .*CreateWeights(pixel, feature, slope, 'Mul')); % Pixel, Merkmale, Steilheit, Art
%weightMatrix = (CreateWeights(pixel, feature, slope, 'Add') - 0.5 .*CreateWeights(pixel, feature, slope, 'Mul')); % Pixel, Merkmale, Steilheit, Art
%weightMatrix = weightMatrix + 0.4;
figure
hold on
subplot(2,2,1)
mesh(weightMatrix)
title('Gewichtsmatrix')
outputFeatures = zeros(5, 5); % Erstelle Merkmale-Ausgangs-Matrix
outputFeaturesSum = zeros(5,5); % Erstelle Merkmale-Ausgangs-Matrix mit Summe aus Pixeln pro Merkmal
inputMatrix = CreatePicture(pixel, feature, noise, inputFeatures, 'test');
subplot(2,2,2)
imshow(inputMatrix)
title('Eingangs-Merkmale-Matrix')
inputMatrix = (255 - inputMatrix)/255;

% Erstelle Plot von der Sigmoidfunktion 
x = -functionMaxValue:0.01:functionMaxValue;
y = sigmoidFunction(x);
subplot(2,2,3)
plot(x,y)
title('Sigmoidfunktion mit ausgewerteten Merkmalen')
axis([x(1) x(end) min(y) max(y)])

for yi=0:1:(feature - 1)
   for xi=0:1:(feature - 1)
      % Erstelle Gewichte in Form eines Spaltenvektors
      weights = GetFeatureOfMatrix(weightMatrix, xi, yi, pixel, feature); % Matrix, x-Pos, y-Pos, Pixel, Merkmal
      weights = ConvMatrixToColumn(weights);

      % Erstelle Eingänge in Form eines Spaltenvektors
      inputs = GetFeatureOfMatrix(inputMatrix, xi, yi, pixel, feature);
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

outputMatrix = CreatePicture(pixel, feature, 0, outputFeatures, 'test');
subplot(2,2,4)
imshow(outputMatrix)
title('Ausgangs-Merkmale-Matrix')
