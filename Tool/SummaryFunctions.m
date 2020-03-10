close all, clear all

% Feinheit fuer alle Functions einstellen
nice = 1000;

% Default-Werte aller Functions
x1TanHDefault = -4;
x2TanHDefault = 4;
x1RayDefault = 0;
x2RayDefault = 6;
sigmaRayDefault = 1;
x1SigDefault = -8;
x2SigDefault = 8;
x1GaussDefault = 0;
x2GaussDefault = 6;
sigmaGaussDefault = 1;
y1GaussDefault = 0; 
y2GaussDefault = 0; 
mueGaussDefault = 0;
aLinDefault = 1;
x1LinDefault = -6;
x2LinDefault = 6; 
xyminLinDefault = -1;
xymaxLinDefault = 1;
y1LinDefault = -1; 
y2LinDefault = 1; 
biasDefault = 0;

% 1. Function: TangensHyperbolicus 
% Parameter
x1TanH = -4;
x2TanH = 4;
tanH = TangHFunction(nice, x1TanH, x2TanH);
xAxis = linspace(x1TanH, x2TanH, nice);
functionType = 'TangensHyperbolicus';

tanHBild = figure;
plot(xAxis, tanH);
grid on
title(['Function (', functionType,')']);

% Bild in unterschiedlichen Formaten speichern
saveas(tanHBild, ['Function_', functionType, '.png']);
saveas(tanHBild, ['Function_', functionType, '.pdf']);
saveas(tanHBild, ['Function_', functionType, '.eps']);

% 2. Function: Rayleigh 
% Parameter
x1Ray = 0;
x2Ray = 6;
sigmaRay = 1;
ray = RayleighFunction(nice, x1Ray, x2Ray, sigmaRay);
xAxis = linspace(x1Ray, x2Ray, nice);
functionType = 'Rayleigh';

rayBild = figure;
plot(xAxis, ray);
grid on
title(['Function (', functionType,')']);

% Bild in unterschiedlichen Formaten speichern
saveas(rayBild, ['Function_', functionType, '.png']);
saveas(rayBild, ['Function_', functionType, '.pdf']);
saveas(rayBild, ['Function_', functionType, '.eps']);

% 3. Function: Sigmoid 
% Parameter
x1Sig = -8;
x2Sig = 8;
sig = SigmoidFunction(nice, x1Sig, x2Sig);
xAxis = linspace(x1Sig, x2Sig, nice);
functionType = 'Sigmoid';

sigBild = figure;
plot(xAxis, sig);
grid on
title(['Function (', functionType,')']);

% Bild in unterschiedlichen Formaten speichern
saveas(sigBild, ['Function_', functionType, '.png']);
saveas(sigBild, ['Function_', functionType, '.pdf']);
saveas(sigBild, ['Function_', functionType, '.eps']);

% 4. Function: Gauss 
% Parameter
x1Gauss = -5;
x2Gauss = 5;
sigmaGauss = 1;
y1Gauss = 0; 
y2Gauss = 1; 
mueGauss = 0;
gauss = GaussNormFunction(nice, x1Gauss, x2Gauss, y1GaussDefault, y2GaussDefault, sigmaGauss, mueGauss);
xAxis = linspace(x1Gauss, x2Gauss, nice);
functionType = 'Gauss';

gaussBild = figure;
plot(xAxis, gauss);
grid on
title(['Function (', functionType,')']);

% Bild in unterschiedlichen Formaten speichern
saveas(gaussBild, ['Function_', functionType, '.png']);
saveas(gaussBild, ['Function_', functionType, '.pdf']);
saveas(gaussBild, ['Function_', functionType, '.eps']);

% 5. Function: Linear 
% Parameter
aLin = 1;
x1Lin = -3;
x2Lin = 3;
xyminLin = -1;
xymaxLin = 1;
y1Lin = -1; 
y2Lin = 1; 
bias = 0;
lin = LinearFunction(nice, aLin, x1Lin, x2Lin, xyminLin, xymaxLin, y1Lin, y2Lin, bias);
xAxis = linspace(x1Lin, x2Lin, nice);
functionType = 'Linear';

linBild = figure;
plot(xAxis, lin);
grid on
title(['Function (', functionType,')']);

% Bild in unterschiedlichen Formaten speichern
saveas(linBild, ['Function_', functionType, '.png']);
saveas(linBild, ['Function_', functionType, '.pdf']);
saveas(linBild, ['Function_', functionType, '.eps']);