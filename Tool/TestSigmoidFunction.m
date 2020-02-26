clear all, close all
%% SigmoidFunction hat viele Varianten der Benutzung deswegen werden 
%% diese Varianten folgend angegeben: 

%% Anzahl Input(s)

%     % Anzahl Output(s)
%     % Funktionsrumpf
%     % Variablen fuer Anpassungen
%     Funktionsaufruf
%     Ausgabe beziehungsweise Veranschaulichung der Ergebnisse

% Variablen fuer alle Funktionen setzten
nice = 30;
x1 = -15;
x2 = 15;
y1 = -1;
y2 = 1;
x = 0;
bias = 0;

% Nach Anzahl der Inputs sortiert und anschliessend nach
% Anzahl der Outputs unterschieden

%% 1 Input

% 1 Output
% y = SigmoidFunction(x)
y = SigmoidFunction(x);
disp(y);


%% 2 Inputs

% 1 Output
% y = SigmoidFunction(x, bias)
y = SigmoidFunction(x, bias);
disp(y);

% 2 Outputs
% [sigmoid, y] = SigmoidFunction(nice, x)
% nice = 15;
% x = 0;
[sigmoid, y] = SigmoidFunction(nice, x);
disp(sigmoid);
disp(y);
t = linspace(-12, 12, nice);
figure
hold on
plot(t, sigmoid);
title(['2 Inputs "nice, x" -> 2 Outputs "sigmoid, y = ',num2str(y),'"']);

%% 3 Inputs

% 1 Output
% sigmoid = SigmoidFunction(nice, x1, x2)
% nice = 15;
% x1 = -12;
% x2 = 12;
sigmoid = SigmoidFunction(nice, x1, x2);
disp(sigmoid);
t = linspace(x1, x2, nice);
figure
hold on
plot(t, sigmoid);
title('3 Inputs "nice, x1, x2" -> 1 Output "sigmoid"');

% 2 Outputs
% [sigmoid, y] = SigmoidFunction(nice, x, bias)
% nice = 15;
% x = 0;
% bias = 0;
[sigmoid, y] = SigmoidFunction(nice, x, bias);
disp(sigmoid);
disp(y);
t = linspace(-12, 12, nice);
figure
hold on
plot(t, sigmoid);
title(['3 Inputs "nice, x, bias" -> 2 Outputs "sigmoid, y = ',num2str(y),'"']);

%% 4-Inputs

% 1-Outputs
% y = SigmoidFunction(y1, y2, x, bias)
y = SigmoidFunction(0, 1, 0, 0);
disp(y);

% 2-Outputs
% [sigmoid, y] = SigmoidFunction(nice, x1, x2, x)
% nice = 15;
% x1 = -15;
% x2 = 15;
% x = 0;
[sigmoid, y] = SigmoidFunction(nice, x1, x2, x);
disp(sigmoid);
disp(y);
t = linspace(x1, x2, nice);
figure
hold on
plot(t, sigmoid);
title(['4 Inputs "nice, x1, x2, x" -> 2 Outputs "sigmoid, y = ',num2str(y),'"']);

%% 5-Inputs

% 1 Output
% sigmoid = SigmoidFunction(nice, x1, x2, y1, y2)
% nice = 30;
% x1 = -15;
% x2 = 15;
% y1 = -1;
% y2 = 1;
sigmoid = SigmoidFunction(nice, x1, x2, y1, y2);
disp(sigmoid);
t = linspace(x1, x2, nice);
figure
hold on
plot(t, sigmoid);
title('5 Inputs "nice, x1, x2, y1, y2" -> 1 Output "sigmoid"');

% 2 Outputs
% [sigmoid, y] = SigmoidFunction(nice, x1, x2, x, bias)
% nice = 30;
% x1 = -15;
% x2 = 15;
% x = 0;
% bias = 0;
[sigmoid, y] = SigmoidFunction(nice, x1, x2, x, bias);
disp(sigmoid);
disp(y);
t = linspace(x1, x2, nice);
figure
hold on
plot(t, sigmoid);
title(['5 Inputs "nice, x1, x2, x, bias" -> 2 Outputs "sigmoid, y = ',num2str(y),'"']);

%% 6-Inputs

% 1 Output
% sigmoid = SigmoidFunction(nice, x1, x2, y1, y2, bias)
% nice = 30;
% x1 = -15;
% x2 = 15;
% y1 = -1;
% y2 = 1;
% bias = 5;
sigmoid = SigmoidFunction(nice, x1, x2, y1, y2, bias);
disp(sigmoid);
t = linspace(x1, x2, nice);
figure
hold on
plot(t, sigmoid);
title('6 Inputs "nice, x1, x2, y1, y2, bias" -> 1 Output "sigmoid"');

% 2 Outputs
% [sigmoid, y] = SigmoidFunction(nice, x1, x2, y1, y2, x)
% nice = 30;
% x1 = -15;
% x2 = 15;
% y1 = -1;
% y2 = 1;
% x = 0;
[sigmoid, y] = SigmoidFunction(nice, x1, x2, y1, y2, x);
disp(sigmoid);
disp(y);
t = linspace(x1, x2, nice);
figure
hold on
plot(t, sigmoid);
title(['6 Inputs "nice, x1, x2, y1, y2, x" -> 2 Outputs "sigmoid, y = ',num2str(y),'"']);

%% 7-Inputs

% 1 Output
% y = SigmoidFunction(nice, x1, x2, y1, y2, x, bias)
% nice = 30;
% x1 = -15;
% x2 = 15;
% y1 = -1;
% y2 = 1;
% x = 0;
% bias = 0;
y = SigmoidFunction(nice, x1, x2, y1, y2, x, bias);
disp(y);

% 2 Outputs
% [sigmoid, y] = SigmoidFunction(nice, x1, x2, y1, y2, x, bias)
% nice = 30;
% x1 = -15;
% x2 = 15;
% y1 = -1;
% y2 = 1;
% x = 0;
% bias = 0;
[sigmoid, y] = SigmoidFunction(nice, x1, x2, y1, y2, x, bias);
disp(sigmoid);
disp(y);
t = linspace(x1, x2, nice);
figure
hold on
plot(t, sigmoid);
title(['7 Inputs "nice, x1, x2, y1, y2, x" -> 2 Outputs "sigmoid, y = ',num2str(y),'"']);
