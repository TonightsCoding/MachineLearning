function res = ConvMatrixToColumn(matrix)
   % Funktion liest Matrix zeilenweise ein und gibt matrix als
   % Spaltenvektor aus
   % res - gibt einen Spaltenvektor zurueck
   % matrix - zu konvertierende Matrix
   
   sizeMatrix = size(matrix);
   res = zeros(sizeMatrix(1)*sizeMatrix(2), 1);
   
   i=1;
   for y=1:sizeMatrix(1)
      for x=1:sizeMatrix(2)
         res(i) = matrix(y,x);
         i = i+1;
      end
   end
end
