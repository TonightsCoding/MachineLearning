clear all, close all
%% TangHFunction hat viele Varianten der Benutzung deswegen werden 
%% diese Varianten folgend angegeben: 

%% Anzahl Input(s)
%     % Anzahl Output(s)
%     % Funktionsrumpf
%     Variablen default-Werte zuweisen
%     % Variablen fuer Anpassungen
%     Funktionsaufruf
%     Ausgabe beziehungsweise Veranschaulichung der Ergebnisse

%% Variablen fuer alle Funktionen setzten
nice = 30;
x1 = -6;
x2 = 6;
y1 = -1;
y2 = 1;
x = 0;
bias = 0;
% default-Werte fuer x1 und x2 gleich x1 und x2 
x1Default = x1;
x2Default = x2;
% defualt-Werte fuer x1 und x2 aus TangHFunction zur Veranschaulichung
% x1Default = -4;
% x2Default = 4;

%% Nach Anzahl der Inputs sortiert und anschliessend nach
% Anzahl der Outputs unterschieden

%% 1 Input
% 1 Output
% y = TangHFunction(x)
x11 = x;
% x11 = 0;
y = TangHFunction(x11);
disp(y);

%% 2 Inputs
% 1 Output
% y = TangHFunction(x, bias)
x21 = x;
bias21 = bias;
% x21 = 0;
% bias21 = 0;
y = TangHFunction(x21, bias21);
disp(y);
% 2 Outputs
% [tanH, y] = TangHFunction(nice, x)
nice22 = nice;
x22 = x;
% nice22 = 15;
% x22 = 0;
[tanH, y] = TangHFunction(nice22, x22);
disp(tanH);
disp(y);
t = linspace(x1Default, x2Default, nice22);
figure
hold on
plot(t, tanH);
title(['2 Inputs "nice, x" -> 2 Outputs "tanH, y = ',num2str(y),'"']);

%% 3 Inputs
% 1 Output
% tanH = TangHFunction(nice, x1, x2)
nice31 = nice;
x131 = x1;
x231 = x2;
% nice31 = 15;
% x131 = -12;
% x231 = 12;
tanH = TangHFunction(nice31, x131, x231);
disp(tanH);
t = linspace(x131, x231, nice31);
figure
hold on
plot(t, tanH);
title('3 Inputs "nice, x1, x2" -> 1 Output "tanH"');
% 2 Outputs
% [tanH, y] = TangHFunction(nice, x, bias)
nice32 = nice;
x32 = x;
bias32 = bias;
% nice32 = 15;
% x32 = 0;
% bias = 0;
[tanH, y] = TangHFunction(nice32, x32, bias32);
disp(tanH);
disp(y);
t = linspace(x1Default, x2Default, nice);
figure
hold on
plot(t, tanH);
title(['3 Inputs "nice, x, bias" -> 2 Outputs "tanH, y = ',num2str(y),'"']);

%% 4-Inputs
% 1-Outputs
% y = TangHFunction(y1, y2, x, bias)
y141 = y1;
y241 = y2;
x41 = x;
bias41 = bias;
% y141 = -1;
% y241 = 1;
% x41 = 0;
% bias41 = 0;
y = TangHFunction(y141, y241, x41, bias41);
disp(y);
% 2-Outputs
% [tanH, y] = TangHFunction(nice, x1, x2, x)
nice42 = nice;
x142 = x1;
x242 = x2;
x42 = x;
% nice42 = 15;
% x142 = -15;
% x242 = 15;
% x42 = 0;
[tanH, y] = TangHFunction(nice42, x142, x242, x42);
disp(tanH);
disp(y);
t = linspace(x142, x242, nice42);
figure
hold on
plot(t, tanH);
title(['4 Inputs "nice, x1, x2, x" -> 2 Outputs "tanH, y = ',num2str(y),'"']);

%% 5-Inputs
% 1 Output
% tanH = TangHFunction(nice, x1, x2, y1, y2)
nice51 = nice;
x151 = x1;
x251 = x2;
y151 = y1;
y251 = y2;
% nice51 = 30;
% x151 = -15;
% x251 = 15;
% y151 = -1;
% y251 = 1;
tanH = TangHFunction(nice51, x151, x251, y151, y251);
disp(tanH);
t = linspace(x151, x251, nice51);
figure
hold on
plot(t, tanH);
title('5 Inputs "nice, x1, x2, y1, y2" -> 1 Output "tanH"');
% 2 Outputs
% [tanH, y] = TangHFunction(nice, x1, x2, x, bias)
nice52 = nice;
x152 = x1;
x252 = x2;
x52 = x;
bias52 = bias;
% nice52 = 30;
% x152 = -15;
% x252 = 15;
% x52 = 0;
% bias52 = 0;
[tanH, y] = TangHFunction(nice52, x152, x252, x52, bias52);
disp(tanH);
disp(y);
t = linspace(x152, x252, nice52);
figure
hold on
plot(t, tanH);
title(['5 Inputs "nice, x1, x2, x, bias" -> 2 Outputs "tanH, y = ',num2str(y),'"']);

%% 6-Inputs
% 1 Output
% tanH = TangHFunction(nice, x1, x2, y1, y2, bias)
nice61 = nice;
x161 = x1;
x261 = x2;
y161 = y1;
y261 = y2;
bias61 = bias;
% nice61 = 30;
% x161 = -15;
% x261 = 15;
% y161 = -1;
% y261 = 1;
% bias61 = 5;
tanH = TangHFunction(nice61, x161, x261, y161, y261, bias61);
disp(tanH);
t = linspace(x161, x261, nice61);
figure
hold on
plot(t, tanH);
title('6 Inputs "nice, x1, x2, y1, y2, bias" -> 1 Output "tanH"');
% 2 Outputs
% [tanH, y] = TangHFunction(nice, x1, x2, y1, y2, x)
nice62 = nice;
x162 = x1;
x262 = x2;
y162 = y1;
y262 = y2;
x62 = x;
% nice62 = 30;
% x162 = -15;
% x262 = 15;
% y162 = -1;
% y262 = 1;
% x62 = 0;
[tanH, y] = TangHFunction(nice62, x162, x262, y162, y262, x62);
disp(tanH);
disp(y);
t = linspace(x162, x262, nice62);
figure
hold on
plot(t, tanH);
title(['6 Inputs "nice, x1, x2, y1, y2, x" -> 2 Outputs "tanH, y = ',num2str(y),'"']);

%% 7-Inputs
% 1 Output
% y = TangHFunction(nice, x1, x2, y1, y2, x, bias)
nice71 = nice;
x171 = x1;
x271 = x2;
y171 = y1;
y271 = y2;
x71 = x;
bias71 = bias;
% nice71 = 30;
% x171 = -15;
% x271 = 15;
% y171 = -1;
% y271 = 1;
% x71 = 0;
% bias71 = 0;
y = TangHFunction(nice71, x171, x271, y171, y271, x71, bias71);
disp(y);
% 2 Outputs
% [tanH, y] = TangHFunction(nice, x1, x2, y1, y2, x, bias)
nice72 = nice;
x172 = x1;
x272 = x2;
y172 = y1;
y272 = y2;
x72 = x;
bias72 = bias;
% nice72 = 30;
% x172 = -15;
% x272 = 15;
% y172 = -1;
% y272 = 1;
% x72 = 0;
% bias72 = 0;
[tanH, y] = TangHFunction(nice72, x172, x272, y172, y272, x72, bias72);
disp(tanH);
disp(y);
t = linspace(x172, x272, nice72);
figure
hold on
plot(t, tanH);
title(['7 Inputs "nice, x1, x2, y1, y2, x" -> 2 Outputs "tanH, y = ',num2str(y),'"']);
