clear all, close all

termMatrix = [1:4; 5:8; 9:12; 13:16];
matrix = [termMatrix*1, termMatrix*2 termMatrix*3; 
         termMatrix*4, termMatrix*5, termMatrix*6; 
         termMatrix*7, termMatrix*8, termMatrix*9];

GetFeatureOfMatrix(matrix, 3, 3, 4, 3)