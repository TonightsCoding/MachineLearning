function [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
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
   
%% Definition:
% lin(x) = a*x+bias

% default-Werte
aDefault = 1;
biasDefault = 0;
x1Default = -6;
x2Default = 6;
xyminDefault = -3; % sinnvoll?
xymaxDefault = 3; % sinnvoll?

end

