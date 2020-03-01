function [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)
%% Funktionsdefinition
%% y = (1/(sqrt(2*pi).*sigma))*exp(-((x-mue).^2)/(2.*sigma.^2))
% y = (1/(sqrt(2*pi.*(sigma.^2))))*exp(-((x-mue).^2)/(2.*sigma.^2))

   % y - (optional) gibt einzelnen Wert im Punkt x zurueck
   % gauss - Vektor der Dimension (nice) mit den abgetasteten Funktionswerte
   
   % nice - Feinheit der Abtastung der Funktion, bestimmt Laenge von (gauss) (Empfehlung >> 3)
   % x1 - untere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (gauss) (default: -6)
   % x2 - obere Grenze der Definitionsbreite (x-Werte) fuer Funktionswerte von (gauss) (default: 6)
   % y1 - untere Grenze der Funktionswerte, gilt fuer y und/oder gauss 
   % y2 - obere Grenze der Funktionswerte, gilt fuer y und/oder gauss 
   % wenn y1 && y2 == 0 wird keine Skalierung vor genehmen
   % x - (optional) Variable fuer einzelnen Rueckgabewert der Funktion
   % sigma - Standardabweichung, beeinflusst den Grad der Zentrierung bzw. Steilheit von gauss (default: 1)
   % mue - (optional) Verschiebung in x-Richtung, gilt fuer y und/oder gauss (default: 0) -> Neg (rechts), Pos (links)
   
   %% Wichtigste vollstaendige Funktionen
   % gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma, mue) % vollparametrisierter gauss
   % y = GaussNormFunction(y1, y2, x, sigma, mue)
   % gauss OHNE Skalierung mittels "y1 && y2 = 0" in 1:7
   % gauss = GaussNormFunction(nice, x1, x2, 0, 0, sigma, mue)
   % y OHNE Skalierung
   % y = GaussNormFunction(x, sigma, mue) 
   
       % Moegliche Nutzungen von GaussNormFunction: (Aeusserere Aufrufe)

        % 1:1  % y = GaussNormFunction(x)                                                   == (1:2 default: sigma)  
        % 1:2  % y = GaussNormFunction(x, sigma)                                            == (1:3 default: mue) 
        % 2:2  % [gauss, y] = GaussNormFunction(nice, x)                                    == (1:4 default: x1, x2, sigma) && 1:1 
        % 1:3  % y = GaussNormFunction(x, sigma, mue) 
        % 2:3  % [gauss, y] = GaussNormFunction(nice, x, sigma)                             == 1:2 && (1:4 default: x1, x2)
        % 1:4  % gauss = GaussNormFunction(nice, x1, x2, sigma)                             == (1:6 mit: y1 && y2 == 0)
        % 2:4  % [gauss, y] = GaussNormFunction(nice, x1, x2, x)                            == 1:1 && (1:4 default: sigma)
        % 1:5  % y = GaussNormFunction(y1, y2, x, sigma, mue)
        % 2:5  % [gauss, y] = GaussNormFunction(nice, x1, x2, x, sigma)                     == 1:4 && 1:2               
        % 1:6  % gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma)                     == (1:7 default: mue)                                 
        % 2:6  % [gauss, y] = GaussNormFunction(nice, x1, x2, x, sigma, mue)                == 1:5 && (1:7 mit: y1 && y2 == 0)                    
        % 1:7  % gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma, mue)
        % 2:7  % [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma)             == 1:6 && (1:5 default: mue)
        % 1:8  % y = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)                 == 1:5
        % 2:8  % [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)        == 1:5 && 1:7

% default-Werte
x1Default = -6;
x2Default = 6;
mueDefault = 0;
sigmaDefault = 1;

   %% Ab hier Unterscheidung je nach Anzahl der gegebenen Input- und Output-Werte   
   % y = (1/(sqrt(2*pi).*sigma))*exp(-((x-mue).^2)/(2.*sigma.^2))
   if nargin == 1
       %% 1 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:1  % y = GaussNormFunction(x)  
           x = nice;
           y = (1/(sqrt(2*pi).*sigmaDefault))*exp(-((x-mueDefault).^2)/(2.*sigmaDefault.^2));
           gauss = y;
       else
           error('GaussNormFunction kann mit einem Input "x" nur einen Output "y" erzeugen!');
       end
       
   elseif nargin == 2
       %% 2 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:2  % y = GaussNormFunction(x, sigma)
           x = nice;
           sigma = x1;
           y = (1/(sqrt(2*pi).*sigma))*exp(-((x-mueDefault).^2)/(2.*sigma.^2));
           gauss = y;
       % 2 Outputs
       elseif nargout == 2
       % 2:2  % [gauss, y] = GaussNormFunction(nice, x) 
           x = x1;
           y = GaussNormFunction(x);
           gauss = zeros(nice,1);
           j=1;
           for i=linspace(x1Default, x2Default, nice)
               gauss(j) = (1/(sqrt(2*pi).*sigmaDefault))*exp(-((i-mueDefault).^2)/(2.*sigmaDefault.^2));
               j = j + 1;
           end
       end
       
   elseif nargin == 3
       %% 3 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:3  % y = GaussNormFunction(x, sigma, mue) 
           x = nice;
           sigma = x1;
           mue = x2;
           y = (1/(sqrt(2*pi).*sigma))*exp(-((x-mue).^2)/(2.*sigma.^2));
           gauss = y;
       % 2 Outputs
       elseif nargout == 2
       % 2:3  % [gauss, y] = GaussNormFunction(nice, x, sigma)
           x = x1;
           sigma = x2;
           y = (1/(sqrt(2*pi).*sigma))*exp(-((x-mueDefault).^2)/(2.*sigma.^2));
           gauss = zeros(nice,1);
           j=1;
           for i=linspace(x1Default, x2Default, nice)
               gauss(j) = (1/(sqrt(2*pi).*sigma))*exp(-((i-mueDefault).^2)/(2.*sigma.^2));
               j = j + 1;
           end
       end
       
   elseif nargin == 4
       %% 4 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:4  % gauss = GaussNormFunction(nice, x1, x2, sigma)
           sigma = y1;
           gauss = GaussNormFunction(nice, x1, x2, 0, 0, sigma);
       % 2 Outputs
       elseif nargout == 2
       % 2:4  % [gauss, y] = GaussNormFunction(nice, x1, x2, x)
           x = y1;
           y = GaussNormFunction(x);
           gauss = GaussNormFunction(nice, x1, x2, 0, 0, sigmaDefault);
       end
       
   elseif nargin == 5
       %% 5 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:5  % y = GaussNormFunction(y1, y2, x, sigma, mue)
           sigma = y1;
           mue = y2;
           x = x2;
           y2 = x1;
           y1 = nice;
           
           y = GaussNormFunction(x, sigma, mue);
           if y1 == 0 && y2 == 0
               gauss = y;
           else
               if y2 < y1
                   error('Grenzen von GaussNormFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
               elseif y2 == y1
                   error('Grenzen von GaussNormFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
               end
               maxGauss = (1/(sqrt(2*pi).*sigma))*exp(-(0)/(2.*sigma.^2));
               y = y./maxGauss; % auf 0..1 normieren
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
               gauss = y;
           end
           
       % 2 Outputs
       elseif nargout == 2
       % 2:5  % [gauss, y] = GaussNormFunction(nice, x1, x2, x, sigma) 
           x = y1;
           sigma = y2;
           gauss = GaussNormFunction(nice, x1, x2, sigma);
           y = GaussNormFunction(x, sigma);           
       end
       
   elseif nargin == 6
       %% 6 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:6  % gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma)
           sigma = x;
           gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma, mueDefault);           
       % 2 Outputs
       elseif nargout == 2
       % 2:6  % [gauss, y] = GaussNormFunction(nice, x1, x2, x, sigma, mue) 
           % mue = x;
           % sigma = y2;
           % x = y1;
           % y = GaussNormFunction(y1, y2, x, sigma, mue);
           % y = GaussNormFunction(nice, x1, x2, x, sigma);
           mue = x;
           sigma = y2;
           x = y1;
           y = GaussNormFunction(0, 0, x, sigma, mue);
           gauss = GaussNormFunction(nice, x1, x2, 0, 0, sigma, mue);            
       end
       
   elseif nargin == 7
       %% 7 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:7  % gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma, mue)
           mue = sigma;
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
               gauss = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   gauss(j) = (1/(sqrt(2*pi).*sigma))*exp(-((i-mue).^2)/(2.*sigma.^2));
                   j = j + 1;
               end
           else
               if y2 < y1
                   error('Grenzen von GaussNormFunction vertauscht da obere Grenze "y2" kleiner als untere Grenze "y1" gewaehlt wurde!');
               elseif y2 == y1
                   error('Grenzen von GaussNormFunction falsch: da obere Grenze "y2" gleich unterer Grenze "y1" gewaehlt wurde!');
               end
               gauss = zeros(nice,1);
               j=1;
               for i=linspace(x1, x2, nice)
                   gauss(j) = (1/(sqrt(2*pi).*sigma))*exp(-((i-mue).^2)/(2.*sigma.^2));
                   j = j + 1;
               end
               maxGauss = max(gauss);
               gauss = gauss./maxGauss; % auf 0..1 normieren
               if y1 == 0
                   gauss = gauss.*y2; % auf 0..y2 normieren
               elseif -y1 == y2 % symetrisch definiert
                   gauss = gauss.*2 - 1; % auf -1..1 normieren
                   gauss = gauss.*y2; % auf y1..y2 bzw. -y2..y2 normieren
               else
                   range = y2 - y1;
                   gauss = gauss.*range;
                   gauss = gauss + y1;
               end
           end
       % 2 Outputs
       elseif nargout == 2
            % 2:7  % [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma)    
            y = GaussNormFunction(y1, y2, x, sigma, mueDefault);
            gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma);
       end
       
   elseif nargin == 8
       %% 8 Input-Wert gegeben
       % 1 Output
       if nargout == 1
       % 1:8  % y = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)
           y = GaussNormFunction(y1, y2, x, sigma, mue);
           gauss = y;
       % 2 Outputs
       elseif nargout == 2
       % 2:8  % [gauss, y] = GaussNormFunction(nice, x1, x2, y1, y2, x, sigma, mue)
           y = GaussNormFunction(y1, y2, x, sigma, mue);
           gauss = GaussNormFunction(nice, x1, x2, y1, y2, sigma, mue);
       end
       
   else 
       error('Ungueltige Anzahl Inputs fuer GaussNormFunction!');
   end
   
end

