function weights = GetWeights(pixelCnt, featureCnt, slope, type, lower, upper)
   % weights - Rueckgabe der Gewichtsmatrix
   % pixelCnt - Anzahl der Pixel pro Merkmal
   % featureCnt - Anzahl der Merkmale
   % slope - Steilheit der Fkt, Randrauschen unterdruecken 1 bis 100%
   % type - Art wie die Gewichte erstellt werden - Mul, Add oder MullAdd
   % lower - Die untere Grenze der Gewichte (default = -1)
   % upper - Die obere Grenze der Gewichte (default = 1)
   
   if nargin == 4
       lower = -1;
       upper = 1;
   elseif nargin == 5
       error('Bitte zweite Grenze fuer die Gewichte angeben oder auf die Vorgabe von Gewichten verzichten');
   end
   if ((upper - lower) <= 0)
       error('Reichweite der Gewichtsgrenzen ist negativ oder gleich null => GetWeights(..., upper, lower) vertauscht?')
   end
   if (slope < 1) || (slope > 100)
      error('Rauschwert ist nicht erlaubt');
   end
   
   v_N=pixelCnt * featureCnt;
   h_N=pixelCnt * featureCnt;
   sigma = -0.0019*(slope - 1) + 0.2;
   gaussFunction = @(x, s, x0)(1/(sqrt(2*pi).*s))*exp(-((x-x0).^2)/(2.*s.^2));

   % Einteilung bestimmen
   v = linspace(-0.3,0.3,v_N);
   h = linspace(-0.3,0.3,h_N);

   % 2 Gaussfunktionen mit festem Sigma im Raum
   % Sigma zwischen 0.01 und 0.2 waehlen
   v_Gauss = gaussFunction(v, sigma, 0); % x-Achse, v-Balken
   h_Gauss = gaussFunction(h, sigma, 0); % y-Achse, h-Balken

   % Gewichts-Matrix erstellen
   Weight_Matrix = zeros(h_N, v_N);

   % ersten Gauss in Gewichts-Matrix schreiben
   for i = 1:h_N
       % auf 1 Normieren und in Matrix schreiben
       Weight_Matrix(i, 1:end) = v_Gauss./max(v_Gauss);
   end
   
    % zweite Matrix erzeugen zur Ueberlagerung von (v_Gauss & h_Gauss)
    res_Weight_Matrix = zeros(h_N, v_N);
    
    % fuer (type == MulAdd) zusaetzliche Matrix erzeugen
    if strcmp(type, 'MulAdd')
        MulAdd_Weight_Matrix = zeros(h_N, v_N);
    end
   
    % Unterscheidung in for-Schleife je nach Art der Ueberlagerung (weightType)
    % Zuerst if/elseif und dann for akzeptiert MATLAB nicht :( 
    for i = 1:v_N
        if strcmp(type, 'Mul')        
            res_Weight_Matrix(1:end, i) = Weight_Matrix(1:end, i) .* (h_Gauss./max(h_Gauss))';
            res_Weight_Matrix(1:end, i) = res_Weight_Matrix(1:end, i) .* 2 - 1;
        end        
        if strcmp(type, 'Add')
            res_Weight_Matrix(1:end, i) = (Weight_Matrix(1:end, i) + (h_Gauss./max(h_Gauss))')./2;
            res_Weight_Matrix(1:end, i) = res_Weight_Matrix(1:end, i) .* 2 - 1;
        end
        if strcmp(type, 'MulAdd')
            MulAdd_Weight_Matrix(1:end, i) = Weight_Matrix(1:end, i) .* (h_Gauss./max(h_Gauss))';
            MulAdd_Weight_Matrix(1:end, i) = MulAdd_Weight_Matrix(1:end, i) - 1;
            res_Weight_Matrix(1:end, i) = (Weight_Matrix(1:end, i) + (h_Gauss./max(h_Gauss))') - 1;
            res_Weight_Matrix(1:end, i) = res_Weight_Matrix(1:end, i) - MulAdd_Weight_Matrix(1:end, i);
            res_Weight_Matrix(1:end, i) = res_Weight_Matrix(1:end, i) .* 2 - 1;
        end
    end      
    if(res_Weight_Matrix == zeros(h_N, v_N))
        error('Weighttype for generation unknown, use Mul, Add or Muladd')
    end
    
    if(lower == 0 && upper == 1)
        res_Weight_Matrix = res_Weight_Matrix + 1;
        res_Weight_Matrix =res_Weight_Matrix ./ 2;
    elseif(not(lower == -1 && upper == 1)) % für andere Grenzen als 0..1 und -1..1
        error('Komische Gewichte')
        % range berechnen und verschieben ensprechend der Grenzen
    end
    weights = res_Weight_Matrix;
    
    % Plot der Gewichte getrennt vertikal und horizontal 
    % und anschliessend Ergebnis mit Angabe des Verwendeten Verfahrens
    % horizontal muss fuer den Plot extra erzeugt/normiert werden
    close all
    sec_Weight_Matrix = zeros(h_N, v_N);
    for j = 1:h_N
        sec_Weight_Matrix(1:end, j) = h_Gauss./max(h_Gauss);
    end    
    figure
    hold on
    subplot(2,2,1)
    mesh(Weight_Matrix)
    title('Vertikale Gewichtsmatrix')
    subplot(2,2,2)
    mesh(sec_Weight_Matrix)
    title('Horizontale Gewichtsmatrix')
    subplot(2,2,3)
    mesh(weights)
    title(['Ergebnis Gewichtsmatrix mit "',type,'"'])
end
