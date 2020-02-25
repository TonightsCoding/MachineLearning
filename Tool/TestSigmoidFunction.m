clear all, close all
nice = 0;
x1 = -12;
x2 = 12;
% y1 = -1;
% y2 = 1;
x = 2;
% bias = 0;

% Zum Testen eventuell [] fuer ungenutzte Parameter eintragen?

sig = zeros(1, nice);
y = SigmoidFunction(10, 2, 0);
disp(y);
disp(sig);
% t = linspace(x1, x2, nice);
% disp(t);
% figure
% hold on
% plot(t, y);