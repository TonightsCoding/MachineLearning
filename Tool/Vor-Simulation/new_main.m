close all, clear all
figure, hold on

% explainations of variables
% activiation_function_dnd - activiation_function_domain-of_defintion

%% Global Parameter
pixelCnt = 8;
featureCnt = 5;

%% Input-Feature-Matrix
input_feature_type = 'Cross';    % {Cross, V_Line, H_Line, Cal}
noise = 30;
inputFeatureMatrix = GetInputFeatureMatrix(featureCnt, input_feature_type);

subplot(2,2,2)
inputPixelFeatureMatrix = GetPixelFeatureMatrix(pixelCnt, featureCnt, noise, inputFeatureMatrix, '');
imshow(inputPixelFeatureMatrix)
title('Input-Feature-Matrix')

inputMatrix = (255 - inputPixelFeatureMatrix)/255;
%% Weight-Matrix
weightType = 'AddMul';          % {Add, AddMul, Mul, Special}
lowerBound = -1;
upperBound = 1;
slope = 30;
weightMatrix = GetGaussWeights(pixelCnt, featureCnt, slope, weightType, lowerBound, upperBound); 


subplot(2,2,1)
mesh(weightMatrix)
title('Weight-Matrix')

%% Activation-Function_Layer-1_Neuron-XX

%% new figure temp
figure


%% Activation-Function_Layer-2_Neuron_V-Bar
activiation_function_l2_h_bar_dnd = 100;
activation_function_l2_h_bar_bias = -58;
activation_function_l2_h_bar_threshold = 0.5;

activation_function_l2_h_bar_x = -activiation_function_l2_h_bar_dnd:0.01:activiation_function_l2_h_bar_dnd;
activation_function_l2_h_bar_y = SigmoidFunction(activation_function_l2_h_bar_x, activation_function_l2_h_bar_bias);

subplot(2,2,1)
plot(activation_function_l2_h_bar_x,activation_function_l2_h_bar_y)
line([-activiation_function_l2_h_bar_dnd activiation_function_l2_h_bar_dnd],[activation_function_l2_h_bar_threshold activation_function_l2_h_bar_threshold], 'color', 'y')
axis([activation_function_l2_h_bar_x(1) activation_function_l2_h_bar_x(end) min(activation_function_l2_h_bar_y) max(activation_function_l2_h_bar_y)])
title('Activation-Function\_Layer-2\_H-Bar')

%% Activation-Function_Layer-2_Neuron_V-Bar
activiation_function_l2_v_bar_dnd = 100;
activation_function_l2_v_bar_bias = -22;
activation_function_l2_v_bar_threshold = 0.5;

activation_function_l2_v_bar_x = -activiation_function_l2_v_bar_dnd:0.01:activiation_function_l2_v_bar_dnd;
activation_function_l2_v_bar_y = SigmoidFunction(activation_function_l2_h_bar_x, activation_function_l2_v_bar_bias);

subplot(2,2,2)
plot(activation_function_l2_v_bar_x,activation_function_l2_v_bar_y)
line([-activiation_function_l2_v_bar_dnd activiation_function_l2_v_bar_dnd],[activation_function_l2_v_bar_threshold activation_function_l2_v_bar_threshold], 'color', 'y')
axis([activation_function_l2_v_bar_x(1) activation_function_l2_v_bar_x(end) min(activation_function_l2_v_bar_y) max(activation_function_l2_v_bar_y)])
title('Activation-Function\_Layer-2\_V-Bar')

%% Activation-Function_Layer-2_Neuron_E-Bar
activiation_function_l2_e_bar_dnd = 100;
activation_function_l2_e_bar_bias = -58;
activation_function_l2_e_bar_threshold = 0.5;

activation_function_l2_e_bar_x = -activiation_function_l2_e_bar_dnd:0.01:activiation_function_l2_e_bar_dnd;
activation_function_l2_e_bar_y = SigmoidFunction(activation_function_l2_h_bar_x, activation_function_l2_e_bar_bias);

subplot(2,2,3)
plot(activation_function_l2_e_bar_x,activation_function_l2_e_bar_y)
line([-activiation_function_l2_e_bar_dnd activiation_function_l2_e_bar_dnd],[activation_function_l2_e_bar_threshold activation_function_l2_e_bar_threshold], 'color', 'y')
axis([activation_function_l2_e_bar_x(1) activation_function_l2_e_bar_x(end) min(activation_function_l2_e_bar_y) max(activation_function_l2_e_bar_y)])
title('Activation-Function\_Layer-2\_E-Bar')