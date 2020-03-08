function [ray, y] = RayleighFunction(nice, x1, x2, y1, y2, x, sigma, bias)

   % y - (optional) gibt einzelnen Wert im Punkt x zurueck
   % ray - Vektor der Dimension (nice) mit den abgetasteten Funktionswerte
   
   % nice - Feinheit der Abtastung der Funktion, bestimmt Laenge von (ray) (Empfehlung >> 3)
   % x1 - untere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (ray) (default: 0)
   % x2 - obere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (ray) (default: 12)
   % y1 - untere Grenze der Funktionswerte, gilt fuer y und/oder ray (y-Werte default: 0)
   % y2 - obere Grenze der Funktionswerte, gilt fuer y und/oder ray (y-Werte default: 1)
   % x - (optional) Variable fuer einzelnen Rueckgabewert der Funktion
   % sigma - Standardabweichung, beeinflusst den Grad der Zentrierung bzw. Steilheit von ray (default: 1)
   % bias - (optional) Verschiebung in x-Richtung, gilt fuer y und/oder ray (default: 0) -> Neg (rechts), Pos (links)
   
%% Definition:
% ray(x) = ((x-bias)/sigma.^2)*exp(-(((x-bias).^2)/(2*sigma.^2)));
%% noch ergaenzen mit bias

%% Wahrscheinlich sehr aehnlich zu RayleighFunction

   %% Wichtigste vollstaendige Funktionen
   % ray = RayleighFunction(nice, x1, x2, y1, y2, sigma, bias) % vollparametrisierter ray
   % y = RayleighFunction(y1, y2, x, sigma, bias)
   % ray OHNE Skalierung mittels "y1 && y2 = 0" in 1:7
   % ray = RayleighFunction(nice, x1, x2, 0, 0, sigma, bias)
   % y OHNE Skalierung
   % y = RayleighFunction(x, sigma, bias) 
   
       % Moegliche Nutzungen von RayleighFunction: (Aeusserere Aufrufe)

        % 1:1  % y = RayleighFunction(x)                                                   == (1:2 default: sigma)  
        % 1:2  % y = RayleighFunction(x, sigma)                                            == (1:3 default: bias) 
        % 2:2  % [ray, y] = RayleighFunction(nice, x)                                      == (1:4 default: x1, x2, sigma) && 1:1 
        % 1:3  % y = RayleighFunction(x, sigma, bias) 
        % 2:3  % [ray, y] = RayleighFunction(nice, x, sigma)                               == 1:2 && (1:4 default: x1, x2)
        % 1:4  % ray = RayleighFunction(nice, x1, x2, sigma)                               == (1:6 mit: y1 && y2 == 0)
        % 2:4  % [ray, y] = RayleighFunction(nice, x1, x2, x)                              == 1:1 && (1:4 default: sigma)
        % 1:5  % y = RayleighFunction(y1, y2, x, sigma, bias)
        % 2:5  % [ray, y] = RayleighFunction(nice, x1, x2, x, sigma)                       == 1:4 && 1:2               
        % 1:6  % ray = RayleighFunction(nice, x1, x2, y1, y2, sigma)                       == (1:7 default: bias)                                 
        % 2:6  % [ray, y] = RayleighFunction(nice, x1, x2, x, sigma, bias)                 == 1:5 && (1:7 mit: y1 && y2 == 0)                    
        % 1:7  % ray = RayleighFunction(nice, x1, x2, y1, y2, sigma, bias)
        % 2:7  % [ray, y] = RayleighFunction(nice, x1, x2, y1, y2, x, sigma)               == 1:6 && (1:5 default: bias)
        % 1:8  % y = RayleighFunction(nice, x1, x2, y1, y2, x, sigma, bias)                == 1:5
        % 2:8  % [ray, y] = RayleighFunction(nice, x1, x2, y1, y2, x, sigma, bias)
       
% default-Werte
x1Default = 0;
x2Default = 12;
sigmaDefault = 1;
biasDefault = 0;

   %% Ab hier Unterscheidung je nach Anzahl der gegebenen Input- und Output-Werte   
   % y = ((x-bias)/sigma.^2)*exp(-(((x-bias).^2)/(2*sigma.^2)));

   if nargin == 1
       %% 1 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:1  % y = RayleighFunction(x)  
           x = nice;
           y = ((x-biasDefault)/sigmaDefault.^2)*exp(-(((x-biasDefault).^2)/(2*sigmaDefault.^2)));
           if y <= 0
               y = 0;
               warning('y von RayleighFunction fuer (x <= 0) ist mit (y = 0) definiert');
           end
           ray = y;
       else
           error('RayleighFunction kann mit einem Input "x" nur einen Output "y" erzeugen!');
       end
       
   elseif nargin == 2
       %% 2 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:2  % y = RayleighFunction(x, sigma)
           x = nice;
           sigma = x1;
           y = ((x-biasDefault)/sigma.^2)*exp(-(((x-biasDefault).^2)/(2*sigma.^2)));
           if y <= 0
               y = 0;
               warning('y von RayleighFunction fuer (x <= 0) ist mit (y = 0) definiert');
           end
           ray = y;
       % 2 Outputs
       elseif nargout == 2
       % 2:2  % [ray, y] = RayleighFunction(nice, x) 
           x = x1;
           y = RayleighFunction(x);
           ray = zeros(nice,1);
           j=1;
           for i=linspace(x1Default, x2Default, nice)
               ray(j) = ((i-biasDefault)/sigmaDefault.^2)*exp(-(((i-biasDefault).^2)/(2*sigmaDefault.^2)));
               if ray(j) <= 0
                   ray(j) = 0;
               end
               j = j + 1;
           end
       end
       
   elseif nargin == 3
       %% 3 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:3  % y = RayleighFunction(x, sigma, bias) 
           x = nice;
           sigma = x1;
           bias = x2;
           y = ((x-bias)/sigma.^2)*exp(-(((x-bias).^2)/(2*sigma.^2)));
           if y <= 0
               y = 0;
               warning('y von RayleighFunction fuer (x <= 0) ist mit (y = 0) definiert');
           end
           ray = y;
       % 2 Outputs
       elseif nargout == 2
       % 2:3  % [ray, y] = RayleighFunction(nice, x, sigma)
           x = x1;
           sigma = x2;
           y = ((x-biasDefault)/sigma.^2)*exp(-(((x-biasDefault).^2)/(2*sigma.^2)));
           if y <= 0
               y = 0;
               warning('y von RayleighFunction fuer (x <= 0) ist mit (y = 0) definiert');
           end
           ray = zeros(nice,1);
           j=1;
           for i=linspace(x1Default, x2Default, nice)
               ray(j) = ((i-biasDefault)/sigma.^2)*exp(-(((i-biasDefault).^2)/(2*sigma.^2)));
               if ray(j) <= 0
                   ray(j) = 0;
               end
               j = j + 1;
           end
       end
       
   elseif nargin == 4
       %% 4 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:4  % ray = RayleighFunction(nice, x1, x2, sigma)
           sigma = y1;
           ray = RayleighFunction(nice, x1, x2, 0, 0, sigma);
       % 2 Outputs
       elseif nargout == 2
       % 2:4  % [ray, y] = RayleighFunction(nice, x1, x2, x)
           x = y1;
           y = RayleighFunction(x);
           ray = RayleighFunction(nice, x1, x2, 0, 0, sigmaDefault);
       end
       
   elseif nargin == 5
       %% 5 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:5  % y = RayleighFunction(y1, y2, x, sigma, bias)
           sigma = y1;
           bias = y2;
           x = x2;
           y2 = x1;
           y1 = nice;
           
           y = RayleighFunction(x, sigma, bias);
           if y1 == 0 && y2 == 0
               ray = y;
           else
               if y2 < y1
                   error('Grenzen von RayleighFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
               elseif y2 == y1
                   error('Grenzen von RayleighFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
               end
               % maxRay hat globales Maximum immer bei (x == sigma)
               maxRay = ((sigma)/sigma.^2)*exp(-(((sigma).^2)/(2*sigma.^2))); 
               y = y./maxRay; % auf 0..1 normieren
               if y1 == 0
                   y = y.*y2; % auf 0..y2 normieren
               elseif -y1 == y2 % symetrisch definiert
                   y = y.*2 - 1; % auf -1..1 normieren
                   y = y.*y2; % auf y1..y2 bzw. -y2..y2 normieren
               else
                   range = y2 - y1;
                   y = y.*range;
                   y = y + y1;
               end
               ray = y;
           end
           
       % 2 Outputs
       elseif nargout == 2
       % 2:5  % [ray, y] = RayleighFunction(nice, x1, x2, x, sigma) 
           x = y1;
           sigma = y2;
           ray = RayleighFunction(nice, x1, x2, sigma);
           y = RayleighFunction(x, sigma);           
       end
       
   elseif nargin == 6
       %% 6 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:6  % ray = RayleighFunction(nice, x1, x2, y1, y2, sigma)
           sigma = x;
           ray = RayleighFunction(nice, x1, x2, y1, y2, sigma, biasDefault);           
       % 2 Outputs
       elseif nargout == 2
       % 2:6  % [ray, y] = RayleighFunction(nice, x1, x2, x, sigma, bias) 
           % bias = x;
           % sigma = y2;
           % x = y1;
           % y = RayleighFunction(y1, y2, x, sigma, bias);
           % y = RayleighFunction(nice, x1, x2, x, sigma);
           bias = x;
           sigma = y2;
           x = y1;
           y = RayleighFunction(0, 0, x, sigma, bias);
           ray = RayleighFunction(nice, x1, x2, 0, 0, sigma, bias);            
       end
       
   elseif nargin == 7
       %% 7 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:7  % ray = RayleighFunction(nice, x1, x2, y1, y2, sigma, bias)
           bias = sigma;
           sigma = x;
           if mod(nice, 1) ~= 0
               error('Wert fuer "nice" muss ganzzahlig sein!');
           elseif nice <= 0
               error('Wert fuer "nice" darf nicht kleiner oder gleich null sein!');
           elseif nice <= 3
               warning('Wert fuer "nice" wurde kleiner gleich 3 gewaehlt -> sehr geringe Aufloesung!');
           end
           if x1 > x2
               error('SigmoidFunction untere Grenze "x1" darf nicht groesser als obere Grenze "x2" sein!');
           elseif x1 == x2
               error('SigmoidFunction untere Grenze "x1" darf nicht gleich oberer Grenze "x2" sein!');
           end
           if y1 == 0 && y2 == 0
               ray = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   ray(j) = ((i-bias)/sigma.^2)*exp(-(((i-bias).^2)/(2*sigma.^2)));
                   if ray(j) <= 0
                       ray(j) = 0;
                   end
                   j = j + 1;
               end
           else
               if y2 < y1
                   error('Grenzen von RayleighFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
               elseif y2 == y1
                   error('Grenzen von RayleighFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
               end
               ray = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   ray(j) = ((i-bias)/sigma.^2)*exp(-(((i-bias).^2)/(2*sigma.^2)));
                   if ray(j) <= 0
                       ray(j) = 0;
                   end
                   j = j + 1;
               end
               maxRay = ((sigma)/sigma.^2)*exp(-(((sigma).^2)/(2*sigma.^2)));               
               ray = ray./maxRay; % auf 0..1 normieren
               if y1 == 0
                   ray = ray.*y2; % auf 0..y2 normieren
               elseif -y1 == y2 % symetrisch definiert
                   ray = ray.*2 - 1; % auf -1..1 normieren
                   ray = ray.*y2; % auf y1..y2 bzw. -y2..y2 normieren
               else
                   range = y2 - y1;
                   ray = ray.*range;
                   ray = ray + y1;
               end
           end
       % 2 Outputs
       elseif nargout == 2
            % 2:7  % [ray, y] = RayleighFunction(nice, x1, x2, y1, y2, x, sigma)    
            y = RayleighFunction(y1, y2, x, sigma, biasDefault);
            ray = RayleighFunction(nice, x1, x2, y1, y2, sigma);
       end
       
   elseif nargin == 8
       %% 8 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:8  % y = RayleighFunction(nice, x1, x2, y1, y2, x, sigma, bias)
           y = RayleighFunction(y1, y2, x, sigma, bias);
           ray = y;
       % 2 Outputs
       elseif nargout == 2
       % 2:8  % [ray, y] = RayleighFunction(nice, x1, x2, y1, y2, x, sigma, bias)
           y = RayleighFunction(y1, y2, x, sigma, bias);
           ray = RayleighFunction(nice, x1, x2, y1, y2, sigma, bias);
       end
       
   else 
       error('Ungueltige Anzahl Inputs fuer RayleighFunction!');
   end
   
end

