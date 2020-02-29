function [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)
%% Funktionsdefinition
%% y = (1/(sqrt(2*pi).*sigma))*exp(-((x-mue).^2)/(2.*sigma.^2))
   % y - (optional) gibt einzelnen Wert im Punkt x zurueck
   % gauss - Vektor der Dimension (nice) mit den abgetasteten Funktionswerte
   
   % nice - Feinheit der Abtastung der Funktion, bestimmt Laenge von (gauss) (Empfehlung >> 3)
   % x1 - untere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (gauss) (default: -6)
   % x2 - obere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (gauss) (default: 6)
   %% y1 - untere Grenze der Funktionswerte, gilt fuer y und/oder gauss (y1 default: 0)
   %% y2 - obere Grenze der Funktionswerte, gilt fuer y und/oder gauss (y2 default: 1, oder vllt in Abhaengigkeit von sigma(Default)?)
   %% Abhaengigkeit von sigma haette Vorteil der besseren Verteilung von maximalen Werten
   %% Vorerst keine default-Werte notwendig?
   % x - (optional) Variable fuer einzelnen Rueckgabewert der Funktion
   % sigma - Standardabweichung, beeinflusst den Grad der Zentrierung bzw. Steilheit von gauss (default: 1)
   % mue - (optional) Verschiebung in x-Richtung, gilt fuer y und/oder gauss (default: 0) -> Neg (rechts), Pos (links)
   
   %% Wichtigste vollstaendige Funktionen
   % gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma, mue)
   % y = GaussNormFunction(y1, y2, x, sigma, mue)
   
       % Moegliche Nutzungen von GaussNormFunction: (Aeusserere Aufrufe)

        % 1:1  % y = GaussNormFunction(x)                                                   == (1:2 default: sigma)  
        % 1:2  % y = GaussNormFunction(x, sigma)                                            == (1:3 default: mue) 
        % 2:2  % [gauss, y] = GaussNormFunction(nice, x)                                    == (1:4 default: x1, x2, sigma) && 1:1 
        %% 1:3  % y = GaussNormFunction(x, sigma, mue)                                       == (1:5 default: y1, y2) 
        % 2:3  % [gauss, y] = GaussNormFunction(nice, x, sigma)                             == 1:2 && (1:4 default: x1, x2)
        %% 1:4  % gauss = GaussNormFunction(nice, x1, x2, sigma)                             == (1:6 default: y1, y2)
        % 2:4  % [gauss, y] = GaussNormFunction(nice, x1, x2, x)                            == 1:1 && (1:4 default: sigma)
        % 1:5  % y = GaussNormFunction(y1, y2, x, sigma, mue)
        % 2:5  % [gauss, y] = GaussNormFunction(nice, x1, x2, x, sigma)                     == 1:4 && 1:2               
        % 1:6  % gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma)                     == (1:7 default: mue)                                 
        %% 2:6  % [gauss, y] = GaussNormFunction(nice, x1, x2, x, sigma, mue)                == 1:5 && (1:7 default: y1, y2)                    
        % 1:7  % gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma, mue)
        % 2:7  % [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma)             == 1:6 && (1:5 default: mue)
        % 1:8  % y = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)                 == 1:5
        % 2:8  % [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)        == 1:5 && 1:7
 
%% So gekennzeichnete Funktionen eher direkt implementieren ohne Skalierung durch y1, y2?

% default-Werte
x1Default = -6;
x2Default = 6;
mueDefault = 0;
sigmaDefault = 1;


end

