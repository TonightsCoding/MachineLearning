clear all, close all
%% TangHFunction hat viele Varianten der Benutzung deswegen werden 
%% diese Varianten folgend angegeben: 

%% Anzahl Input(s)
%     % Anzahl Output(s)
%     % Funktionsrumpf
%     Variablen default-Werte zuweisen
%     % Variablen fuer Anpassungen
%     Funktionsaufruf
%     Ausgabe beziehungsweise Veranschaulichung der Ergebnisse

%% Variablen fuer alle Funktionen setzten
nice = 30;
a = 0.5;
x1 = -6;
x2 = 6;
xymin = -3;
xymax = 3;
y1 = -1;
y2 = 1;
x = 0;
bias = 0;
% default-Werte fuer x1 und x2 gleich x1 und x2 
x1Default = x1;
x2Default = x2;
% defualt-Werte fuer x1 und x2 aus LinearFunction zur Veranschaulichung
% x1Default = -6;
% x2Default = 6;

%% Nach Anzahl der Inputs sortiert und anschliessend nach
% Anzahl der Outputs unterschieden

        % 1:1   % y = LinearFunction(x)														% == 1:1 mit: aDefault 
        % 1:2   % y = LinearFunction(a, x) 													% == 1:3 mit: biasDefault
        % 2:2   % [lin, y] = LinearFunction(nice, x)										% == (1:4 mit: aDefault, x1Default, x2Default) && 1:1  
        % 1:3   % y = LinearFunction(a, x, bias)											% == 1:5 mit: y1 && y2 == 0
        % 2:3   % [lin, y] = LinearFunction(nice, a, x)										% == 2:4 mit: biasDefault
        % 1:4   % lin = LinearFunction(nice, a, x1, x2)										% == 1:6 mit: y1 && y2 == 0
        % 2:4   % [lin, y] = LinearFunction(nice, a, x, bias)								% == (1:7 mit: x1Default, x2Default, y1 && y2 == 0 ) && 1:3
        % 1:5   % lin = LinearFunction(nice, a, x1, x2, bias)								% 
        % 2:5   % [lin, y] = LinearFunction(nice, a, x1, x2, x)								% == 1:4 && 1:2
        % 1:6   % lin = LinearFunction(nice, a, x1, x2, y1, y2)								% == 1:7 mit: biasDefault
        % 2:6   % [lin, y] = LinearFunction(nice, a, x1, x2, x, bias)						% == (1:7 mit: y1 && y2 == 0) && 1:3
        % 1:7   % lin = LinearFunction(nice, a, x1, x2, y1, y2, bias)						% 
        % 2:7   % [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x)						% == (1:7 mit: biasDefault) && (1:5 mit: biasDeafault)
        % 1:8   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2)				% == 1:9 mit: biasDefault
        % 2:8   % [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x, bias)				% == 1:7 && 1:5 
        % 1:9   % lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, bias)			% == 1:7 Auswertung von: xymin && xymax
        % 2:9   % [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x)		% == 2:10 mit: biasDefault
        % 1:10  % y = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)		% == 1:5 Auswertung von: xymin && xymax
        % 2:10  % [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)	% == 1:9 && 1:10


%% 1 Input
% 1 Output
% y = LinearFunction(x)
x11 = x;
% x11 = 0;
y = LinearFunction(x11);
disp(y);

%% 2 Inputs
% 1 Output
% y = LinearFunction(a, x)
a21 = a;
x21 = x;
% a21 = 1;
% x21 = 0;
y = LinearFunction(a, x);
disp(y);
% 2 Outputs
% [lin, y] = LinearFunction(nice, x)
nice22 = nice;
x22 = x;
% nice22 = 30;
% x22 = 0;
[lin22, y] = LinearFunction(nice, x);
disp(lin22);
disp(y);
t22 = linspace(x1Default, x2Default, nice22);
figure
hold on
plot(t22, lin22);
title(['2 Inputs "nice & x" -> 2 Outputs "lin, y = ',num2str(y),'"']);

%% 3 Inputs
% 1 Output
% y = LinearFunction(a, x, bias)
a31 = a;
x31 = x;
bias31 = bias;
% a31 = 1;
% x31 = 0;
% bias31 = 0;
y31 = LinearFunction(a31, x31, bias31);
disp(y31); 
% 2 Outputs
% [lin, y] = LinearFunction(nice, a, x)
nice32 = nice;
a32 = a;
x32 = x;
% nice32 = 30;
% a32 = 1;
% x32 = 0;
[lin32, y32] = LinearFunction(nice32, a32, x32);
disp(lin32);
disp(y32); 
t32 = linspace(x1Default, x2Default, nice32);
figure
hold on
plot(t32, lin32);
title(['3 Inputs "nice, a & x" -> 2 Outputs "lin, y = ',num2str(y32),'"']);

%% 4 Inputs
% 1 Output
% lin = LinearFunction(nice, a, x1, x2)
nice41 = nice;
a41 = a;
x141 = x1;
x241 = x2;
% nice41 = 30;
% a41 = 1;
% x141 = -6;
% x241 = 6;
lin41 = LinearFunction(nice41, a41, x141, x241);
disp(lin41);
t41 = linspace(x141, x241, nice41);
figure
hold on
plot(t41, lin41);
title('4 Inputs "nice, a, x1, x2" -> 1 Output "lin"');
% 2 Outputs
% [lin, y] = LinearFunction(nice, a, x, bias)
nice42 = nice;
a42 = a;
x42 = x;
bias42 = bias;
% nice42 = 30;
% a42 = 1;
% x42 = 0;
% bias42 = 0;
[lin42, y42] = LinearFunction(nice42, a42, x42, bias42);
disp(lin42);
disp(y42); 
t42 = linspace(x1Default, x2Default, nice42);
figure
hold on
plot(t42, lin42);
title(['4 Inputs "nice, a, x & bias" -> 2 Outputs "lin, y = ',num2str(y42),'"']);

%% 5 Inputs
% 1 Output
% lin = LinearFunction(nice, a, x1, x2, bias)
nice51 = nice;
a51 = a;
x151 = x1;
x251 = x2;
bias51 = bias;
% nice51 = 30;
% a51 = 1;
% x151 = -6;
% x251 = 6;
% bias51 = 0;
lin51 = LinearFunction(nice51, a51, x151, x251, bias51);
disp(lin51); 
t51 = linspace(x151, x251, nice51);
figure
hold on
plot(t51, lin51);
title('5 Inputs "nice, a, x1, x2 & x" -> 1 Output "lin"');
% 2 Outputs
% [lin, y] = LinearFunction(nice, a, x1, x2, x)
nice52 = nice;
a52 = a;
x152 = x1;
x252 = x2;
x52 = x;
% nice52 = 30;
% a52 = 1;
% x152 = -6;
% x252 = 6;
% x52 = 0;
[lin52, y52] = LinearFunction(nice52, a52, x152, x252, x52);
disp(lin52);
disp(y52); 
t52 = linspace(x152, x252, nice52);
figure
hold on
plot(t52, lin52);
title(['5 Inputs "nice, a, x1, x2 & x" -> 2 Outputs "lin, y = ',num2str(y52),'"']);

%% 6 Inputs
% 1 Output
% lin = LinearFunction(nice, a, x1, x2, y1, y2)
nice61 = nice;
a61 = a;
x161 = x1;
x261 = x2;
y161 = y1;
y261 = y2;
% nice61 = 30;
% a61 = 1;
% x161 = -6;
% x261 = 6;
% y161 = -1;
% y261 = 1;
lin61 = LinearFunction(nice61, a61, x161, x261, y161, y261);
disp(lin61);
t61 = linspace(x161, x261, nice61);
figure
hold on
plot(t61, lin61);
title('6 Inputs "nice, a, x1, x2, y1 & y2" -> 1 Output "lin"');
% 2 Outputs
% [lin, y] = LinearFunction(nice, a, x1, x2, x, bias)
nice62 = nice;
a62 = a;
x162 = x1;
x262 = x2;
x62 = x;
bias62 = bias;
% nice62 = 30;
% a62 = 1;
% x162 = -6;
% x262 = 6;
% x62 = 0;
% bias62 = 0;
[lin62, y62] = LinearFunction(nice62, a62, x162, x262, x62, bias62);
disp(lin62);
disp(y62); 
t62 = linspace(x162, x262, nice62);
figure
hold on
plot(t62, lin62);
title(['6 Inputs "nice, a, x1, x2, x & bias" -> 2 Outputs "lin, y = ',num2str(y62),'"']);

%% 7 Inputs
% 1 Output
% lin = LinearFunction(nice, a, x1, x2, y1, y2, bias)
nice71 = nice;
a71 = a;
x171 = x1;
x271 = x2;
y171 = y1;
y271 = y2;
bias71 = bias;
% nice71 = 30;
% a71 = 1;
% x171 = -6;
% x271 = 6;
% y171 = -1;
% y271 = 1;
% bias71 = 0;
lin71 = LinearFunction(nice71, a71, x171, x271, y171, y271, bias71);
disp(lin71);
t71 = linspace(x171, x271, nice71);
figure
hold on
plot(t71, lin71);
title('7 Inputs "nice, a, x1, x2, y1, y2 & bias" -> 1 Output "lin"');
% 2 Outputs
% [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x)
nice72 = nice;
a72 = a;
x172 = x1;
x272 = x2;
xymin72 = xymin;
xymax72 = xymax;
y172 = y1;
y272 = y2;
x72 = x;
bias72 = bias;
% nice72 = 30;
% a72 = 1;
% x172 = -6;
% x272 = 6;
% y172 = -1;
% y272 = 1;
% x72 = 0;
[lin72, y72] = LinearFunction(nice72, a72, x172, x272, y172, y272, x72);
disp(lin72);
disp(y72); 
t72 = linspace(x172, x272, nice72);
figure
hold on
plot(t72, lin72);
title(['7 Inputs "nice, a, x1, x2, y1, y2 & x" -> 2 Outputs "lin, y = ',num2str(y72),'"']);

%% 8 Inputs
% 1 Output
% lin = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2)
nice81 = nice;
a81 = a;
x181 = x1;
x281 = x2;
xymin81 = xymin;
xymax81 = xymax;
y181 = y1;
y281 = y2;
% nice81 = 30;
% a81 = 1;
% x181 = -6;
% x281 = 6;
% xymin81 = -3;
% xymax81 = 3;
% y181 = -1;
% y281 = 1;
lin81 = LinearFunction(nice81, a81, x181, x281, xymin81, xymax81, y181, y281);
disp(lin81); 
t81 = linspace(x181, x281, nice81);
figure
hold on
plot(t81, lin81);
title('8 Inputs "everything except x & bias" -> 1 Output "lin"');
% 2 Outputs
% [lin, y] = LinearFunction(nice, a, x1, x2, y1, y2, x, bias)
nice82 = nice;
a82 = a;
x182 = x1;
x282 = x2;
y182 = y1;
y282 = y2;
x82 = x;
bias82 = bias;
% nice82 = 30;
% a82 = 1;
% x182 = -6;
% x282 = 6;
% y182 = -1;
% y282 = 1;
% x82 = 0;
% bias82 = 0;
[lin82, y82] = LinearFunction(nice82, a82, x182, x282, y182, y282, x82, bias82);
disp(lin82);
disp(y82); 
t82 = linspace(x182, x282, nice82);
figure
hold on
plot(t82, lin82);
title(['8 Inputs "everything" -> 2 Outputs "lin, y = ',num2str(y82),'"']);

%% 9 Inputs
% 1 Output
% y = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
nice91 = nice;
a91 = a;
x191 = x1;
x291 = x2;
xymin91 = xymin;
xymax91 = xymax;
y191 = y1;
y291 = y2;
bias91 = bias;
% nice91 = 30;
% a91 = 1;
% x191 = -6;
% x291 = 6;
% xymin91 = -3;
% xymax91 = 3;
% y191 = -1;
% y291 = 1;
% bias91 = 0;
lin91 = LinearFunction(nice91, a91, x191, x291, xymin91, xymax91, y191, y291, bias91);
disp(lin91);
t91 = linspace(x191, x291, nice91);
figure
hold on
plot(t91, lin91);
title('9 Inputs "everything except x" -> 1 Output "lin"');
% 2 Outputs
% [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x)
nice92 = nice;
a92 = a;
x192 = x1;
x292 = x2;
xymin92 = xymin;
xymax92 = xymax;
y192 = y1;
y292 = y2;
x92 = x;
% nice92 = 30;
% a92 = 1;
% x192 = -6;
% x292 = 6;
% xymin92 = -3;
% xymax92 = 3;
% y192 = -1;
% y292 = 1;
% x92 = 0;
[lin92, y92] = LinearFunction(nice92, a92, x192, x292, xymin92, xymax92, y192, y292, x92);
disp(lin92);
disp(y92); 
t92 = linspace(x192, x292, nice92);
figure
hold on
plot(t92, lin92);
title(['9 Inputs "everything except bias" -> 2 Outputs "lin, y = ',num2str(y92),'"']);

%% 10 Inputs
% 1 Output
% y = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
nice101 = nice;
a101 = a;
x1101 = x1;
x2101 = x2;
xymin101 = xymin;
xymax101 = xymax;
y1101 = y1;
y2101 = y2;
x101 = x;
bias101 = bias;
% nice101 = 30;
% a101 = 1;
% x1101 = -6;
% x2101 = 6;
% xymin101 = -3;
% xymax101 = 3;
% y1101 = -1;
% y2101 = 1;
% x101 = 0;
% bias101 = 0;
y101 = LinearFunction(nice101, a101, x1101, x2101, xymin101, xymax101, y1101, y2101, x101, bias101);
disp(y101); 
% 2 Outputs
% [lin, y] = LinearFunction(nice, a, x1, x2, xymin, xymax, y1, y2, x, bias)
nice102 = nice;
a102 = a;
x1102 = x1;
x2102 = x2;
xymin102 = xymin;
xymax102 = xymax;
y1102 = y1;
y2102 = y2;
x102 = x;
bias102 = bias;
% nice102 = 30;
% a102 = 1;
% x1102 = -6;
% x2102 = 6;
% xymin102 = -3;
% xymax102 = 3;
% y1102 = -1;
% y2102 = 1;
% x102 = 0;
% bias102 = 0;
[lin102, y102] = LinearFunction(nice102, a102, x1102, x2102, xymin102, xymax102, y1102, y2102, x102, bias102);
disp(lin102);
disp(y102); 
t102 = linspace(x1102, x2102, nice102);
figure
hold on
plot(t102, lin102);
title(['10 Inputs "everything" -> 2 Outputs "lin, y = ',num2str(y102),'"']);
