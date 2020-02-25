clear all, close all
nice = 1000;
x1 = -12;
x2 = 12;
% y1 = -1;
% y2 = 1;
% x = 0;
% bias = 0;

y = SigmoidFunction(nice, x1, x2);
disp(y);
t = linspace(x1, x2, nice);
disp(t);
figure
hold on
plot(t, y);
%axis([t(1) t(end) min(y) max(y)])
%title('Sigmoidfunktion mit ausgewerteten Merkmalen')