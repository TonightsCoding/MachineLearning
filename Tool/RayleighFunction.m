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
   
%% Definitionsvarianten:
% ray(x) = (x/sigma.^2)*exp(-((x.^2)/(2*sigma.^2)));
%% noch ergaenzen mit bias

%% Wahrscheinlich sehr aehnlich zu GaussNormFunction

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
biasDefault = 0;
x1Default = 0;
x2Default = 12;

end

