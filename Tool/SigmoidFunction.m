function [sigmoid, y] = SigmoidFunction(nice, x1, x2, y1, y2, x, bias)
   % y - (optional) gibt einzelnen Wert im Punkt x zurueck
   % sigmoid - Vektor der Dimension (nice) mit den abgetasteten Funktionswerte
   
   % nice - Feinheit der Abtastung der Funktion, bestimmt Laenge von (sigmoid)
   % x1 - untere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte (default: -12)
   % x2 - obere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte (default: 12)
   % y1 - untere Grenze der Funktionswerte (y-Werte default: -1)
   % y2 - obere Grenze der Funktionswerte (y-Werte default: 1)
   % x - (optional) Variable fuer einzelnen Rueckgabewert der Funktion
   % bias - (optional) Verschiebung in x-Richtung (default: 0) -> Neg (rechts), Pos (links)
   
   
   
   
   y = 1./(1+exp(-(x+bias)));
end
