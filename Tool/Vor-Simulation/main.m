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

l0_interface_output = (255 - inputMatrix)/255;

clear noise inputFeatureType inputMatrix
%% Weight-Matrix
weightType = 'AddMul';          % {Add, AddMul, Mul, Special}
lowerBound = -0.7;
upperBound = 0.3;
slope = 60;
l1_weights_all_neurons = GetGaussWeights(pixelCnt, featureCnt, slope, weightType, lowerBound, upperBound); 

subplot(2,2,1)
mesh(l1_weights_all_neurons)
title('Weight-Matrix')

clear lowerBound upperBound slope weightType

%% Activation-Function_Layer-1_All-Neurons
l1_activation_function_dnd = 50;
l1_activation_function_bias = 0;
l1_activation_function_resolution = 1000;
threshold = 0.5;

dnd = l1_activation_function_dnd;
resolution = l1_activation_function_resolution;

l1_activation_function_x = linspace(-dnd, dnd, resolution)';
l1_activation_function_y = l1_activation_function_x;

x = l1_activation_function_x;
y = l1_activation_function_y;

subplot(2,2,3)
plot(x, y)
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-1\_All-Neurons')

clear dnd resolution threshold

%% Calculation_Layer-1_All-Neurons

l1_output_all_neurons = zeros(featureCnt, featureCnt);

for yi=1:1:(featureCnt)
   for xi=1:1:(featureCnt)
   
      % Bestimmung der Gewichte in Form eines Spaltenvektors
      weightFeature = GetFeatureOfMatrix(l1_weights_all_neurons, xi, yi, pixelCnt, featureCnt+1);
      weightVector = ConvMatrixToColumn(weightFeature);

      % Bestimmung der Eingaenge in Form eines Spaltenvektors
      neuronInputs = GetFeatureOfMatrix(l0_interface_output, xi, yi, pixelCnt, featureCnt+1);
      neuronInputs = ConvMatrixToColumn(neuronInputs);
      
      % Berechne Neuronenausgang
      [neuronNetTerms, neuronOutput] = GetNeuronOutput(neuronInputs, weightVector, x, y);
      
      l1_output_all_neurons(yi, xi) = neuronOutput;    
      
   end
end

temp = uint8(l1_output_all_neurons(1:end, 1:end));
multiplier = min(floor(255 ./ max(temp)));
temp = multiplier .* temp;
temp = 255 - temp;
subplot(2,2,4)
imshow(temp)
title('Output-Feature-Matrix\_Layer-1')

clear temp xi yi
clear weightFeature weightVector neuronInputs
clear x y

%% new figure for layer 2
figure

%% Activation-Function_Layer-2

%% Activation-Function_Layer-2_Neuron_H-Bar
l2_activation_function_h_bar_dnd = 100;
l2_activation_function_h_bar_bias = -58;
l2_activation_function_h_bar_resolution = 1000;
threshold = 0.5;

dnd = l2_activation_function_h_bar_dnd;
bias = l2_activation_function_h_bar_bias;
resolution = l2_activation_function_h_bar_resolution;

l2_activation_function_h_bar_x = linspace(-dnd, dnd, resolution)';
l2_activation_function_h_bar_y = SigmoidFunction(l2_activation_function_h_bar_x, bias);

x = l2_activation_function_h_bar_x;
y = l2_activation_function_h_bar_y;

subplot(2,2,1)
hold on
plot(x, y)
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-2\_H-Bar')

l2_weights_h_bar = ones(1, featureCnt)';

[neuronNetTerms, neuronOutput] = GetNeuronOutput(l1_output_all_neurons(featureMiddleStart:featureMiddleEnd, 1:end)', l2_weights_h_bar, x, y);
if (neuronOutput > threshold)
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'g')
else
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'r')
end

l2_output_h_bar = neuronOutput;

clear x y bias resolution threshold dnd
%% Activation-Function_Layer-2_Neuron_V-Bar
l2_activation_function_v_bar_dnd = 100;
l2_activation_function_v_bar_bias = -58;
l2_activation_function_v_bar_resolution = 1000;
threshold = 0.5;

dnd = l2_activation_function_v_bar_dnd;
bias = l2_activation_function_v_bar_bias;
resolution = l2_activation_function_v_bar_resolution;

l2_activation_function_v_bar_x = linspace(-dnd, dnd, resolution)';
l2_activation_function_v_bar_y = SigmoidFunction(l2_activation_function_v_bar_x, bias);

x = l2_activation_function_v_bar_x;
y = l2_activation_function_v_bar_y;

subplot(2,2,2)
plot(x, y)
hold on
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-2\_V-Bar')

l2_weights_v_bar = ones(1, featureCnt)';

[neuronNetTerms, neuronOutput] = GetNeuronOutput(l1_output_all_neurons(1:end, featureMiddleStart:featureMiddleEnd), l2_weights_v_bar, x, y);
if (neuronOutput > threshold)
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'g')
else
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'r')
end

l2_output_v_bar = neuronOutput;

clear x y bias resolution threshold dnd
%% Activation-Function_Layer-2_Neuron_E-Bar
l2_activation_function_e_bar_dnd = 100;
l2_activation_function_e_bar_bias = 22;
l2_activation_function_e_bar_resolution = 1000;
threshold = 0.5;

dnd = l2_activation_function_e_bar_dnd;
bias = l2_activation_function_e_bar_bias;
resolution = l2_activation_function_e_bar_resolution;

l2_activation_function_e_bar_x = linspace(-dnd, dnd, resolution)';
l2_activation_function_e_bar_y = SigmoidFunction(l2_activation_function_e_bar_x, bias);

x = l2_activation_function_e_bar_x;
y = l2_activation_function_e_bar_y;

subplot(2,2,3)
plot(x, y)
hold on
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('Activation-Function\_Layer-2\_E-Bar')

errorField1 = ConvMatrixToColumn(l1_output_all_neurons(1:2, 1:2));
errorField2 = ConvMatrixToColumn(l1_output_all_neurons(4:5, 1:2));
errorField3 = ConvMatrixToColumn(l1_output_all_neurons(1:2, 4:5));
errorField4 = ConvMatrixToColumn(l1_output_all_neurons(4:5, 4:5));
sz = size(errorField1);

l2_weights_e_bar = ones(sz(1, 1) * 4, 1);

[neuronNetTerms1, neuronOutput1] = GetNeuronOutput(errorField1, l2_weights_e_bar(1:4), x, y);
[neuronNetTerms2, neuronOutput2] = GetNeuronOutput(errorField2, l2_weights_e_bar(5:8), x, y);
[neuronNetTerms3, neuronOutput3] = GetNeuronOutput(errorField3, l2_weights_e_bar(9:12), x, y);
[neuronNetTerms4, neuronOutput4] = GetNeuronOutput(errorField4, l2_weights_e_bar(13:16), x, y);

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

l2_output_e_bar = (neuronOutput1 + neuronOutput2 + neuronOutput3 + neuronOutput4)/4;

clear sz errorField1 errorField2 errorField3 errorField4 
clear neuronNetTerms1 neuronNetTerms2 neuronNetTerms3 neuronNetTerms4
clear neuronOutput1 neuronOutput2 neuronOutput3 neuronOutput4
clear dnd bias resolution threshold x y
clear neuronNetTerms neuronOutput

%% Compress Layer 2 Neurons

l3_interface_input = [l2_output_h_bar; l2_output_v_bar; l2_output_e_bar];

l3_interface_output = zeros(featureCnt, featureCnt);
l3_interface_h_bar_threshold = 1.5;
l3_interface_v_bar_threshold = 1.5;

h_thres = l3_interface_h_bar_threshold;
v_thres = l3_interface_v_bar_threshold;
if ((l2_output_h_bar + l2_output_e_bar) >= h_thres)
   l3_interface_output(featureMiddleStart:featureMiddleEnd, 1:end) = 1;
end

if ((l2_output_v_bar + l2_output_e_bar) >= v_thres)
   l3_interface_output(1:end, featureMiddleStart:featureMiddleEnd) = 1;
end

output_values_l2_summarized_pixel = 255*(1 - l3_interface_output);

subplot(2,2,4)
imshow(output_values_l2_summarized_pixel)
title('Output-Feature-Matrix\_Layer-2')

clear featureMiddleStart featureMiddleEnd h_thres v_thres

%% check result

if inputFeatureMatrix == l3_interface_output
   disp('Test successful')
else
   disp('Test not successful')
end

clear inputFeatureMatrix output_values_l2_summarized_pixel
%% save workspace

save('../datas_from_pre_simulation')