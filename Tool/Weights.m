clear all, close all

v_N=8*5; % Einteilung v-Balken
h_N=8*5; % Einteilung h-Balken
gaussFunction = @(x, s, x0)(1/(sqrt(2*pi).*s))*exp(-((x-x0).^2)/(2.*s.^2));

% Einteilung bestimmen
v = linspace(-0.3,0.3,v_N);
h = linspace(-0.3,0.3,h_N);

% 2 Gaussfunktionen mit festem Sigma im Raum
% Sigma zwischen 0.01 und 0.2 waehlen
v_Gauss = gaussFunction(v, 0.1, 0); % x-Achse, v-Balken
h_Gauss = gaussFunction(h, 0.1, 0); % y-Achse, h-Balken

% Gewichts-Matrix erstellen
Weigth_Matrix = zeros(h_N, v_N);

% Offset_Matrix
Offset_Matrix = ones(h_N, v_N).*0.0;

% ersten Gauss in Gewichts-Matrix schreiben
for i = 1:h_N
    % auf 1 Normieren und in Matrix schreiben
    Weigth_Matrix(i, 1:end) = v_Gauss./max(v_Gauss);
end

% Ausgabe der Gewichts-Matrix
figure
mesh(v,h,Weigth_Matrix);
axis([v(1) v(end) h(1) h(end) 0 1.2])
xlabel('v-Balken')
ylabel('h-Balken')
zlabel('Normiert')
title('Gewichts-Matrix mit einem Gauss')

% Ausgabe der 90-Grad gedrehten Gewichts-Matrix
figure
mesh(h,v,Weigth_Matrix');
axis([h(1) h(end) v(1) v(end) 0 1.2])
xlabel('v-Balken')
ylabel('h-Balken')
zlabel('Normiert')
title('Gewichts-Matrix mit einem Gauss, 90 Grad gedreht')

% zweiten Gauss multiplikativ ueberlagern
Weigth_Matrix_Mul = zeros(h_N, v_N);
for i = 1:v_N
    Weigth_Matrix_Mul(1:end, i) = Weigth_Matrix(1:end, i) .* (h_Gauss./max(h_Gauss))';
    Weigth_Matrix_Mul(1:end, i) = Weigth_Matrix_Mul(1:end, i) .* 2 - 1; 
end

% Ausgabe der multiplikativen Ueberlagerung
figure
hold on
mesh(v,h,Weigth_Matrix_Mul);
mesh(v,h,Offset_Matrix);
axis([v(1) v(end) h(1) h(end) -1.2 1.2])
xlabel('v-Balken')
ylabel('h-Balken')
zlabel('Normiert')
title('Multiplikative Überlagerung')

% zweiten Gauss additiv ueberlagern
Weigth_Matrix_Add = zeros(h_N, v_N);
for i = 1:v_N
    Weigth_Matrix_Add(1:end, i) = (Weigth_Matrix(1:end, i) + (h_Gauss./max(h_Gauss))')./2;
    Weigth_Matrix_Add(1:end, i) = Weigth_Matrix_Add(1:end, i) .* 2 - 1;
end

% Ausgabe der additive Ueberlagerung
figure
hold on
mesh(v,h,Weigth_Matrix_Add);
mesh(v,h,Offset_Matrix);
axis([v(1) v(end) h(1) h(end) -1.2 1.2])
xlabel('v-Balken')
ylabel('h-Balken')
zlabel('Normiert')
title('Additive Überlagerung')

% Maximalwerte der horizontalen und vertikalen Balken ermitteln
h_Mul_Max = sum(Weigth_Matrix_Mul,2);
v_Mul_Max = sum(Weigth_Matrix_Mul)';
h_Add_Max = sum(Weigth_Matrix_Add,2);
v_Add_Max = sum(Weigth_Matrix_Add)';

% Maximalwert für Diagramm ermitteln
Max_graph = max([h_Mul_Max; v_Mul_Max; h_Add_Max; v_Add_Max]);
Max_graph = ceil(Max_graph); % immer aufrunden

Min_graph = min([h_Mul_Max; v_Mul_Max; h_Add_Max; v_Add_Max]);
Min_graph = ceil(Min_graph); % immer aufrunden

figure
subplot(2,2,1)
plot(h_Mul_Max)
axis([0 h_N Min_graph Max_graph]);
title('Multiplikation - Maximalwerte der horizontalen Balken')
subplot(2,2,2)
plot(v_Mul_Max)
axis([0 v_N Min_graph Max_graph]);
title('Multiplikation - Maximalwerte der vertikalen Balken')
subplot(2,2,3)
plot(h_Add_Max)
axis([0 h_N Min_graph Max_graph]);
title('Addition - Maximalwerte der horizontalen Balken')
subplot(2,2,4)
plot(v_Add_Max)
axis([0 v_N Min_graph Max_graph]);
title('Addition - Maximalwerte der vertikal Balken')