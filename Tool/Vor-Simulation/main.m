close all, clear all
figure('pos',[80 120 750 750]);
hold on

% dnd - domain of defintion

%% Global Parameter
featureMiddleStart = 3;
featureMiddleEnd = 3;

%% L0 Interface
l0_interface_input_pixelCnt = 8;
l0_interface_input_featureCnt = 5;
l0_interface_input_noise = 40;
inputFeatureType = 'H_Line';    % {Cross, V_Line, H_Line, Cal}
l0_interface_input_feature_matrix = GetInputFeatureMatrix(l0_interface_input_featureCnt, inputFeatureType);

subplot(2,2,1)
inputMatrix = GetPixelFeatureMatrix(l0_interface_input_pixelCnt, l0_interface_input_featureCnt, l0_interface_input_noise, l0_interface_input_feature_matrix, '');
imshow(inputMatrix)
title('l0\_interface\_output', 'FontWeight', 'bold')
xlabel('pixel x')
ylabel('pixel y')

l0_interface_output_pixel_matrix = (255 - inputMatrix)/255;

clear inputFeatureType inputMatrix
%% L1 Weights All Neurons
weightType = 'AddMul';          % {Add, AddMul, Mul, Special}
lowerBound = -0.7;
upperBound = 0.3;
slope = 60;
l1_neuron_weights_all = GetGaussWeights(l0_interface_input_pixelCnt, l0_interface_input_featureCnt, slope, weightType, lowerBound, upperBound); 

subplot(2,2,2)
mesh(l1_neuron_weights_all)
title('l1\_weights\_all\_neurons', 'FontWeight', 'bold')
xlabel('pixel x')
ylabel('pixel y')
zlabel('weight')

clear lowerBound upperBound slope weightType

%% Layer 1 All Neurons Activation Function
l1_neuron_activation_function_dnd = 50;
l1_neuron_activation_function_bias = 0;
l1_neuron_activation_function_res = 1000;
threshold = 0.5;

dnd = l1_neuron_activation_function_dnd;
resolution = l1_neuron_activation_function_res;

l1_neuron_activation_function_x = linspace(-dnd, dnd, resolution)';
l1_neuron_activation_function_y = l1_neuron_activation_function_x;

x = l1_neuron_activation_function_x;
y = l1_neuron_activation_function_y;

subplot(2,2,3)
plot(x, y)
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('l1\_activation\_function\_all\_neurons', 'FontWeight', 'bold')
xlabel('act. fct. input')
ylabel('act. fct. output')

clear dnd resolution threshold

%% Layer 1 All Neurons Calculation

l1_neuron_output_all = zeros(l0_interface_input_featureCnt, l0_interface_input_featureCnt);

for yi=1:1:(l0_interface_input_featureCnt)
   for xi=1:1:(l0_interface_input_featureCnt)
   
      % Bestimmung der Gewichte in Form eines Spaltenvektors
      weightFeature = GetFeatureOfMatrix(l1_neuron_weights_all, xi, yi, l0_interface_input_pixelCnt, l0_interface_input_featureCnt+1);
      weightVector = ConvMatrixToColumn(weightFeature);

      % Bestimmung der Eingaenge in Form eines Spaltenvektors
      neuronInputs = GetFeatureOfMatrix(l0_interface_output_pixel_matrix, xi, yi, l0_interface_input_pixelCnt, l0_interface_input_featureCnt+1);
      neuronInputs = ConvMatrixToColumn(neuronInputs);
      
      % Berechne Neuronenausgang
      [neuronNetTerms, neuronOutput] = GetNeuronOutput(neuronInputs, weightVector, x, y);
      
      l1_neuron_output_all(yi, xi) = neuronOutput;    
      hold on
      plot(neuronOutput, neuronOutput, 'o')
   end
end

temp = uint8(l1_neuron_output_all(1:end, 1:end));
multiplier = min(floor(255 ./ max(temp)));
temp = multiplier .* temp;
temp = 255 - temp;
subplot(2,2,4)
imshow(temp)
title('l1\_output\_all\_neurons', 'FontWeight', 'bold')
xlabel('feature x')
ylabel('feature y')

clear temp xi yi
clear weightFeature weightVector neuronInputs
clear x y

%% new figure for layer 2
figure('Position',[850 120 750 750]);

%% Layer 2 H-Bar Neuron Activation Function
l2_neuron_activation_function_h_bar_dnd = 100;
l2_neuron_activation_function_h_bar_bias = -58;
l2_neuron_activation_function_h_bar_res = 1000;
l2_neuron_weights_h_bar = ones(1, l0_interface_input_featureCnt)';
threshold = 0.5;

dnd = l2_neuron_activation_function_h_bar_dnd;
bias = l2_neuron_activation_function_h_bar_bias;
resolution = l2_neuron_activation_function_h_bar_res;

l2_neuron_activation_function_h_bar_x = linspace(-dnd, dnd, resolution)';
l2_neuron_activation_function_h_bar_y = SigmoidFunction(l2_neuron_activation_function_h_bar_x, bias);

x = l2_neuron_activation_function_h_bar_x;
y = l2_neuron_activation_function_h_bar_y;

subplot(2,2,1)
hold on
plot(x, y)
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('l2\_activation\_function\_h\_bar', 'FontWeight', 'bold')
xlabel('act. fct. input')
ylabel('act. fct. output')

[neuronNetTerms, neuronOutput] = GetNeuronOutput(l1_neuron_output_all(featureMiddleStart:featureMiddleEnd, 1:end)', l2_neuron_weights_h_bar, x, y);
if (neuronOutput > threshold)
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'g')
else
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'r')
end

l2_neuron_output_h_bar = neuronOutput;

clear x y bias resolution threshold dnd

%% Layer 2 V-Bar Neuron Activation Function
l2_neuron_activation_function_v_bar_dnd = 100;
l2_neuron_activation_function_v_bar_bias = -58;
l2_neuron_activation_function_v_bar_res = 1000;
l2_neuron_weights_v_bar = ones(1, l0_interface_input_featureCnt)';
threshold = 0.5;

dnd = l2_neuron_activation_function_v_bar_dnd;
bias = l2_neuron_activation_function_v_bar_bias;
resolution = l2_neuron_activation_function_v_bar_res;

l2_neuron_activation_function_v_bar_x = linspace(-dnd, dnd, resolution)';
l2_neuron_activation_function_v_bar_y = SigmoidFunction(l2_neuron_activation_function_v_bar_x, bias);

x = l2_neuron_activation_function_v_bar_x;
y = l2_neuron_activation_function_v_bar_y;

subplot(2,2,2)
plot(x, y)
hold on
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('l2\_activation\_function\_v\_bar', 'FontWeight', 'bold')
xlabel('act. fct. input')
ylabel('act. fct. output')

[neuronNetTerms, neuronOutput] = GetNeuronOutput(l1_neuron_output_all(1:end, featureMiddleStart:featureMiddleEnd), l2_neuron_weights_v_bar, x, y);
if (neuronOutput > threshold)
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'g')
else
   plot(sum(neuronNetTerms), neuronOutput, 'o', 'color', 'r')
end

l2_neuron_output_v_bar = neuronOutput;

clear x y bias resolution threshold dnd
%% Layer 2 E-Bar Neuron Activation Function
l2_neuron_activation_function_e_bar_dnd = 100;
l2_neuron_activation_function_e_bar_bias = 22;
l2_neuron_activation_function_e_bar_res = 1000;
l2_neuron_weights_e_bar = ones(16, 1);
threshold = 0.5;

dnd = l2_neuron_activation_function_e_bar_dnd;
bias = l2_neuron_activation_function_e_bar_bias;
resolution = l2_neuron_activation_function_e_bar_res;

l2_neuron_activation_function_e_bar_x = linspace(-dnd, dnd, resolution)';
l2_neuron_activation_function_e_bar_y = SigmoidFunction(l2_neuron_activation_function_e_bar_x, bias);

x = l2_neuron_activation_function_e_bar_x;
y = l2_neuron_activation_function_e_bar_y;

subplot(2,2,3)
plot(x, y)
hold on
line([-dnd dnd],[threshold threshold], 'color', 'y')
axis([x(1) x(end) min(y) max(y)])
title('l2\_activation\_function\_e\_bar', 'FontWeight', 'bold')
xlabel('act. fct. input')
ylabel('act. fct. output')

errorField1 = ConvMatrixToColumn(l1_neuron_output_all(1:2, 1:2));
errorField2 = ConvMatrixToColumn(l1_neuron_output_all(4:5, 1:2));
errorField3 = ConvMatrixToColumn(l1_neuron_output_all(1:2, 4:5));
errorField4 = ConvMatrixToColumn(l1_neuron_output_all(4:5, 4:5));

[neuronNetTerms1, neuronOutput1] = GetNeuronOutput(errorField1, l2_neuron_weights_e_bar(1:4), x, y);
[neuronNetTerms2, neuronOutput2] = GetNeuronOutput(errorField2, l2_neuron_weights_e_bar(5:8), x, y);
[neuronNetTerms3, neuronOutput3] = GetNeuronOutput(errorField3, l2_neuron_weights_e_bar(9:12), x, y);
[neuronNetTerms4, neuronOutput4] = GetNeuronOutput(errorField4, l2_neuron_weights_e_bar(13:16), x, y);

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

l2_neuron_output_e_bar = (neuronOutput1 + neuronOutput2 + neuronOutput3 + neuronOutput4)/4;

clear sz errorField1 errorField2 errorField3 errorField4 
clear neuronNetTerms1 neuronNetTerms2 neuronNetTerms3 neuronNetTerms4
clear neuronOutput1 neuronOutput2 neuronOutput3 neuronOutput4
clear dnd bias resolution threshold x y
clear neuronNetTerms neuronOutput

%% Layer 3 Interface Output

l3_interface_input = [l2_neuron_output_h_bar; l2_neuron_output_v_bar; l2_neuron_output_e_bar];

l3_interface_output = zeros(l0_interface_input_featureCnt, l0_interface_input_featureCnt);
l3_interface_h_bar_threshold = 1.5;
l3_interface_v_bar_threshold = 1.5;

h_thres = l3_interface_h_bar_threshold;
v_thres = l3_interface_v_bar_threshold;
if ((l2_neuron_output_h_bar + l2_neuron_output_e_bar) >= h_thres)
   l3_interface_output(featureMiddleStart:featureMiddleEnd, 1:end) = 1;
end

if ((l2_neuron_output_v_bar + l2_neuron_output_e_bar) >= v_thres)
   l3_interface_output(1:end, featureMiddleStart:featureMiddleEnd) = 1;
end

output_values_l3_summarized_pixel = 255*(1 - l3_interface_output);

subplot(2,2,4)
imshow(output_values_l3_summarized_pixel)
title('l3\_interface\_output', 'FontWeight', 'bold')
xlabel('feature x')
ylabel('feature y')

clear featureMiddleStart featureMiddleEnd h_thres v_thres

%% Check Results

if l0_interface_input_feature_matrix == l3_interface_output
   disp('Test successful')
else
   disp('Test not successful')
end

clear output_values_l2_summarized_pixel
%% save workspace

save('../datas_from_pre_simulation')