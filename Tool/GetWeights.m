function weights = GetWeights(pixelCnt, featureCnt, slope, type)
   % weights - Rueckgabe der Gewichtsmatrix
   % pixelCnt - Anzahl der Pixel pro Merkmal
   % featureCnt - Anzahl der Merkmale
   % slope - Steilheit der Fkt, Randrauschen unterdruecken 1 bis 100%
   % type - Art wie die Gewichte erstellt werden - Mul, Add
   
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
    end      
    if(res_Weight_Matrix == zeros(h_N, v_N))
        error('Weighttype for generation unknown, use Mul, Add or Muladd')
    end
    weights = res_Weight_Matrix;
    
%     % Plot der Gewichte getrennt vertikal und horizontal 
%     % und anschlie�end Ergebnis mit Angabe des Verwendeten Verfahrens
%     % horizontal muss fuer den Plot extra erzeugt/normiert werden
%     sec_Weight_Matrix = zeros(h_N, v_N);
%     for j = 1:h_N
%         sec_Weight_Matrix(1:end, j) = h_Gauss./max(h_Gauss);
%     end    
%     figure
%     hold on
%     subplot(2,2,1)
%     mesh(Weight_Matrix)
%     title('Vertikale Gewichtsmatrix')
%     subplot(2,2,2)
%     mesh(sec_Weight_Matrix)
%     title('Horizontale Gewichtsmatrix')
%     subplot(2,2,3)
%     mesh(weights)
%     title(['Ergebnis Gewichtsmatrix mit "',type,'"'])
end