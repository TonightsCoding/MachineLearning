clear all, close all
%% RayleighFunction hat viele Varianten der Benutzung deswegen werden 
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
x1 = 0;
x2 = 10;
y1 = 0;
y2 = 1;
x = 1;
sigma = 1;
bias = 0;
% default-Werte fuer x1 und x2 gleich x1 und x2 
x1Default = x1;
x2Default = x2;
% defualt-Werte fuer x1 und x2 aus RayleighFunction zur Veranschaulichung
% x1Default = 0;
% x2Default = 12;

%% Nach Anzahl der Inputs sortiert und anschliessend nach
% Anzahl der Outputs unterschieden

%% 1 Input
% 1 Output
% y = RayleighFunction(x)
x11 = x;
% x11 = 0;
y = RayleighFunction(x11);
disp(y); 

%% 2 Inputs
% 1 Output
% y = RayleighFunction(x, sigma)
x21 = x;
sigma21 = sigma;
% x21 = 1;
% bias21 = 0;
y = RayleighFunction(x21, sigma21);
disp(y); 
% 2 Output
% [ray, y] = RayleighFunction(nice, x)
nice22 = nice;
x22 = x;
% nice22 = 30;
% x22 = 1;
[ray, y] = RayleighFunction(nice22, x22);
disp(ray);
disp(y); 
t = linspace(x1Default, x2Default, nice22);
figure
hold on
plot(t, ray);
title(['2 Inputs "nice & x" -> 2 Outputs "ray, y = ',num2str(y),'"']);

%% 3 Inputs
% 1 Output
% y = RayleighFunction(x, sigma, bias)
x31 = x;
sigma31 = sigma;
bias31 = bias;
% x31 = 1;
% sigma31 = 1;
% bias31 = 0;
y = RayleighFunction(x31, sigma31, bias31);
disp(y);
% 2 Output
% [ray, y] = RayleighFunction(nice, x, sigma)
nice32 = nice;
x32 = x;
sigma32 = sigma;
% nice32 = 30;
% x32 = 1;
% sigma32 = 1;
[ray, y] = RayleighFunction(nice32, x32, sigma32);
disp(ray);
disp(y); 
t = linspace(x1Default, x2Default, nice32);
figure
hold on
plot(t, ray);
title(['3 Inputs "nice, x & sigma" -> 2 Outputs "ray, y = ',num2str(y),'"']);

%% 4 Inputs
% 1 Output
% ray = RayleighFunction(nice, x1, x2, sigma)
nice41 = nice;
x141 = x1;
x241 = x2;
sigma41 = sigma;
% nice41 = 30;
% x141 = 0;
% x241 = 12;
% sigma41 = 1;
ray = RayleighFunction(nice41, x141, x241, sigma41);
disp(ray);
t = linspace(x141, x241, nice41);
figure
hold on
plot(t, ray);
title('4 Inputs "nice, x1, x2 & sigma" -> 1 Outputs "ray"');
% 2 Output
% [ray, y] = RayleighFunction(nice, x1, x2, x)
nice42 = nice;
x142 = x1;
x242 = x2;
x42 = x;
% nice42 = 30;
% x142 = 0;
% x242 = 12;
% x42 = 1;
[ray, y] = RayleighFunction(nice42, x142, x242, x42);
disp(ray);
disp(y); 
t = linspace(x142, x242, nice42);
figure
hold on
plot(t, ray);
title(['4 Inputs "nice, x1, x2 & x" -> 2 Outputs "ray, y = ',num2str(y),'"']);

%% 5 Inputs
% 1 Output
% y = RayleighFunction(y1, y2, x, sigma, bias)
y151 = y1;
y251 = y2;
x51 = x;
sigma51 = sigma;
bias51 = bias;
% y151 = 0;
% y251 = 1;
% x51 = 1;
% sigma51 = 1;
% bias51 = 0;
y = RayleighFunction(y151, y251, x51, sigma51, bias51);
disp(y);
% 2 Output
% [ray, y] = RayleighFunction(nice, x1, x2, x, sigma)
nice52 = nice;
x152 = x1;
x252 = x2;
x52 = x;
sigma52 = sigma;
% nice52 = 30;
% x152 = 0;
% x252 = 12;
% x52 = 1;
% sigma52 = 1;
[ray, y] = RayleighFunction(nice52, x152, x252, x52, sigma52);
disp(ray);
disp(y); 
t = linspace(x152, x252, nice52);
figure
hold on
plot(t, ray);
title(['5 Inputs "nice, x1, x2, x & sigma" -> 2 Outputs "ray, y = ',num2str(y),'"']);
                 
%% 6 Inputs
% 1 Output
% ray = RayleighFunction(nice, x1, x2, y1, y2, sigma)
nice61 = nice;
x161 = x1;
x261 = x2;
y161 = y1;
y261 = y2;
sigma61 = sigma;
% nice61 = 30;
% x161 = 0;
% x261 = 12;
% y161 = 1;
% y261 = 0;
% sigma61 = 1;
ray = RayleighFunction(nice61, x161, x261, y161, y261, sigma61);
disp(ray);
t = linspace(x161, x261, nice61);
figure
hold on
plot(t, ray);
title('6 Inputs "nice, x1, x2, y1, y2 & sigma" -> 1 Outputs "ray"');
% 2 Output
% [ray, y] = RayleighFunction(nice, x1, x2, x, sigma, bias)
nice62 = nice;
x162 = x1;
x262 = x2;
x62 = x;
sigma62 = sigma;
bias62 = bias;
% nice62 = 30;
% x162 = 0;
% x262 = 12;
% x62 = 1;
% sigma62 = 1;
% bias62 = 0;
[ray, y] = RayleighFunction(nice62, x162, x262, x62, sigma62, bias62);
disp(ray);
disp(y); 
t = linspace(x162, x262, nice62);
figure
hold on
plot(t, ray);
title(['6 Inputs "nice, x1, x2, x, sigma & bias" -> 2 Outputs "ray, y = ',num2str(y),'"']);

%% 7 Inputs
% 1 Output
% ray = RayleighFunction(nice, x1, x2, y1, y2, sigma, bias)
nice71 = nice;
x171 = x1;
x271 = x2;
y171 = y1;
y271 = y2;
sigma71 = sigma;
bias71 = bias;
% nice71 = 30;
% x171 = 0;
% x271 = 12;
% y171 = 0;
% y271 = 1;
% sigma71 = 1;
% bias71 = 0;
ray = RayleighFunction(nice71, x171, x271, y171, y271, sigma71, bias71);
disp(ray);
t = linspace(x171, x271, nice71);
figure
hold on
plot(t, ray);
title('7 Inputs "nice, x1, x2, y1, y2, sigma & bias)" -> 1 Outputs "ray"');
% 2 Output
% [ray, y] = RayleighFunction(nice, x1, x2, y1, y2, x, sigma)
nice72 = nice;
x172 = x1;
x272 = x2;
y172 = y1;
y272 = y2;
x72 = x;
sigma72 = sigma;
% nice72 = 30;
% x172 = 0;
% x272 = 12;
% y172 = 1;
% y272 = 0;
% x72 = 1;
% sigma72 = 1;
[ray, y] = RayleighFunction(nice72, x172, x272, y172, y272, x72, sigma72);
disp(ray);
disp(y); 
t = linspace(x172, x272, nice72);
figure
hold on
plot(t, ray);
title(['7 Inputs "nice, x1, x2, y1, y2, x & sigma" -> 2 Outputs "ray, y = ',num2str(y),'"']);

%% 8 Inputs
% 1 Output
% y = RayleighFunction(nice, x1, x2, y1, y2, x, sigma, bias)
nice81 = nice;
x181 = x1;
x281 = x2;
y181 = y1;
y281 = y2;
x81 = x;
sigma81 = sigma;
bias81 = bias;
% nice81 = 30;
% x181 = 0;
% x281 = 12;
% y181 = 0;
% y281 = 1;
% x81 = 1;
% sigma81 = 1;
% bias81 = 0;
y = RayleighFunction(nice81, x181, x281, y181, y281, x81, sigma81, bias81);
disp(y);
% 2 Output
% [ray, y] = RayleighFunction(nice, x1, x2, y1, y2, x, sigma, bias)
nice82 = nice;
x182 = x1;
x282 = x2;
y182 = y1;
y282 = y2;
x82 = x;
sigma82 = sigma;
bias82 = bias;
% nice82 = 30;
% x182 = 0;
% x282 = 12;
% y182 = 1;
% y282 = 0;
% x82 = 1;
% sigma82 = 1;
% bias82 = 0;
[ray, y] = RayleighFunction(nice82, x182, x282, y182, y282, x82, sigma82, bias82);
disp(ray);
disp(y); 
t = linspace(x182, x282, nice82);
figure
hold on
plot(t, ray);
title(['8 Inputs "nice, x1, x2, y1, y2, x, sigma & bias" -> 2 Outputs "ray, y = ',num2str(y),'"']);
