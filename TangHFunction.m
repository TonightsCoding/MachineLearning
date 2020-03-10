function [tanH, y] = TangHFunction(nice, x1, x2, y1, y2, x, bias)
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
%% tanh(x)=1-(2/(exp(2x)+1)); % --> Umgesetzt da wahrscheinlich am schnellsten zu berechnen

   %% Wichtigste vollstaendige Funktionen
   % tanH = TangHFunction(nice, x1, x2, y1, y2, bias)
   % y = TangHFunction(y1, y2, x, bias)
   
       % Moegliche Nutzungen von TangHFunction: (Aeusserere Aufrufe)
       % y = TangHFunction(x)
       % y = TangHFunction(x, bias)
       % [tanH, y] = TangHFunction(nice, x)
       % tanH = TangHFunction(nice, x1, x2)
       % [tanH, y] = TangHFunction(nice, x, bias)
       % y = TangHFunction(y1, y2, x, bias) 
       % [tanH, y] = TangHFunction(nice, x1, x2, bias)
       % y = TangHFunction(x1, x2, y1, y2, x)
       % [tanH, y] = TangHFunction(nice, x1, x2, x, bias)
       % tanH = TangHFunction(nice, x1, x2, y1, y2, bias)
       % [tanH, y] = TangHFunction(nice, x1, x2, y1, y2, x)
       % y = TangHFunction(nice, x1, x2, y1, y2, x, bias)
       % [tanH, y] = TangHFunction(nice, x1, x2, y1, y2, x, bias)
       
% default-Werte
biasDefault = 0;
x1Default = -4;
x2Default = 4;

   %% Ab hier Unterscheidung je nach Anzahl der gegebenen Input- und Output-Werte   
   
   if nargin == 1  
       %% 1 Input-Wert gegeben
       % Funktion wird lediglich zur Ermittlung eines Wertes (y) auf Grundlage von (x) genutzt
       % Bei einem Input und Output-Wert wird keine Meldung ausgegeben
       % es werden fuer die nicht angegeben Argumente werden default-Werte gesetzt
       % y = TangHFunction(x) -> Aeusserer Aufruf
       % tanH = TangHFunction(nice) -> Innerer Aufruf
       if nargout == 1             
           x = nice;
           bias = biasDefault;
           tanH = 1-(2/(exp(2*x+bias)+1));
       
       % Mit einem Input-Wert koennen nicht beide Output-Werte sinnvoll bedient werden
       % [tanH, y] = TangHFunction(nice, x1)
       elseif nargout == 2   
           error('TangHFunction benoetigt mehr als einen Input-Wert fuer zwei Rueckgabewerte!');
       
       % Nicht definierte Anzahl an Rueckgabewerten
       % [tanH, y, ...] = TangHFunction(nice)       
       else
           error('TangHFunction kann bei einem Input-Wert nicht mehr als einen Output-Wert erzeugen!');
       end       
   
   elseif nargin == 2 
       %% 2 Input-Werte gegeben
       % 2 Input-Werte -> Unterscheidung nach Output-Anzahl notwendig
       
       % 1 Output-Wert -> Ermittelung eines Wertes (y) 
       % auf Grundlage von (x) und (bias) mit default-Werten
       % y = TangHFunction(x, bias) -> Aeusserer Aufruf
       % tanH = TangHFunction(nice, x1) -> Innerer Aufruf
       if nargout == 1      
          x = nice;
          bias = x1;       
          tanH = 1-(2/(exp(2*x+bias)+1));
          
       % 2 Output-Werte -> Rueckgabe eines Wertes (y) und des Vektors (tanH)
       % auf Grundlage von (x) und (nice) mit default-Werten
       % [tanH, y] = TangHFunction(nice, x) -> Auesserer Aufruf
       % [tanH, y] = TangHFunction(nice, x1) -> Innerer Aufruf
       elseif nargout == 2
           
           % Test ob nice-Wert eine ganze Zahl und groesser null ist
           if mod(nice, 1) ~= 0
               error('Wert fuer "nice" muss ganzzahlig sein!');
           elseif nice <= 0
               error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
           elseif nice <= 3
               warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
           end
           
           bias = biasDefault;
           x = x1;
           x1 = x1Default;
           x2 = x2Default;
           y = 1-(2/(exp(2*x+bias)+1));
           tanH = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               tanH(j) = 1-(2/(exp(2*i+bias)+1));
               j = j + 1;
           end
           
       else % obsolet da Matlab schon vorher eine Fehlermeldung erzeugt -> wird ab hier weggelassen
           error('TangHFunction kann bei zwei Input-Werten nicht mehr als zwei Output-Werte erzeugen!');
       end
   
   elseif nargin == 3
       %% 3 Input-Werte gegeben
       % 3 Input-Werte -> Unterscheidung nach Output-Anzahl notwendig
       % Fehlermeldung fuer mehr als 2 Outputs wird vernachlaessigt
       
       % Test ob nice-Wert eine ganze Zahl und groesser null ist
       if mod(nice, 1) ~= 0
           error('Wert fuer "nice" muss ganzzahlig sein!');
       elseif nice <= 0
           error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
       elseif nice <= 3
           warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
       end

       % 1 Output-Wert -> Ermittelung des tanH-Vektors 
       % auf Grundlage der Grenzen (x1) & (x2) mit Abtastung (nice)
       % tanH = TangHFunction(nice, x1, x2) -> Aeusserer & Innerer Aufruf
       if nargout == 1 
           
           % Gueltigkeit von x1 und x2 testen
           if x1 > x2
               error('TangHFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
           elseif x1 == x2
               error('TangHFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
           end
           
           bias = biasDefault;
           tanH = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               tanH(j) = 1-(2/(exp(2*i+bias)+1));
               j = j + 1;
           end
           
       % 2 Output-Werte -> Ermittelung des tanH-Vektors und eines Funktionswertes y
       % auf Grundlage der Feinheit (nice) und eines (bias) mit default-Werten und 
       % eines Eingangswertes (x) und eines (bias) mit default-Werten 
       % [tanH, y] = TangHFunction(nice, x, bias) -> Aeusserer Aufruf
       % [tanH, y] = TangHFunction(nice, x1, x2) -> Innerer Aufruf       
       elseif nargout == 2
           bias = x2;
           x = x1;
           x1 = x1Default;
           x2 = x2Default;
           tanH = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               tanH(j) = 1-(2/(exp(2*i+bias)+1));
               j = j + 1;
           end  
           y = 1-(2/(exp(2*x+bias)+1));
       end
          
   elseif nargin == 4 
       %% 4 Input-Werte gegeben
       
       % erste Zuweisung der uebergebenen Argumente zur Ueberpruefung bei
       % einem Output notwenidg
       bias = y1;
       x = x2;
       y2 = x1;
       y1 = nice;
       
       % 1 Output-Wert -> Ermittelung des Wertes y 
       % im Punkt von (x) skaliert auf die Grenzen (y1) & (y2) mit (bias)
       % y = TangHFunction(y1, y2, x, bias) -> Aeusserer Aufruf
       % tanH = TangHFunction(nice, x1, x2, y1) -> Innerer Aufruf
       if nargout == 1
           if y2 < y1
               error('Grenzen von TangHFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
           elseif y2 == y1
               error('Grenzen von TangHFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
           end
           
           y = 1-(2/(exp(2*x+bias)+1)); % y-Wert fuer nachfolgende Skalierung erzeugen
           
           if -y1==y2 % Test ob symetrisch definiert -> einfache Verschiebung in y notwendig & skalieren
               if y == 0 % y liegt im Koordinatenursprung
                   y = 0;
               else
                   y = y * y2; % gewuenschte Skalierung
               end
           else
               range = y2 - y1;
               y = y + 1; % Skalierung auf 0..2
               y = y / 2; % Skalierung auf 0..1
               y = y * range; % Skalierung auf 0..range bzw. 0..(y2-y1)
               y = y + y1; % Verschiebung auf y1..y2 bzw. (0+y1)..((y2-y1)+y1)
           end
           tanH = y;
           
       % 2 Output-Werte -> Ermittelung des tanH-Vektors auf Grundlage der Feinheit (nice) und den Grenzen (x1) und (x2)
       % Und Ermittelung eines Funktionswertes (y) auf Grundlage von (x) mit default-Werten 
       % [tanH, y] = TangHFunction(nice, x1, x2, x) -> Aeusserer Aufruf
       % [tanH, y] = TangHFunction(nice, x1, x2, y1) -> Innerer Aufruf
       elseif nargout == 2
           
           y1 = bias; % Erste Zuweisung vor 'nargout == 1' rueckgaengig machen
           x = y1;
           bias = biasDefault; % default-Wert einstellen
           
           % Test ob nice-Wert eine ganze Zahl und groesser null ist
           if mod(nice, 1) ~= 0
               error('Wert fuer "nice" muss ganzzahlig sein!');
           elseif nice <= 0
               error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
           elseif nice <= 3
               warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
           end
           
           % Gueltigkeit von x1 und x2 testen
           if x1 > x2
               error('TangHFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
           elseif x1 == x2
               error('TangHFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
           end
           
           y = 1-(2/(exp(2*x+bias)+1));
           tanH = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               tanH(j) = 1-(2/(exp(2*i+bias)+1));
               j = j + 1;
           end
       end   
   
   elseif nargin == 5 % [tanH, y] = TangHFunction(nice, x1, x2, y1, y2, x, bias)
       %% 5 Input-Werte gegeben
       
       % Ueberpruefung von nice, x1 & x2 fuer beide Output-Varianten notwendig
       % Test ob nice-Wert eine ganze Zahl und groesser null ist
       if mod(nice, 1) ~= 0
           error('Wert fuer "nice" muss ganzzahlig sein!');
       elseif nice <= 0
           error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
       elseif nice <= 3
           warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
       end
       
       % Gueltigkeit von x1 und x2 testen
       if x1 > x2
           error('TangHFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
       elseif x1 == x2
           error('TangHFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
       end
       
       % 1 Output-Wert -> Ermittelung des tanH-Vektors 
       % auf Grundlage der Grenzen (x1), (x2), (y1) & (y2) mit Abtastung (nice)
       % tanH = TangHFunction(nice, x1, x2, y1, y2) -> Aeusserer & Innerer Aufruf
       if nargout == 1
           
           if y2 < y1
               error('Grenzen von TangHFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
           elseif y2 == y1
               error('Grenzen von TangHFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
           end
           
           bias = biasDefault;
           tanH = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               tanH(j) = 1-(2/(exp(2*i+bias)+1));
               j = j + 1;
           end
           
           if -y1==y2 % Test ob symetrisch definiert -> einfache Verschiebung in y notwendig & skalieren
               tanH = tanH * y2; % gewuenschte Skalierung
           else
               range = y2 - y1;
               tanH = tanH + 1; % Skalierung auf 0..2
               tanH = tanH / 2; % Skalierung auf 0..1
               tanH = tanH * range; % Skalierung auf 0..range bzw. 0..(y2-y1)
               tanH = tanH + y1; % Verschiebung auf y1..y2 bzw. (0+y1)..((y2-y1)+y1)
           end
                      
       % 2 Output-Werte -> Ermittelung des tanH-Vektors und eines Funktionswertes y
       % auf Grundlage der Feinheit (nice), eines Eingangswertes (x) und eines (bias) 
       % [tanH, y] = TangHFunction(nice, x1, x2, x, bias) -> Aeusserer Aufruf
       % [tanH, y] = TangHFunction(nice, x1, x2, y1, y2) -> Innerer Aufruf
       elseif nargout == 2
           x = y1;
           bias = y2;
           y = 1-(2/(exp(2*x+bias)+1));
           tanH = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               tanH(j) = 1-(2/(exp(2*i+bias)+1));
               j = j + 1;
           end           
       end
          
   elseif nargin == 6 
       %% 6 Input-Werte gegeben
       
       % Ueberpruefung von nice, x1 & x2 fuer beide Output-Varianten notwendig
       % Test ob nice-Wert eine ganze Zahl und groesser null ist
       if mod(nice, 1) ~= 0
           error('Wert fuer "nice" muss ganzzahlig sein!');
       elseif nice <= 0
           error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
       elseif nice <= 3
           warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
       end
       
       % Gueltigkeit von x1 und x2 testen
       if x1 > x2
           error('TangHFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
       elseif x1 == x2
           error('TangHFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
       end
       
       % 1 Output-Wert -> Ermittelung des tanH-Vektors (mit allen notwendig Parametern) 
       % auf Grundlage der Grenzen (x1), (x2), (y1) & (y2) mit Abtastung (nice) und (bias)
       % tanH = TangHFunction(nice, x1, x2, y1, y2, bias) -> Aeusserer Aufruf
       % tanH = TangHFunction(nice, x1, x2, y1, y2, x) -> Innerer Aufruf
       if nargout == 1
           
           if y2 < y1
               error('Grenzen von TangHFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
           elseif y2 == y1
               error('Grenzen von TangHFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
           end
           
           bias = x;
           tanH = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               tanH(j) = 1-(2/(exp(2*i+bias)+1));
               j = j + 1;
           end
           
           if -y1==y2 % Test ob symetrisch definiert -> einfache Skalierung
               tanH = tanH * y2; % gewuenschte Skalierung
           else
               range = y2 - y1;
               tanH = tanH + 1; % Skalierung auf 0..2
               tanH = tanH / 2; % Skalierung auf 0..1
               tanH = tanH * range; % Skalierung auf 0..range bzw. 0..(y2-y1)
               tanH = tanH + y1; % Verschiebung auf y1..y2 bzw. (0+y1)..((y2-y1)+y1)
           end
           
       % 2 Output-Werte -> Ermittelung des tanH-Vektors und eines Funktionswertes y
       % auf Grundlage der Feinheit (nice) in den Grenzen (x1), (x2), (y1) & (y2) und eines Eingangswertes (x) 
       % [tanH, y] = TangHFunction(nice, x1, x2, y1, y2, x) -> Aeusserer & Innerer Aufruf
       elseif nargout == 2
           
           % default bias setzten
           bias = biasDefault;
           % y & tanH fuer nachfolgende Skalierung erzeugen
           y = 1-(2/(exp(2*x+bias)+1)); 
           tanH = zeros(nice,1);
           j=1;
           for i=linspace(x1, x2, nice)
               tanH(j) = 1-(2/(exp(2*i+bias)+1));
               j = j + 1;
           end
           if y2 < y1
               error('Grenzen von TangHFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
           elseif y2 == y1
               error('Grenzen von TangHFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
           end 
           
           if -y1==y2 % Test ob symetrisch definiert -> einfache Verschiebung in y notwendig & skalieren
               if y == 0 % y liegt im Koordinatenursprung
                   y = 0;
               else
                   y = y * y2; % gewuenschte Skalierung
               end
               tanH = tanH * y2; % gewuenschte Skalierung
           else
               range = y2 - y1;
               y = y + 1; % Skalierung auf 0..2
               y = y / 2; % Skalierung auf 0..1
               y = y * range; % Skalierung auf 0..range bzw. 0..(y2-y1)
               y = y + y1; % Verschiebung auf y1..y2 bzw. (0+y1)..((y2-y1)+y1)
               tanH = tanH + 1; % Skalierung auf 0..2
               tanH = tanH / 2; % Skalierung auf 0..1
               tanH = tanH * range; % Skalierung auf 0..range bzw. 0..(y2-y1)
               tanH = tanH + y1; % Verschiebung auf y1..y2 bzw. (0+y1)..((y2-y1)+y1)
           end
           
       end
          
   elseif nargin == 7 
       %% 7 Input-Werte gegeben
       
       % 1 Output-Wert -> Ermittelung eines Funktionswertes y mit allen Parametern angegeben
       % y = TangHFunction(nice, x1, x2, y1, y2, x, bias) -> Aeusserer Aufruf
       % tanH = TangHFunction(nice, x1, x2, y1, y2, x, bias) -> Innerer Aufruf
       if nargout == 1
           
           % gleich zu (4 Inputs -> 1 Output) da nice, x1 & x2 nicht
           % beruecksichtigt werden bzw. fuer y keine Rolle spielen
           tanH = TangHFunction(y1, y2, x, bias);
           
       % 2 Output-Werte -> Ermittelung des tanH-Vektors und eines Funktionswertes y
       % auf Grundlage der Feinheit (nice), eines Eingangswertes (x) und eines (bias) 
       % [tanH, y] = TangHFunction(nice, x1, x2, y1, y2, x, bias) -> Innerer & Aeusserer Aufruf
       elseif nargout == 2
           
           % gleich zu (4 Inputs -> 1 Output) da nice, x1 & x2 nicht
           % beruecksichtigt werden bzw. fuer y keine Rolle spielen
           y = TangHFunction(y1, y2, x, bias);
           
           % gleich zu (6 Inputs -> 1 Output) da x in tanH keine Rolle spielt
           tanH = TangHFunction(nice, x1, x2, y1, y2, bias);           
       end
          
   else 
       %% Andere Inputs ausser 1..7 sind ungueltig
       error('Ungueltige Anzahl Inputs fuer TangHFunction!');
   end

end

