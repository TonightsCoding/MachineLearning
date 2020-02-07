function M = CreateWeights(pixel, feature, slope, type)
   % ret - Gibt Gewichtsmatrix zurueck
   % pixel - Anzahl der Pixel pro Merkmal
   % feature - Anzahl der Merkmale
   % slope - Steilheit der Fkt, Randrauschen unterdruecken 1 bis 100%
   % type - Art wie die Gewichte erstellt werden - Mul, Add
   
   if (slope < 1) || (slope > 100)
      error('Rauschwert ist nicht erlaubt');
   end
   
   v_N=pixel * feature;
   h_N=pixel * feature;
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
   Weigth_Matrix = zeros(h_N, v_N);

   % ersten Gauss in Gewichts-Matrix schreiben
   for i = 1:h_N
       % auf 1 Normieren und in Matrix schreiben
       Weigth_Matrix(i, 1:end) = v_Gauss./max(v_Gauss);
   end

   % zweiten Gauss multiplikativ ueberlagern
   Weigth_Matrix_Mul = zeros(h_N, v_N);
   for i = 1:v_N
       Weigth_Matrix_Mul(1:end, i) = Weigth_Matrix(1:end, i) .* (h_Gauss./max(h_Gauss))';
       Weigth_Matrix_Mul(1:end, i) = Weigth_Matrix_Mul(1:end, i) .* 2 - 1;
   end

   % zweiten Gauss additiv ueberlagern
   Weigth_Matrix_Add = zeros(h_N, v_N);
   for i = 1:v_N
       Weigth_Matrix_Add(1:end, i) = (Weigth_Matrix(1:end, i) + (h_Gauss./max(h_Gauss))')./2;
       Weigth_Matrix_Add(1:end, i) = Weigth_Matrix_Add(1:end, i) .* 2 - 1;
   end

   % Ausgabe der Gewichtsmatrix
   if strcmp(type, 'Mul')
      M = Weigth_Matrix_Mul;
   elseif strcmp(type, 'Add')
      M = Weigth_Matrix_Add;
   else
      error('type unknown, use Mul or Add')
   end
end