close all, clear all
figure, hold on

% explainations of variables
% activiation_function_dnd - activiation_function_domain-of-defintion

%% Global Parameter
pixelCnt = 8;
featureCnt = 5;
featureMiddleStart = 3;
featureMiddleEnd = 3;

%% Sigmoid-Function

sigmoid_function_x = linspace(-8,8,1000)';
sigmoid_function_y = SigmoidFunction(1000, -8, 8, 0, 1, 0);

%plot(sigmoid_function_x, sigmoid_function_y)
%figure, hold on

%% Input-Feature-Matrix_Layer-1
inputFeatureType = 'H_Line';    % {Cross, V_Line, H_Line, Cal}
noise = 55;
inputFeatureMatrix = GetInputFeatureMatrix(featureCnt, inputFeatureType);

subplot(2,2,2)
input_matrix_l1 = GetPixelFeatureMatrix(pixelCnt, featureCnt, noise, inputFeatureMatrix, '');
imshow(input_matrix_l1)
title('Input-Feature-Matrix')

inputMatrixLayer1 = (255 - input_matrix_l1)/255;

clear noise inputFeatureType inputFeatureMatrix
%% Weight-Matrix
weightType = 'AddMul';          % {Add, AddMul, Mul, Special}
lowerBound = -0.7;
upperBound = 0.3;
slope = 60;
weightMatrix = GetGaussWeights(pixelCnt, featureCnt, slope, weightType, lowerBound, upperBound); 

subplot(2,2,1)
mesh(weightMatrix)
title('Weight-Matrix')

clear lowerBound upperBound slope weightType

%% Activation-Function_Layer-1_All-Neurons
activation_function_l1_all_neurons_dnd = 100;
activation_function_l1_all_neurons_bias = 0;
activation_function_l1_all_neurons_resolution = 1000;
activation_function_l1_all_neurons_threshold = 0.5;

dnd = activation_function_l1_all_neurons_dnd;
bias = activation_function_l1_all_neurons_bias;
resolution = activation_function_l1_all_neurons_resolution;
threshold = activation_function_l1_all_neurons_threshold;

activation_function_l1_all_neurons_x = linspace(-dnd, dnd, resolution)';
activation_function_l1_all_neurons_y = activation_function_l1_all_neurons_x;

x = activation_function_l1_all_neurons_x;
y = activation_function_l1_all_neurons_y;

subplot(2,2,3)
plot(x, y)
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-1\_All-Neurons')

%% Calculation_Layer-1_All-Neurons

output_l1_all_neurons = zeros(featureCnt, featureCnt);

for yi=1:1:(featureCnt)
   for xi=1:1:(featureCnt)
   
      % Bestimmung der Gewichte in Form eines Spaltenvektors
      weightFeature = GetFeatureOfMatrix(weightMatrix, xi, yi, pixelCnt, featureCnt+1);
      weightVector = ConvMatrixToColumn(weightFeature);

      % Bestimmung der Eingaenge in Form eines Spaltenvektors
      neuronInputs = GetFeatureOfMatrix(inputMatrixLayer1, xi, yi, pixelCnt, featureCnt+1);
      neuronInputs = ConvMatrixToColumn(neuronInputs);
      
      % Berechne Neuronenausgang
      x = activation_function_l1_all_neurons_x;
      y = activation_function_l1_all_neurons_y;
      [neuronNetTerms, neuronOutput] = GetNeuronOutput(neuronInputs, weightVector, bias, x, y);
      
      output_l1_all_neurons(yi, xi) = neuronOutput;    
      
   end
end

temp = uint8(output_l1_all_neurons(1:end, 1:end));
multiplier = min(floor(255 ./ max(temp)));
temp = multiplier .* temp;
temp = 255 - temp;
subplot(2,2,4)
imshow(temp)
title('Output-Feature-Matrix\_Layer-1')

clear temp xi yi
clear weightFeature weightVector neuronInputs
clear inputMatrixLayer1

%% new figure for layer 2
figure

%% Activation-Function_Layer-2_Neuron_H-Bar
activiation_function_l2_h_bar_dnd = 100;
activation_function_l2_h_bar_bias = -58;
activation_function_l2_h_bar_resolution = 1000;
activation_function_l2_h_bar_threshold = 0.5;

dnd = activiation_function_l2_h_bar_dnd;
bias = activation_function_l2_h_bar_bias;
resolution = activation_function_l2_h_bar_resolution;
threshold = activation_function_l2_h_bar_threshold;

activation_function_l2_h_bar_x = linspace(-dnd, dnd, resolution);
activation_function_l2_h_bar_y = SigmoidFunction(activation_function_l2_h_bar_x, bias);

x = activation_function_l2_h_bar_x;
y = activation_function_l2_h_bar_y;

subplot(2,2,1)
hold on
plot(x, y)
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-2\_H-Bar')

[neuronNetTerms, neuronOutput] = GetNeuronOutput(output_l1_all_neurons(featureMiddleStart:featureMiddleEnd, 1:end)', ones(1, featureCnt)', bias, sigmoid_function_x, sigmoid_function_y);
if (neuronOutput > threshold)
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'g')
else
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'r')
end

output_l2_h_bar = neuronOutput;
%% Activation-Function_Layer-2_Neuron_V-Bar
activiation_function_l2_v_bar_dnd = 100;
activation_function_l2_v_bar_bias = -58;
activation_function_l2_v_bar_resolution = 1000;
activation_function_l2_v_bar_threshold = 0.5;

dnd = activiation_function_l2_v_bar_dnd;
bias = activation_function_l2_v_bar_bias;
resolution = activation_function_l2_v_bar_resolution;
threshold = activation_function_l2_v_bar_threshold;

activation_function_l2_v_bar_x = linspace(-dnd, dnd, resolution);
activation_function_l2_v_bar_y = SigmoidFunction(activation_function_l2_h_bar_x, bias);

x = activation_function_l2_v_bar_x;
y = activation_function_l2_v_bar_y;

subplot(2,2,2)
plot(x, y)
hold on
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-2\_V-Bar')

[neuronNetTerms, neuronOutput] = GetNeuronOutput(output_l1_all_neurons(1:end, featureMiddleStart:featureMiddleEnd), ones(featureCnt, 1), bias, sigmoid_function_x, sigmoid_function_y);
if (neuronOutput > threshold)
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'g')
else
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'r')
end

output_l2_v_bar = neuronOutput;

%% Activation-Function_Layer-2_Neuron_E-Bar
activiation_function_l2_e_bar_dnd = 100;
activation_function_l2_e_bar_bias = 22;
activation_function_l2_e_bar_resolution = 1000;
activation_function_l2_e_bar_threshold = 0.5;

dnd = activiation_function_l2_e_bar_dnd;
bias = activation_function_l2_e_bar_bias;
resolution = activation_function_l2_e_bar_resolution;
threshold = activation_function_l2_e_bar_threshold;

activation_function_l2_e_bar_x = linspace(-dnd, dnd, resolution);
activation_function_l2_e_bar_y = SigmoidFunction(activation_function_l2_h_bar_x, bias);

x = activation_function_l2_e_bar_x;
y = activation_function_l2_e_bar_y;

subplot(2,2,3)
plot(x, y)
hold on
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-2\_E-Bar')

errorField1 = ConvMatrixToColumn(output_l1_all_neurons(1:2, 1:2));
errorField2 = ConvMatrixToColumn(output_l1_all_neurons(4:5, 1:2));
errorField3 = ConvMatrixToColumn(output_l1_all_neurons(1:2, 4:5));
errorField4 = ConvMatrixToColumn(output_l1_all_neurons(4:5, 4:5));
sz = size(errorField1);

[neuronNetTerms1, neuronOutput1] = GetNeuronOutput(errorField1, ones(sz(1, 1), 1), bias, sigmoid_function_x, sigmoid_function_y);
[neuronNetTerms2, neuronOutput2] = GetNeuronOutput(errorField2, ones(sz(1, 1), 1), bias, sigmoid_function_x, sigmoid_function_y);
[neuronNetTerms3, neuronOutput3] = GetNeuronOutput(errorField3, ones(sz(1, 1), 1), bias, sigmoid_function_x, sigmoid_function_y);
[neuronNetTerms4, neuronOutput4] = GetNeuronOutput(errorField4, ones(sz(1, 1), 1), bias, sigmoid_function_x, sigmoid_function_y);

if (neuronOutput1 < threshold)
   plot(sum(neuronNetTerms1), neuronOutput1, 'o', 'color', 'r')
else
   plot(sum(neuronNetTerms1), neuronOutput1, 'o', 'color', 'g')
end
if (neuronOutput2 < threshold)
   plot(sum(neuronNetTerms2), neuronOutput2, '*', 'color', 'r')
else
   plot(sum(neuronNetTerms2), neuronOutput2, '*', 'color', 'g')
end
if (neuronOutput3 < threshold)
   plot(sum(neuronNetTerms3), neuronOutput3, 'x', 'color', 'r')
else
   plot(sum(neuronNetTerms3), neuronOutput3, 'x', 'color', 'g')
end
if (neuronOutput4 < threshold)
   plot(sum(neuronNetTerms4), neuronOutput4, '+', 'color', 'r')
else
   plot(sum(neuronNetTerms4), neuronOutput4, '+', 'color', 'g')
end

output_l2_e_bar = (neuronOutput1 + neuronOutput2 + neuronOutput3 + neuronOutput4)/4;

clear sz errorField1 errorField2 errorField3 errorField4 
clear neuronNetTerms1 neuronNetTerms2 neuronNetTerms3 neuronNetTerms4
clear neuronOutput1 neuronOutput2 neuronOutput3 neuronOutput4
clear dnd bias resolution threshold x y
clear neuronNetTerms neuronOutput

%% Compress Layer 2 Neurons

output_l2_complete = zeros(featureCnt, featureCnt);

if ((output_l2_h_bar + output_l2_h_bar) >= 1)
   output_l2_complete(featureMiddleStart:featureMiddleEnd, 1:end) = 1;
end

if ((output_l2_v_bar + output_l2_h_bar) >= 1)
   output_l2_complete(1:end, featureMiddleStart:featureMiddleEnd) = 1;
end

output_l2_complete = 255*(1 - output_l2_complete);

subplot(2,2,4)
imshow(output_l2_complete)
title('Output-Feature-Matrix\_Layer-2')

clear featureMiddleStart featureMiddleEnd
