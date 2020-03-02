function [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
%% Funktionsdefinition
%     { y1       x <= xymin
% y = { a*x+bias
%     { y2       x >= xymax

   % y - (optional) gibt einzelnen Wert im Punkt x zurueck
   % lin - Vektor der Dimension (nice) mit den abgetasteten Funktionswerte
   
   % nice - Feinheit der Abtastung der Funktion, bestimmt Laenge von (lin) (Empfehlung >> 3)
   % a - Steigung der Funktion (default: 1)
   % x1 - untere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (lin) (default: -6)
   % x2 - obere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (lin) (default: 6)
   % xymin - Punkt (x-Wert) ab dem (lin) minimalen Wert y1 hat (default: -3)
   % xymax - Punkt (x-Wert) ab dem (lin) maximalen Wert y2 hat (default: 3)
   % y1 - untere Grenze der Funktionswerte, gilt fuer y und/oder lin (y-Werte default: -1)
   % y2 - obere Grenze der Funktionswerte, gilt fuer y und/oder lin (y-Werte default: 1)
   % x - (optional) Variable fuer einzelnen Rueckgabewert der Funktion
   % bias - (optional) Verschiebung in x-Richtung, gilt fuer y und/oder lin (default: 0) -> Neg (rechts), Pos (links)
   
   %% Wichtigste vollstaendige Funktionen
   % y = LinearFunction(a, xymin, xymax, y1, y2, x, bias)
   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, bias)
   
        % Moegliche Nutzungen von LinearFunction
        % 1:1   % y = LinearFunction(x)
        % 1:2   % y = LinearFunction(a, x) 
        % 2:2   % [lin, y] = LinearFunction(nice, x)
        % 1:3   % y = LinearFunction(a, x, bias)
        % 2:3   % [lin, y] = LinearFunction(nice, a, x)
        % 1:4   % lin = LinearFunction(nice, a, x1, x2)
        % 2:4   % [lin, y] = LinearFunction(nice, a, x, bias)
        % 1:5   % y = LinearFunction(a, y1, y2, x, bias)
        % 2:5   % [lin, y] = LinearFunction(nice, a, x1, x2, x)
        % 1:6   % lin = LinearFunction(nice, a, x1, x2, y1, y2)
        % 2:6   % [lin, y] = LinearFunction(nice, a, x1, x2, x, bias)
        % 1:7   % y = LinearFunction(a, xymin, xymax, y1, y2, x, bias)
        % 2:7   % [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x)
        % 1:8   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2)
        % 2:8   % [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x, bias)
        % 1:9   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, bias)
        % 2:9   % [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x)
        % 1:10  % y = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
        % 2:10  % [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
       
% default-Werte
aDefault = 1;
biasDefault = 0;
x1Default = -6;
x2Default = 6;
xyminDefault = -3; % sinnvoll?
xymaxDefault = 3; % sinnvoll?

end

