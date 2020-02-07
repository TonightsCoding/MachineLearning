close all, clear all

% globale Variablen
pixelCnt = 8;           % Anzahl der Pixel in x-Richtung pro Merkmal - mindestens 1
featureCnt = 5;         % Anzahl der Merkmale in x-Richtung - mindestens 1
bias = -1;              % Verschiebung in x-Richtung -> Neg (rechts), Pos (links)
noise = 60;             % Verrauschungsgrad zwischen 0 und 100%
slope = 50;             % 
domainOfDefinition = 6; % Gueltigkeitsbereich der Neuronenfunktion -> (+/- domainOfDefinition)
threshold = 0.65;       % Auswertungsschwelle des Ergebnisses
weightType = 'Add';     % Typ der Gewichtsmatrix

% Erstellen der Eingangs-Merkmale-Matrix
I1 = [0 0 1 0 0]; % Zeile 1
I2 = [0 0 1 0 0]; % Zeile 2
I3 = [1 1 1 1 1]; % Zeile 3
I4 = [0 0 1 0 0]; % Zeile 4
I5 = [0 0 1 0 0]; % Zeile 5
inputFeatureMatrix = uint8([I1; I2; I3; I4; I5]);

% Erstellen der Ausgangs-Merkmale-Matrix
outputFeatureMatrix = zeros(5, 5); % Erstelle Merkmale-Ausgangs-Matrix
outputFeatureMatrixDebug = zeros(5,5); % Erstelle Merkmale-Ausgangs-Matrix mit Summe aus Pixeln pro Merkmal

% Erstellen der Gewichts-Matrix
weightMatrix = GetWeights(pixelCnt, featureCnt, slope, weightType); % Pixel, Merkmale, Steilheit, Art

% Erstelle Plot der Gewichts-Matrix
figure
hold on
subplot(2,2,1)
mesh(weightMatrix)
title('Gewichtsmatrix')

% Erstelle Plot der Eingangs-Merkmale-Matrix
subplot(2,2,2)
inputPixelFeatureMatrix = GetPixelFeatureMatrix(pixelCnt, featureCnt, noise, inputFeatureMatrix, '');
imshow(inputPixelFeatureMatrix)
title('Eingangs-Merkmale-Matrix')

inputMatrix = (255 - inputPixelFeatureMatrix)/255;

% Erstelle Plot der Sigmoidfunktion 
subplot(2,2,3)
x = -domainOfDefinition:0.01:domainOfDefinition;
y = SigmoidFunction(x, bias);
plot(x,y)
axis([x(1) x(end) min(y) max(y)])
title('Sigmoidfunktion mit ausgewerteten Merkmalen')

% Iteration ueber alle Merkmale
for yi=1:1:(featureCnt)
   for xi=1:1:(featureCnt)
      % Bestimmung der Gewichte in Form eines Spaltenvektors
      weights = GetFeatureOfMatrix(weightMatrix, xi, yi, pixelCnt, featureCnt+1);
      weights = ConvMatrixToColumn(weights);

      % Bestimmung der Eingaenge in Form eines Spaltenvektors
      inputs = GetFeatureOfMatrix(inputMatrix, xi, yi, pixelCnt, featureCnt+1);
      inputs = ConvMatrixToColumn(inputs);
      
      % Berechne Neuronenausgang
      [neuronNetTerms, neuronOutput] = GetNeuronOutput(inputs, weights, bias, domainOfDefinition, 'sigmoid');
      
      % Werte Teilergebnis aus und trage es in Ausgang-Merkmale-Matrix ein
      if neuronOutput > threshold
         outputFeatureMatrix(yi, xi) = 1;
      else
         outputFeatureMatrix(yi, xi) = 0;
      end
      
      % Zeichne Merkmal in Sigmoidfunktion ein
      hold on
      subplot(2,2,3)
      if outputFeatureMatrix(yi, xi) == inputFeatureMatrix(yi, xi)
         % Merkmal richtig detektiert
         plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'g')
      else
         % Merkmal falsch detektiert
         plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'r')
      end
      
      % zum Debugging
      outputFeatureMatrixDebug(yi, xi) = sum(neuronNetTerms);
   end
end

% Erstelle Plot der Ausgangs-Merkmale-Matrix
subplot(2,2,4)
outputFeatureMatrix = GetPixelFeatureMatrix(pixelCnt, featureCnt, 0, outputFeatureMatrix, '');
imshow(outputFeatureMatrix)
title('Ausgangs-Merkmale-Matrix')
