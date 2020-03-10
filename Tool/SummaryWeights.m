close all, clear all

% Parameter
pixelCnt = 8;
featureCnt = 5;
weightType = 'Mul2';
slope = 100;
lowerBound = -1;
upperBound = 1;

weightMatrix = GetGaussWeights(pixelCnt, featureCnt, slope, weightType, lowerBound, upperBound);

bild1 = figure;
mesh(weightMatrix)
title(strcat('Gewichtsmatrix (', weightType, '),' , ' Slope=', int2str(slope)))

saveas(bild1, strcat('Gewichtsmatrix_', weightType, '_' , 'Slope_', int2str(slope), '.png'));
saveas(bild1, strcat('Gewichtsmatrix_', weightType, '_' , 'Slope_', int2str(slope), '.pdf'));
saveas(bild1, strcat('Gewichtsmatrix_', weightType, '_' , 'Slope_', int2str(slope), '.eps'));