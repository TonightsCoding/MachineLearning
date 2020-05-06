close all, clear all
figure, hold on

% activiation_function_lx_dnd - activiation_function_domain-of-defintion

%% Global Parameter
pixelCnt = 8;
featureCnt = 5;
featureMiddleStart = 3;
featureMiddleEnd = 3;

%% Input-Feature-Matrix_Layer-1
inputFeatureType = 'Cross';    % {Cross, V_Line, H_Line, Cal}
noise = 40;
inputFeatureMatrix = GetInputFeatureMatrix(featureCnt, inputFeatureType);

subplot(2,2,2)
inputMatrix = GetPixelFeatureMatrix(pixelCnt, featureCnt, noise, inputFeatureMatrix, '');
imshow(inputMatrix)
title('Input-Feature-Matrix')

inputMatrixLayer1 = (255 - inputMatrix)/255;

clear noise inputFeatureType inputMatrix
%% Weight-Matrix
weightType = 'AddMul';          % {Add, AddMul, Mul, Special}
lowerBound = -0.7;
upperBound = 0.3;
slope = 60;
weights_matrix_l1 = GetGaussWeights(pixelCnt, featureCnt, slope, weightType, lowerBound, upperBound); 

subplot(2,2,1)
mesh(weights_matrix_l1)
title('Weight-Matrix')

clear lowerBound upperBound slope weightType

%% Activation-Function_Layer-1_All-Neurons
activation_function_l1_dnd = 50;
activation_function_l1_bias = 0;
activation_function_l1_resolution = 1000;
threshold = 0.5;

dnd = activation_function_l1_dnd;
resolution = activation_function_l1_resolution;

activation_function_l1_x = linspace(-dnd, dnd, resolution)';
activation_function_l1_y = activation_function_l1_x;

x = activation_function_l1_x;
y = activation_function_l1_y;

subplot(2,2,3)
plot(x, y)
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-1\_All-Neurons')

clear dnd resolution threshold

%% Calculation_Layer-1_All-Neurons

output_values_l1_all_neurons = zeros(featureCnt, featureCnt);

for yi=1:1:(featureCnt)
   for xi=1:1:(featureCnt)
   
      % Bestimmung der Gewichte in Form eines Spaltenvektors
      weightFeature = GetFeatureOfMatrix(weights_matrix_l1, xi, yi, pixelCnt, featureCnt+1);
      weightVector = ConvMatrixToColumn(weightFeature);

      % Bestimmung der Eingaenge in Form eines Spaltenvektors
      neuronInputs = GetFeatureOfMatrix(inputMatrixLayer1, xi, yi, pixelCnt, featureCnt+1);
      neuronInputs = ConvMatrixToColumn(neuronInputs);
      
      % Berechne Neuronenausgang
      [neuronNetTerms, neuronOutput] = GetNeuronOutput(neuronInputs, weightVector, x, y);
      
      output_values_l1_all_neurons(yi, xi) = neuronOutput;    
      
   end
end

temp = uint8(output_values_l1_all_neurons(1:end, 1:end));
multiplier = min(floor(255 ./ max(temp)));
temp = multiplier .* temp;
temp = 255 - temp;
subplot(2,2,4)
imshow(temp)
title('Output-Feature-Matrix\_Layer-1')

clear temp xi yi
clear weightFeature weightVector neuronInputs
clear inputMatrixLayer1
clear x y

%% new figure for layer 2
figure

%% Activation-Function_Layer-2

%% Activation-Function_Layer-2_Neuron_H-Bar
activation_function_l2_h_bar_dnd = 100;
activation_function_l2_h_bar_bias = -58;
activation_function_l2_h_bar_resolution = 1000;
threshold = 0.5;

dnd = activation_function_l2_h_bar_dnd;
bias = activation_function_l2_h_bar_bias;
resolution = activation_function_l2_h_bar_resolution;

activation_function_l2_h_bar_x = linspace(-dnd, dnd, resolution)';
activation_function_l2_h_bar_y = SigmoidFunction(activation_function_l2_h_bar_x, bias);

x = activation_function_l2_h_bar_x;
y = activation_function_l2_h_bar_y;

subplot(2,2,1)
hold on
plot(x, y)
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-2\_H-Bar')

weights_l2_h_bar = ones(1, featureCnt)';

[neuronNetTerms, neuronOutput] = GetNeuronOutput(output_values_l1_all_neurons(featureMiddleStart:featureMiddleEnd, 1:end)', weights_l2_h_bar, x, y);
if (neuronOutput > threshold)
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'g')
else
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'r')
end

output_values_l2_h_bar = neuronOutput;

clear x y bias resolution threshold dnd
%% Activation-Function_Layer-2_Neuron_V-Bar
activation_function_l2_v_bar_dnd = 100;
activation_function_l2_v_bar_bias = -58;
activation_function_l2_v_bar_resolution = 1000;
threshold = 0.5;

dnd = activation_function_l2_v_bar_dnd;
bias = activation_function_l2_v_bar_bias;
resolution = activation_function_l2_v_bar_resolution;

activation_function_l2_v_bar_x = linspace(-dnd, dnd, resolution)';
activation_function_l2_v_bar_y = SigmoidFunction(activation_function_l2_v_bar_x, bias);

x = activation_function_l2_v_bar_x;
y = activation_function_l2_v_bar_y;

subplot(2,2,2)
plot(x, y)
hold on
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-2\_V-Bar')

weights_l2_v_bar = ones(1, featureCnt)';

[neuronNetTerms, neuronOutput] = GetNeuronOutput(output_values_l1_all_neurons(1:end, featureMiddleStart:featureMiddleEnd), weights_l2_v_bar, x, y);
if (neuronOutput > threshold)
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'g')
else
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'r')
end

output_values_l2_v_bar = neuronOutput;

clear x y bias resolution threshold dnd
%% Activation-Function_Layer-2_Neuron_E-Bar
activation_function_l2_e_bar_dnd = 100;
activation_function_l2_e_bar_bias = 22;
activation_function_l2_e_bar_resolution = 1000;
threshold = 0.5;

dnd = activation_function_l2_e_bar_dnd;
bias = activation_function_l2_e_bar_bias;
resolution = activation_function_l2_e_bar_resolution;

activation_function_l2_e_bar_x = linspace(-dnd, dnd, resolution)';
activation_function_l2_e_bar_y = SigmoidFunction(activation_function_l2_e_bar_x, bias);

x = activation_function_l2_e_bar_x;
y = activation_function_l2_e_bar_y;

subplot(2,2,3)
plot(x, y)
hold on
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-2\_E-Bar')

errorField1 = ConvMatrixToColumn(output_values_l1_all_neurons(1:2, 1:2));
errorField2 = ConvMatrixToColumn(output_values_l1_all_neurons(4:5, 1:2));
errorField3 = ConvMatrixToColumn(output_values_l1_all_neurons(1:2, 4:5));
errorField4 = ConvMatrixToColumn(output_values_l1_all_neurons(4:5, 4:5));
sz = size(errorField1);

weights_l2_e_bar = ones(sz(1, 1) * 4, 1);

[neuronNetTerms1, neuronOutput1] = GetNeuronOutput(errorField1, weights_l2_e_bar(1:4), x, y);
[neuronNetTerms2, neuronOutput2] = GetNeuronOutput(errorField2, weights_l2_e_bar(5:8), x, y);
[neuronNetTerms3, neuronOutput3] = GetNeuronOutput(errorField3, weights_l2_e_bar(9:12), x, y);
[neuronNetTerms4, neuronOutput4] = GetNeuronOutput(errorField4, weights_l2_e_bar(13:16), x, y);

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

output_values_l2_e_bar = (neuronOutput1 + neuronOutput2 + neuronOutput3 + neuronOutput4)/4;

clear sz errorField1 errorField2 errorField3 errorField4 
clear neuronNetTerms1 neuronNetTerms2 neuronNetTerms3 neuronNetTerms4
clear neuronOutput1 neuronOutput2 neuronOutput3 neuronOutput4
clear dnd bias resolution threshold x y
clear neuronNetTerms neuronOutput

%% Compress Layer 2 Neurons

output_values_l2_summarized = zeros(featureCnt, featureCnt);
output_values_l2_h_bar_threshold = 1.5;
output_values_l2_v_bar_threshold = 1.5;

h_thres = output_values_l2_h_bar_threshold;
v_thres = output_values_l2_v_bar_threshold;
if ((output_values_l2_h_bar + output_values_l2_e_bar) >= h_thres)
   output_values_l2_summarized(featureMiddleStart:featureMiddleEnd, 1:end) = 1;
end

if ((output_values_l2_v_bar + output_values_l2_e_bar) >= v_thres)
   output_values_l2_summarized(1:end, featureMiddleStart:featureMiddleEnd) = 1;
end

output_values_l2_summarized_pixel = 255*(1 - output_values_l2_summarized);

subplot(2,2,4)
imshow(output_values_l2_summarized_pixel)
title('Output-Feature-Matrix\_Layer-2')

clear featureMiddleStart featureMiddleEnd h_thres v_thres

%% check result

if inputFeatureMatrix == output_values_l2_summarized
   disp('Test successful')
else
   disp('Test not successful')
end

clear inputFeatureMatrix output_values_l2_summarized
%% save workspace

save('../datas_from_pre_simulation')