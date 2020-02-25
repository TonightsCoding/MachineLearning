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
   
       % Moegliche Nutzungen von SigmoidFunction: (Aeusserere Aufrufe)
       % y = SigmoidFunction(x)
       % y = SigmoidFunction(x, bias)
       % [sigmoid, y] = SigmoidFunction(nice, x)
       % sigmoid = SigmoidFunction(nice, x1, x2)
       % [sigmoid, y] = SigmoidFunction(nice, x, bias)
   
%%% Noch zu testen ob die ungenutzten default-Werte wirklich gesetzt
%%% werden muessen... ist zum einarbeiten wahrscheinlich gut @(den Elter) :P
%%% Ja koennen weggelassen werden aber dieser Kommetar bleibt stehen bis in
%%% der Elter loescht ;)

   
   % Ab hier Unterscheidung je nach Anzahl der gegebenen Input- und Output-Werte
   
   % 1 Input-Wert gegeben
   if nargin == 1  
       
       % Funktion wird lediglich zur Ermittlung eines Wertes (y) auf Grundlage von (x) genutzt
       % Bei einem Input und Output-Wert wird keine Meldung ausgegeben
       % es werden fuer die nicht angegeben Argumente werden default-Werte gesetzt
       % y = SigmoidFunction(x)
       if nargout == 1             
           x = nice;
           bias = 0;
           y = 1./(1+exp(-(x+bias)));
       
       % Mit einem Input-Wert koennen nicht beide Output-Werte sinnvoll bedient werden
       % [sigmoid, y] = SigmoidFunction(nice, x1)
       elseif nargout == 2   
           error('SigmoidFunction benoetigt mehr als einen Input-Wert fuer zwei Rueckgabewerte!');
       
       % Nicht definierte Anzahl an Rueckgabewerten
       % [sigmoid, y, ...] = SigmoidFunction(nice)       
       else
           error('SigmoidFunction kann bei einem Input-Wert nicht mehr als einen Output-Wert erzeugen!');
       end
       
   % 2 Input-Werte gegeben
   elseif nargin == 2       
       % 2 Input-Werte -> Unterscheidung nach Output-Anzahl notwendig
       
       % 1 Output-Wert -> Ermittelung eines Wertes (y) 
       % auf Grundlage von (x) und (bias) mit default-Werten
       % y = SigmoidFunction(x, bias) -> Aeusserer Aufruf
       % sigmoid = SigmoidFunction(nice, x1) -> Innerer Aufruf
       if nargout == 1      
          x = nice;
          bias = x1;       
          sigmoid = 1./(1+exp(-(x+bias)));
          
       % 2 Output-Werte -> Rueckgabe eines Wertes (y) und des Vektors (sigmoid)
       % auf Grundlage von (x) und (nice) mit default-Werten
       % [sigmoid, y] = SigmoidFunction(nice, x)
       elseif nargout == 2
           
           % Test ob nice-Wert eine ganze Zahl ist
           if mod(nice, 1) ~= 0
               error('Sigmoid-Funktion-Wert für "nice" muss ganzzahlig sein!');
           end
          
          bias = 0;
          x = x1;
          x1 = -12;
          x2 = 12;       
          y = 1./(1+exp(-(x+bias)));
          sigmoid = zeros(nice,1);
          j=1;
          for i=linspace(x1, x2, nice)
              sigmoid(j) = 1./(1+exp(-(i+bias)));
              j = j + 1;
          end
          
       else % obsolet da Matlab schon vorher eine Fehlermeldung erzeugt -> wird ab hier weggelassen
           error('SigmoidFunction kann bei zwei Input-Werten nicht mehr als zwei Output-Werte erzeugen!');   
       end
   
   % 3 Input-Werte gegeben
   elseif nargin == 3 
       % 3 Input-Werte -> Unterscheidung nach Output-Anzahl notwendig
       % Fehlermeldung fuer mehr als 2 Outputs wird vernachlaessigt
       
       % Test ob nice-Wert eine ganze Zahl ist
       if mod(nice, 1) ~= 0 
           error('Sigmoid-Funktion-Wert für "nice" muss ganzzahlig sein!');
       end
       
       % 3 Inputs: nice, x1 & x2 -> 1 Output: sigmoid der Länge nice
       % 3 Inputs: nice, x & bias -> 2 Output: sigmoid der Länge nice & x
       % Wert

       % 1 Output-Wert -> Ermittelung des sigmoid-Vektors 
       % auf Grundlage der Grenzen (x1) & (x2) mit Abtastung (nice)
       % sigmoid = SigmoidFunction(nice, x1, x2) -> Aeusserer & Innerer Aufruf
       if nargout == 1 
           bias = 0;
           sigmoid = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               sigmoid(j) = 1./(1+exp(-(i+bias)));
               j = j + 1;
           end
           
       % 2 Output-Werte -> Ermittelung des sigmoid-Vektors und eines Funktionswertes y
       % auf Grundlage der Feinheit (nice), eines Eingangswertes (x) und eines (bias) 
       % [sigmoid, y] = SigmoidFunction(nice, x, bias) -> Aeusserer Aufruf
       % [sigmoid, y] = SigmoidFunction(nice, x1, x2) -> Innerer Aufruf       
       elseif nargout == 2
           bias = x2;
           x = x1;
           sigmoid = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               sigmoid(j) = 1./(1+exp(-(i+bias)));
               j = j + 1;
           end  
           y = 1./(1+exp(-(x+bias)));
       end
   %elseif nargin == 4 %HIER WEITERMACHEN
   end
   
%    if mod(nice, 1) ~= 0 % Test ob nice-Wert eine ganze Zahl ist
%        error('Wert für "nice" muss ganzzahlig sein!');
%    end
%    sigmoid = zeros(nice);
%    for i=x1:(x2-x1)/nice:x2
%        sigmoid(i-x1) = 1./(1+exp(-(i+bias)));
%    end
% 
%    Fuer die Skalierung spaeter
%    if -y1==y2 % Test ob symetrisch definiert -> keine Verschiebung in y notwendig nur skalieren
%        sigmoid = sigmoid .* y2;
%    end
   
   
   
   %y = 1./(1+exp(-(x+bias)));
end
