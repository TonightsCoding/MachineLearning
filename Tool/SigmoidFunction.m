function output = SigmoidFunction(x, bias)
   % res - gibt das Ergebnis zurueck
   % x - Variable der Funktion
   % bias - Verschiebung in x-Richtung -> Neg (rechts), Pos (links)

   output = 1./(1+exp(-(x+bias)));
end
