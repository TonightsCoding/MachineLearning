function [gaussian, y] = GaussianNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)
%% Funktionsdefinition
%% y = (1/(sqrt(2*pi).*sigma))*exp(-((x-mue).^2)/(2.*sigma.^2))
   % y - (optional) gibt einzelnen Wert im Punkt x zurueck
   % gaussian - Vektor der Dimension (nice) mit den abgetasteten Funktionswerte
   
   % nice - Feinheit der Abtastung der Funktion, bestimmt Laenge von (gaussian) (Empfehlung >> 3)
   % x1 - untere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (gaussian) (default: -6)
   % x2 - obere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (gaussian) (default: 6)
   %% y1 - untere Grenze der Funktionswerte, gilt fuer y und/oder gaussian (y1 default: 0)
   %% y2 - obere Grenze der Funktionswerte, gilt fuer y und/oder gaussian (y2 default: 1, oder vllt in Abhaengigkeit von sigma(Default)?)
   %% Abhaengigkeit von sigma haette Vorteil der besseren Verteilung von maximalen Werten
   %% Vorerst keine default-Werte notwendig?
   % x - (optional) Variable fuer einzelnen Rueckgabewert der Funktion
   % sigma - Standardabweichung, beeinflusst den Grad der Zentrierung bzw. Steilheit von gaussian (default: 1)
   % mue - (optional) Verschiebung in x-Richtung, gilt fuer y und/oder sigmoid (default: 0) -> Neg (rechts), Pos (links)
   
   %% Wichtigste vollstaendige Funktionen
   % gaussian = GaussianNormFunction(nice, x1, x2, y1, y2, sigma, mue)
   % y = GaussianNormFunction(y1, y2, x, sigma, mue)
   
       % Moegliche Nutzungen von GaussianNormFunction: (Aeusserere Aufrufe)

        % 1:1  % y = GaussianNormFunction(x)                                                == (1:2 default: sigma)  
        % 1:2  % y = GaussianNormFunction(x, sigma)                                         == (1:3 default: mue) 
        % 2:2  % [gaussian, y] = GaussianNormFunction(nice, x)                              == (1:4 default: x1, x2, sigma) && 1:1 
        %% 1:3  % y = GaussianNormFunction(x, sigma, mue)                                    == (1:5 default: y1, y2) 
        % 2:3  % [gaussian, y] = GaussianNormFunction(nice, x, sigma)                       == 1:2 && (1:4 default: x1, x2)
        %% 1:4  % gaussian = GaussianNormFunction(nice, x1, x2, sigma)                       == (1:6 default: y1, y2)
        % 2:4  % [gaussian, y] = GaussianNormFunction(nice, x1, x2, x)                      == 1:1 && (1:4 default: sigma)
        % 1:5  % y = GaussianNormFunction(y1, y2, x, sigma, mue)
        % 2:5  % [gaussian, y] = GaussianNormFunction(nice, x1, x2, x, sigma)               == 1:4 && 1:2               
        % 1:6  % gaussian = GaussianNormFunction(nice, x1, x2, y1, y2, sigma)               == (1:7 default: mue)                                 
        %% 2:6  % [gaussian, y] = GaussianNormFunction(nice, x1, x2, x, sigma, mue)          == 1:5 && (1:7 default: y1, y2)                    
        % 1:7  % gaussian = GaussianNormFunction(nice, x1, x2, y1, y2, sigma, mue)
        % 2:7  % [gaussian, y] = GaussianNormFunction(nice, x1, x2, y1, y2, x, sigma)       == 1:6 && (1:5 default: mue)
        % 1:8  % y = GaussianNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)              == 1:5
        % 2:8  % [gaussian, y] = GaussianNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)  == 1:5 && 1:7
 
%% So gekennzeichnete Funktionen eher direkt implementieren ohne Skalierung durch y1, y2?

% default-Werte
x1Default = -6;
x2Default = 6;
mueDefault = 0;
sigmaDefault = 1;


end

