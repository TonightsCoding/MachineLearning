function res = SigmoidFunction(x, bias)
   % res - gibt das Ergebnis zurueck
   % x - Variable der Funktion
   % bias - Verschiebung in x-Richtung -> Neg (rechts), Pos (links)

   res = 1./(1+exp(-(x+bias)));
end
