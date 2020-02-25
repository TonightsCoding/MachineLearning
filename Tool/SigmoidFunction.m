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
   
   if nargin == 1 % Funktion wird lediglich zur Ermittlung eines Wertes (y) auf Grundlage von (x) genutzt
       x = nice;
       x1 = -12;
       x2 = 12;
       y1 = -1;
       y2 = 1;
       bias = 0;
       y = 1./(1+exp(-(x+bias)));
       sigmoid = y;
       y = [];
   elseif nargin == 2 % 2 Inputs also Ermittelung eines Wertes (y) auf Grundlage von (x) und (bias)
       x = nice;
       bias = x1;
       x1 = -12;
       x2 = 12;
       y1 = -1;
       y2 = 1;       
       y = 1./(1+exp(-(x+bias)));
       sigmoid = y;
       y = [];
   elseif nargin == 3 % 3 Inputs: nice, x1 & x2 -> 1 Output: sigmoid der Länge nice
       if mod(nice, 1) ~= 0 % Test ob nice-Wert eine ganze Zahl ist
           error('Wert für "nice" muss ganzzahlig sein!');
       end
       x = [];
       y1 = -1;
       y2 = 1;
       bias = 0;
       sigmoid = zeros(nice,1);
       j=1;
       for i=linspace(x1, x2, nice)
           sigmoid(j) = 1./(1+exp(-(i+bias)));
           j = j + 1;
       end
       y = [];
   end
   if mod(nice, 1) ~= 0 % Test ob nice-Wert eine ganze Zahl ist
       error('Wert für "nice" muss ganzzahlig sein!');
   end
   %sigmoid = zeros(nice);
%    for i=x1:(x2-x1)/nice:x2
%        sigmoid(i-x1) = 1./(1+exp(-(i+bias)));
%    end
%    if -y1==y2 % Test ob symetrisch definiert -> keine Verschiebung in y notwendig nur skalieren
%        sigmoid = sigmoid .* y2;
%    end
   
   
   
   %y = 1./(1+exp(-(x+bias)));
end
