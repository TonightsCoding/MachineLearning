function [tanH, y] = TangensHFunction(nice, x1, x2, y1, y2, x, bias)
   % y - (optional) gibt einzelnen Wert im Punkt x zurueck
   % tanH - Vektor der Dimension (nice) mit den abgetasteten Funktionswerte
   
   % nice - Feinheit der Abtastung der Funktion, bestimmt Laenge von (tanH) (Empfehlung >> 3)
   % x1 - untere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (tanH) (default: -4)
   % x2 - obere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (tanH) (default: 4)
   % y1 - untere Grenze der Funktionswerte, gilt fuer y und/oder tanH (y-Werte default: -1)
   % y2 - obere Grenze der Funktionswerte, gilt fuer y und/oder tanH (y-Werte default: 1)
   % x - (optional) Variable fuer einzelnen Rueckgabewert der Funktion
   % bias - (optional) Verschiebung in x-Richtung, gilt fuer y und/oder tanH (default: 0) -> Neg (rechts), Pos (links)
   
%% Definitionsvarianten:
% tanh(x)=sinh(x)/cosh(x);
% tanh(x)=(exp(x)-exp(-x))/(exp(x)+exp(-x));
% tanh(x)=(exp(2x)-1)/(exp(2x)+1);
%% tanh(x)=1-(2/(exp(2x)+1)); % --> Mein Favorit da wahrscheinlich am schnellsten zu berechnen

% default-Werte
biasDefault = 0;
x1Default = -4;
x2Default = 4;
y1Default = -1;
y2Default = 1;
end

