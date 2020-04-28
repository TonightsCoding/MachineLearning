function [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
    %% Funktionsdefinition
    %     { y1       x <= xymin
    % y = { a*x+bias
    %     { y2       x >= xymax
    % xymin && xymax == 0 	->	xymin && xymax wird ignoriert
    % y1 && y2 == 0 	->	keine Saklierung   
    
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
       % 1:9   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, bias)
       % 1:7   % lin = LinearFunction(nice, a, x1, x2, y1, y2, bias)   
       % 1:3   % y = LinearFunction(a, x, bias)
       % 1:10  % y = LinearFunction(0, a, 0, 0, xymin, xymax, y1, y2, x, bias) 
       % 1:10  mit: (nice && x1 && x2) == 0 -> erzeugt vollstaendiges y, da 1:7 bereits vergeben  
    
            % Moegliche Nutzungen von LinearFunction											
            % 1:1   % y = LinearFunction(x)														% == 1:2 mit: aDefault 
            % 1:2   % y = LinearFunction(a, x) 													% == 1:3 mit: biasDefault
            % 2:2   % [lin, y] = LinearFunction(nice, x)										% == (1:4 mit: aDefault, x1Default, x2Default) && 1:1  
            % 1:3   % y = LinearFunction(a, x, bias)											%
            % 2:3   % [lin, y] = LinearFunction(nice, a, x)										% == 2:4 mit: biasDefault
            % 1:4   % lin = LinearFunction(nice, a, x1, x2)										% == 1:6 mit: y1 && y2 == 0
            % 2:4   % [lin, y] = LinearFunction(nice, a, x, bias)								% == (1:7 mit: x1Default, x2Default, y1 && y2 == 0 ) && 1:3
            % 1:5   % lin = LinearFunction(nice, a, x1, x2, bias)								% 
            % 2:5   % [lin, y] = LinearFunction(nice, a, x1, x2, x)								% == 1:4 && 1:2
            % 1:6   % lin = LinearFunction(nice, a, x1, x2, y1, y2)								% == 1:7 mit: biasDefault
            % 2:6   % [lin, y] = LinearFunction(nice, a, x1, x2, x, bias)						% == (1:7 mit: y1 && y2 == 0) && 1:3
            % 1:7   % lin = LinearFunction(nice, a, x1, x2, y1, y2, bias)						% 
            % 2:7   % [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x)						% == (1:7 mit: biasDefault) && (1:3 mit: biasDeafault)
            % 1:8   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2)				% == 1:9 mit: biasDefault
            % 2:8   % [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x, bias)				% == 1:7 && 1:10 
            % 1:9   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, bias)			% == 1:7 Auswertung von: xymin && xymax
            % 2:9   % [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x)		% == 2:10 mit: biasDefault
            % 1:10  % y = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)		% 
            % 2:10  % [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)	% == 1:9 && 1:10
           
    % default-Werte
    aDefault = 1;
    biasDefault = 0;
    x1Default = -6;
    x2Default = 6;
    
       %% Ab hier Unterscheidung je nach Anzahl der gegebenen Input- und Output-Werte 
       
       if nargin == 1
           %% 1 Input-Wert gegeben
           % 1 Output
           if nargout == 1
               % 1:1   % y = LinearFunction(x)
               x = nice;
               y = LinearFunction(aDefault, x);
               lin = y;
           else
               error('LinearFunction kann mit einem Input "x" nur einen Output "y" erzeugen!');
           end
           
       elseif nargin == 2
           %% 2 Input-Werte gegeben
           % 1 Output
           if nargout == 1
               % 1:2   % y = LinearFunction(a, x)
               x = a;
               a = nice;
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               y = LinearFunction(a, x, biasDefault);
               lin = y;
           % 2 Outputs
           elseif nargout == 2
               % 2:2   % [lin, y] = LinearFunction(nice, x)
               if mod(nice, 1) ~= 0
                   error('Wert fuer "nice" muss ganzzahlig sein!');
               elseif nice <= 0
                   error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
               elseif nice <= 3
                   warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
               end
               x = a;
               y = aDefault*x+biasDefault;
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1Default, x2Default, nice)
                   lin(j) = aDefault*i+biasDefault;
                   j = j + 1;
               end
           end
           
       elseif nargin == 3
           %% 3 Input-Werte gegeben
           % 1 Output
           if nargout == 1
               % 1:3   % y = LinearFunction(a, x, bias)
               x = a;
               a = nice;
               bias = x1;
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               y = a*x+bias;
               lin = y;       
           % 2 Outputs
           elseif nargout == 2
               % 2:3   % [lin, y] = LinearFunction(nice, a, x)
               if mod(nice, 1) ~= 0
                   error('Wert fuer "nice" muss ganzzahlig sein!');
               elseif nice <= 0
                   error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
               elseif nice <= 3
                   warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
               end
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               x = x1;
               y = a*x+biasDefault;
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1Default, x2Default, nice)
                   lin(j) = a*i+biasDefault;
                   j = j + 1;
               end
           end
           
       elseif nargin == 4
           %% 4 Input-Werte gegeben
           % 1 Output
           if nargout == 1
               % 1:4   % lin = LinearFunction(nice, a, x1, x2)
               if mod(nice, 1) ~= 0
                   error('Wert fuer "nice" muss ganzzahlig sein!');
               elseif nice <= 0
                   error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
               elseif nice <= 3
                   warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
               end
               if x1 > x2
                   error('LinearFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
               elseif x1 == x2
                   error('LinearFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
               end
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   lin(j) = a*i;
                   j = j + 1;
               end
           % 2 Outputs
           elseif nargout == 2
               % 2:4   % [lin, y] = LinearFunction(nice, a, x, bias)
               if mod(nice, 1) ~= 0
                   error('Wert fuer "nice" muss ganzzahlig sein!');
               elseif nice <= 0
                   error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
               elseif nice <= 3
                   warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
               end
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               x = x1;
               bias = x2;
               y = a*x+bias;
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1Default, x2Default, nice)
                   lin(j) = a*i+bias;
                   j = j + 1;
               end
           end
           
       elseif nargin == 5
           %% 5 Input-Werte gegeben
           % 1 Output
           if nargout == 1
               % 1:5   % lin = LinearFunction(nice, a, x1, x2, bias)
               if mod(nice, 1) ~= 0
                   error('Wert fuer "nice" muss ganzzahlig sein!');
               elseif nice <= 0
                   error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
               elseif nice <= 3
                   warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
               end
               if x1 > x2
                   error('LinearFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
               elseif x1 == x2
                   error('LinearFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
               end
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               bias = xymin;
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   lin(j) = a*i+bias;
                   j = j + 1;
               end
           % 2 Outputs
           elseif nargout == 2
               % 2:5   % [lin, y] = LinearFunction(nice, a, x1, x2, x)
               if mod(nice, 1) ~= 0
                   error('Wert fuer "nice" muss ganzzahlig sein!');
               elseif nice <= 0
                   error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
               elseif nice <= 3
                   warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
               end
               if x1 > x2
                   error('LinearFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
               elseif x1 == x2
                   error('LinearFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
               end
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               x = xymin;
               y = a*x;
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   lin(j) = a*i;
                   j = j + 1;
               end
           end
           
       elseif nargin == 6
           %% 6 Input-Werte gegeben
           % 1 Output
           if nargout == 1
               % 1:6   % lin = LinearFunction(nice, a, x1, x2, y1, y2)
               y1 = xymin;
               y2 = xymax;
               if mod(nice, 1) ~= 0
                   error('Wert fuer "nice" muss ganzzahlig sein!');
               elseif nice <= 0
                   error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
               elseif nice <= 3
                   warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
               end
               if x1 > x2
                   error('LinearFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
               elseif x1 == x2
                   error('LinearFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
               end
               if y2 < y1
                   error('Grenzen von LinearFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
               elseif y2 == y1
                   error('Grenzen von LinearFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
               end
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   lin(j) = a*i;
                   j = j + 1;
               end
               maxTemp = max(lin);
               minTemp = min(lin);
               if y2 == -y1
                   lin = lin./maxTemp;
                   lin = lin.*y2;
               else
                   range = y2 - y1;
                   lin = lin - minTemp;
                   rangeTemp = maxTemp - minTemp;
                   lin = lin./rangeTemp;
                   lin = lin.*range;
                   lin = lin + y1;
               end           
           % 2 Outputs
           elseif nargout == 2
               % 2:6   % [lin, y] = LinearFunction(nice, a, x1, x2, x, bias)
               x = xymin;
               bias = xymax;
               if mod(nice, 1) ~= 0
                   error('Wert fuer "nice" muss ganzzahlig sein!');
               elseif nice <= 0
                   error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
               elseif nice <= 3
                   warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
               end
               if x1 > x2
                   error('LinearFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
               elseif x1 == x2
                   error('LinearFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
               end
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               y = a*x+bias;
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   lin(j) = a*i+bias;
                   j = j + 1;
               end
           end
           
       elseif nargin == 7
           %% 7 Input-Werte gegeben       
           % Ueberpruefung der Eingangswerte ausser y1 && y2
           if mod(nice, 1) ~= 0
               error('Wert fuer "nice" muss ganzzahlig sein!');
           elseif nice <= 0
               error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
           elseif nice <= 3
               warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
           end       
           if x1 > x2
               error('LinearFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
           elseif x1 == x2
               error('LinearFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
           end  
           if a < 0
               error('Steigung von LinearHFunction ist nur positiv definiert!');
           end
           bias = y1;
           x = y1;
           y2 = xymax;
           y1 = xymin;
           if y2 < y1
               error('Grenzen von LinearFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');    
           elseif y1 == 0 && y2 == 0
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   lin(j) = a*i+bias;
                   j = j + 1;
               end
               if nargout == 2
                   % 2:7   % [lin, y] = LinearFunction(nice, a, x1, x2, 0, 0, x)
                   lin = lin - bias;
                   y = a*x;
               end
           elseif y2 == y1
               error('Grenzen von LinearFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
           else
               % 1 Output
               if nargout == 1
                   % 1:7   % lin = LinearFunction(nice, a, x1, x2, y1, y2, bias)
                   lin = zeros(nice,1);
                   j=1;
                   aTemp = (y2-y1)/(x2-x1);
                   biasTemp = y1+aTemp*-x1;
                   if aTemp ~= a
                       warning(['Grenzen passen nicht mit Steigung zusammen! a gewaehlt: ', num2str(a), ', a berechnet: ', num2str(aTemp)]);
                   end
                   if biasTemp ~= bias
                       warning(['Grenzen passen nicht mit bias zusammen! bias gewaehlt: ', num2str(bias), ', bias berechnet: ', num2str(biasTemp)]);
                   end
                   for i=linspace(x1, x2, nice)
                       lin(j) = aTemp*i+biasTemp;
                       j = j + 1;
                   end
               % 2 Outputs
               elseif nargout == 2
                   % 2:7   % [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x)
                   lin = zeros(nice,1);
                   j=1;
                   aTemp = (y2-y1)/(x2-x1);
                   biasTemp = y1+aTemp*-x1;
                   if aTemp ~= a
                       warning(['Grenzen passen nicht mit Steigung zusammen! a gewaehlt: ', num2str(a), ', a berechnet: ', num2str(aTemp)]);
                   end
                   if biasTemp ~= bias
                       warning(['Grenzen passen nicht mit bias zusammen! bias gewaehlt: ', num2str(bias), ', bias berechnet: ', num2str(biasTemp)]);
                   end
                   for i=linspace(x1, x2, nice)
                       lin(j) = aTemp*i+biasTemp;
                       j = j + 1;
                   end
                   y = aTemp*x+biasTemp;
               end
           end
           
       elseif nargin == 8
           %% 8 Input-Werte gegeben
           % 1 Output
           if nargout == 1
               % 1:8   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2)
               lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, biasDefault);
           % 2 Outputs
           elseif nargout == 2
               % 2:8   % [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x, bias)     
               bias = y2;
               x = y2;
               y1 = xymin;
               y2 = xymax;
               if mod(nice, 1) ~= 0
                   error('Wert fuer "nice" muss ganzzahlig sein!');
               elseif nice <= 0
                   error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
               elseif nice <= 3
                   warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
               end           
               if x1 > x2
                   error('LinearFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
               elseif x1 == x2
                   error('LinearFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
               end           
               if y2 < y1
                   error('Grenzen von LinearFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
               elseif y2 == y1
                   error('Grenzen von LinearHFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
               end
               if a < 0
                   error('Steigung von LinearHFunction ist nur positiv definiert!');
               end
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   lin(j) = a*i+bias;
                   if lin(j) <= y1
                       lin(j) = y1;
                   elseif lin(j) >= y2
                       lin(j) = y2;
                   end
                   j = j + 1;
               end
               y = a*x+bias;
               if y <= y1
                   y = y1;
               elseif y >= y2
                   y = y2;
               end
           end
           
       elseif nargin == 9
           %% 9 Input-Werte gegeben
           if mod(nice, 1) ~= 0
               error('Wert fuer "nice" muss ganzzahlig sein!');
           elseif nice <= 0
               error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
           elseif nice <= 3
               warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
           end
           if x1 > x2
               error('LinearFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
           elseif x1 == x2
               error('LinearFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
           end 
           if xymin > xymax
               error('LinearFunction Minimal-Wert "xymin" darf nicht groesser als Maximal-Wert "xymax" sein!');
           elseif x1 == x2
               error('LinearFunction Minimal-Wert "xymin" darf nicht gleich Maximal-Wert "xymax" sein!');
           end
           if y2 < y1
               error('Grenzen von LinearFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
           elseif y2 == y1
               error('Grenzen von LinearHFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
           end
           if a < 0
               error('Steigung von LinearHFunction ist nur positiv definiert!');
           end
           bias = x;
           % 1 Output
           if nargout == 1
           % 1:9   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, bias)
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   if i <= xymin
                       lin(j) = y1;
                   elseif i >= xymax
                       lin(j) = y2;
                   else
                       lin(j) = a*i+bias;
                   end
                   if lin(j) <= y1
                       lin(j) = y1;
                   elseif lin(j) >= y2
                       lin(j) = y2;
                   end               
                   j = j + 1;
               end      
           % 2 Outputs
           elseif nargout == 2
           % 2:9   % [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x)
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   if i <= xymin
                       lin(j) = y1;
                   elseif i >= xymax
                       lin(j) = y2;
                   else
                       lin(j) = a*i;
                   end
                   if lin(j) <= y1
                       lin(j) = y1;
                   elseif lin(j) >= y2
                       lin(j) = y2;
                   end               
                   j = j + 1;
               end
               y = a*x;
               if y <= y1
                   y = y1;
               elseif y >= y2
                   y = y2;
               end
               if x <= xymin
                   y = y1;
               elseif x >= xymax
                   y = y2;
               end
           end
           
       elseif nargin == 10
           %% 10 Input-Werte gegeben
           if mod(nice, 1) ~= 0
               error('Wert fuer "nice" muss ganzzahlig sein!');
           elseif nice <= 0
               error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
           elseif nice <= 3
               warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
           end       
           if x1 > x2
               error('LinearFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
           elseif x1 == x2
               error('LinearFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
           end 
           if xymin > xymax
               error('LinearFunction Minimal-Wert "xymin" darf nicht groesser als Maximal-Wert "xymax" sein!');
           elseif x1 == x2
               error('LinearFunction Minimal-Wert "xymin" darf nicht gleich Maximal-Wert "xymax" sein!');
           end
           if y2 < y1
               error('Grenzen von LinearFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
           elseif y2 == y1
               error('Grenzen von LinearHFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
           end
           if a < 0
               error('Steigung von LinearHFunction ist nur positiv definiert!');
           end
           % 1 Output
           if nargout == 1
           % 1:10  % y = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
               y = a*x+bias;
               if y <= y1
                   y = y1;
               elseif y >= y2
                   y = y2;
               end
               if x <= xymin
                   y = y1;
               elseif x >= xymax
                   y = y2;
               end
               lin = y;       
           % 2 Outputs
           elseif nargout == 2
           % 2:10  % [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
               lin = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   if i <= xymin
                       lin(j) = y1;
                   elseif i >= xymax
                       lin(j) = y2;
                   else
                       lin(j) = a*i+bias;
                   end
                   if lin(j) <= y1
                       lin(j) = y1;
                   elseif lin(j) >= y2
                       lin(j) = y2;
                   end               
                   j = j + 1;
               end
               y = a*x+bias;
               if y <= y1
                   y = y1;
               elseif y >= y2
                   y = y2;
               end
               if x <= xymin
                   y = y1;
               elseif x >= xymax
                   y = y2;
               end
           end
           
       else
           error('Ungueltige Anzahl Inputs fuer LinearFunction!');
       end
    
    end
    
    