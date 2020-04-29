function [netTerms, output] = GetNeuronOutput(inputs, weights, bias, domainOfDefinition, type)
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
   
   % Gueltigkeitsbereich der Zwischenergebnisse einschraenken
   if (domainOfDefinition ~= 0)
      while (netOutput > domainOfDefinition) || (-domainOfDefinition > netOutput)
         netOutput = netOutput ./ 2;
         netTerms = netTerms ./ 2;
         error('Zahlenbereich ueberschritten') 
      end
   end
      
   % Funktion zuordnen
   if strcmp(type, 'sigmoid')
      output = SigmoidFunction(netOutput, bias);
   elseif strcmp(type, 'linear')
      output = netOutput;
   else
      error('type unknown, use sigmoid')  
   end
    
end
