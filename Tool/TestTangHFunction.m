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
x1 = -4;
x2 = 4;
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