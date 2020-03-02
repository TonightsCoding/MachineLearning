clear all, close all
%% GaussNormFunction hat viele Varianten der Benutzung deswegen werden 
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
y1 = 0;
y2 = 1;
x = 0;
mue = 0;
sigma = 1;
% default-Werte fuer x1 und x2 gleich x1 und x2 
x1Default = x1;
x2Default = x2;
% defualt-Werte fuer x1 und x2 aus GaussNormFunction zur Veranschaulichung
% x1Default = -6;
% x2Default = 6;

%% Nach Anzahl der Inputs sortiert und anschliessend nach
% Anzahl der Outputs unterschieden

%% 1 Input
% 1 Output
% y = GaussNormFunction(x)
x11 = x;
% x11 = 0;
y = GaussNormFunction(x11);
disp(y); 

%% 2 Inputs
% 1 Output
% y = GaussNormFunction(x, sigma)
x21 = x;
sigma21 = sigma;
% x21 = 0;
% bias21 = 0;
y = GaussNormFunction(x21, sigma21);
disp(y); 
% 2 Output
% [gauss, y] = GaussNormFunction(nice, x)
nice22 = nice;
x22 = x;
% nice22 = 30;
% x22 = 0;
[gauss, y] = GaussNormFunction(nice22, x22);
disp(gauss);
disp(y); 
t = linspace(x1Default, x2Default, nice22);
figure
hold on
plot(t, gauss);
title(['2 Inputs "nice & x" -> 2 Outputs "gauss, y = ',num2str(y),'"']);

%% 3 Inputs
% 1 Output
% y = GaussNormFunction(x, sigma, mue)
x31 = x;
sigma31 = sigma;
mue31 = mue;
% x31 = 0;
% sigma31 = 1;
% mue31 = 0;
y = GaussNormFunction(x31, sigma31, mue31);
disp(y);
% 2 Output
% [gauss, y] = GaussNormFunction(nice, x, sigma)
nice32 = nice;
x32 = x;
sigma32 = sigma;
% nice32 = 30;
% x32 = 0;
% sigma32 = 1;
[gauss, y] = GaussNormFunction(nice32, x32, sigma32);
disp(gauss);
disp(y); 
t = linspace(x1Default, x2Default, nice32);
figure
hold on
plot(t, gauss);
title(['3 Inputs "nice, x & sigma" -> 2 Outputs "gauss, y = ',num2str(y),'"']);

%% 4 Inputs
% 1 Output
% gauss = GaussNormFunction(nice, x1, x2, sigma)
nice41 = nice;
x141 = x1;
x241 = x2;
sigma41 = sigma;
% nice41 = 30;
% x141 = -6;
% x241 = 6;
% sigma41 = 1;
gauss = GaussNormFunction(nice41, x141, x241, sigma41);
disp(gauss);
t = linspace(x141, x241, nice41);
figure
hold on
plot(t, gauss);
title('4 Inputs "nice, x1, x2 & sigma" -> 1 Outputs "gauss"');
% 2 Output
% [gauss, y] = GaussNormFunction(nice, x1, x2, x)
nice42 = nice;
x142 = x1;
x242 = x2;
x42 = x;
% nice42 = 30;
% x142 = -6;
% x242 = 6;
% x42 = 1;
[gauss, y] = GaussNormFunction(nice42, x142, x242, x42);
disp(gauss);
disp(y); 
t = linspace(x142, x242, nice42);
figure
hold on
plot(t, gauss);
title(['4 Inputs "nice, x1, x2 & x" -> 2 Outputs "gauss, y = ',num2str(y),'"']);

%% 5 Inputs
% 1 Output
% y = GaussNormFunction(y1, y2, x, sigma, mue)
y151 = y1;
y251 = y2;
x51 = x;
sigma51 = sigma;
mue51 = mue;
% y151 = 0;
% y251 = 1;
% x51 = 0;
% sigma51 = 1;
% mue51 = 0;
y = GaussNormFunction(y151, y251, x51, sigma51, mue51);
disp(y);
% 2 Output
% [gauss, y] = GaussNormFunction(nice, x1, x2, x, sigma)
nice52 = nice;
x152 = x1;
x252 = x2;
x52 = x;
sigma52 = sigma;
% nice52 = 30;
% x152 = -6;
% x252 = 6;
% x52 = 0;
% sigma52 = 1;
[gauss, y] = GaussNormFunction(nice52, x152, x252, x52, sigma52);
disp(gauss);
disp(y); 
t = linspace(x152, x252, nice52);
figure
hold on
plot(t, gauss);
title(['5 Inputs "nice, x1, x2, x & sigma" -> 2 Outputs "gauss, y = ',num2str(y),'"']);
                 
%% 6 Inputs
% 1 Output
% gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma)
nice61 = nice;
x161 = x1;
x261 = x2;
y161 = y1;
y261 = y2;
sigma61 = sigma;
% nice61 = 30;
% x161 = -6;
% x261 = 6;
% y161 = 1;
% y261 = 0;
% sigma61 = 1;
gauss = GaussNormFunction(nice61, x161, x261, y161, y261, sigma61);
disp(gauss);
t = linspace(x161, x261, nice61);
figure
hold on
plot(t, gauss);
title('6 Inputs "nice, x1, x2, y1, y2 & sigma" -> 1 Outputs "gauss"');
% 2 Output
% [gauss, y] = GaussNormFunction(nice, x1, x2, x, sigma, mue)
nice62 = nice;
x162 = x1;
x262 = x2;
x62 = x;
sigma62 = sigma;
mue62 = mue;
% nice62 = 30;
% x162 = -6;
% x262 = 6;
% x62 = 0;
% sigma62 = 1;
% mue62 = 0;
[gauss, y] = GaussNormFunction(nice62, x162, x262, x62, sigma62, mue62);
disp(gauss);
disp(y); 
t = linspace(x162, x262, nice62);
figure
hold on
plot(t, gauss);
title(['6 Inputs "nice, x1, x2, x, sigma & mue" -> 2 Outputs "gauss, y = ',num2str(y),'"']);

%% 7 Inputs
% 1 Output
% gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma, mue)
nice71 = nice;
x171 = x1;
x271 = x2;
y171 = y1;
y271 = y2;
sigma71 = sigma;
mue71 = mue;
% nice71 = 30;
% x171 = -6;
% x271 = 6;
% y171 = 0;
% y271 = 1;
% sigma71 = 1;
% mue71 = 0;
gauss = GaussNormFunction(nice71, x171, x271, y171, y271, sigma71, mue71);
disp(gauss);
t = linspace(x171, x271, nice71);
figure
hold on
plot(t, gauss);
title('7 Inputs "nice, x1, x2, y1, y2, sigma & mue)" -> 1 Outputs "gauss"');
% 2 Output
% [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma)
nice72 = nice;
x172 = x1;
x272 = x2;
y172 = y1;
y272 = y2;
x72 = x;
sigma72 = sigma;
% nice72 = 30;
% x172 = -6;
% x272 = 6;
% y172 = 1;
% y272 = 0;
% x72 = 0;
% sigma72 = 1;
[gauss, y] = GaussNormFunction(nice72, x172, x272, y172, y272, x72, sigma72);
disp(gauss);
disp(y); 
t = linspace(x172, x272, nice72);
figure
hold on
plot(t, gauss);
title(['7 Inputs "nice, x1, x2, y1, y2, x & sigma" -> 2 Outputs "gauss, y = ',num2str(y),'"']);

%% 8 Inputs
% 1 Output
% y = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)
nice81 = nice;
x181 = x1;
x281 = x2;
y181 = y1;
y281 = y2;
x81 = x;
sigma81 = sigma;
mue81 = mue;
% nice81 = 30;
% x181 = -6;
% x281 = 6;
% y181 = 0;
% y281 = 1;
% x81 = x;
% sigma81 = 1;
% mue81 = 0;
y = GaussNormFunction(nice81, x181, x281, y181, y281, x81, sigma81, mue81);
disp(y);
% 2 Output
% [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)
nice82 = nice;
x182 = x1;
x282 = x2;
y182 = y1;
y282 = y2;
x82 = x;
sigma82 = sigma;
mue82 = mue;
% nice82 = 30;
% x182 = -6;
% x282 = 6;
% y182 = 1;
% y282 = 0;
% x82 = 0;
% sigma82 = 1;
% mue82 = 0;
[gauss, y] = GaussNormFunction(nice82, x182, x282, y182, y282, x82, sigma82, mue82);
disp(gauss);
disp(y); 
t = linspace(x182, x282, nice82);
figure
hold on
plot(t, gauss);
title(['8 Inputs "nice, x1, x2, y1, y2, x, sigma & mue" -> 2 Outputs "gauss, y = ',num2str(y),'"']);
