function [netTerms, output] = GetNeuronOutput(inputs, weights, activation_function_x, activation_function_y)
   % Berechnet ein Neuron und gibt das Zwischen- und Endergebnis zurueck.
   %
   % returns:
   % netTerms - Zwischergebnisse als Spaltenvektor -> inputs * weights
   % output - Ausgang des Neurons
   %
   % inputs - Zustaende der Eingaenge als Spaltenvektor
   % weights - Gewichte der Eingaenge als Spaltenvektor
   % bias - Verschiebung in x-Richtung -> Neg (rechts), Pos (links)
   % domainOfDefinition - Ergebnis wird auf Gueltigkeitsbereich begrenzt
   % -> (+/- domainOfDefinition)
   % type - Typ der Aktivierungfunktion - akutell nur Sigmoidfunktion
   
   % Ueberpruefe, ob Eingaenge als Spaltenvektor vorliegen
   sizeInputs = size(inputs);
   if sizeInputs(2) > 1
      error('Eingaenge und Gewichte muessen Spaltenvektoren sein')
   end
   clear sizeInputs
   
   % Ueberpruefen, ob die Anzahl der Eingaenge und Gewichte zusammen passen
   if (length(inputs) ~= length(weights))
      error('Anzahl der angegebenen Eingänge und der Eingänge müssen gleich sein.')
   end

   % Eingaenge und Gewichten multiplizieren
   netTerms = weights .* inputs;
   
   % Summe ueber alle Zwischenergebnisse
   netOutput = sum(netTerms);
   
   len = length(activation_function_x);
   offset = activation_function_x(1);
   dx = (activation_function_x(end) - activation_function_x(1)) / len; 
   index = round((netOutput - offset) / dx);
   
   if (index <= 0)
      output = activation_function_y(1);
   elseif (index > len)
      output = activation_function_y(end);
   else
      output = activation_function_y(index);
   end
    
end
