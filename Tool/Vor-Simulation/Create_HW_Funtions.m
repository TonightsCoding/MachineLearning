clear all, close all

%% Sigmoid-Function
figure, hold on
sigmoid_function_x = linspace(-8,8,1000)';
sigmoid_function_y = SigmoidFunction(1000, -8, 8, 0, 1, 0);
plot(sigmoid_function_x, sigmoid_function_y)

%% Linear-Function
figure, hold on
linear_function_x = linspace(-50, 50, 1000)';
linear_function_y = linear_function_x;
plot(linear_function_x, linear_function_y)

%% save as
save('../hw_funtions')