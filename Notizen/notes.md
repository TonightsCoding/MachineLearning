---
export_on_save:
    html: true
---

[Besprechung vom 24.04.2020](#besprechung-1)

# Besprechung 1

+ Erstes Ziel: Blockschaltbild erstellen mit Zahlenbereichen  

+ lowerBound und upperBound müssten in HW eher zwischen -0,75 und 0,25. Wir lassen es ersteinmal so (-0,7 bis 0,3), um später eine Optimierung zu haben.
![](./Bilder/2020-04-24_Bild1.PNG)  

+ Zahlenbereiche für Neuronen Ebende
 ![](./Bilder/2020-04-24_Bild2.PNG)
 ![](./Bilder/2020-04-24_Bild3.PNG)
 ![](./Bilder/2020-04-24_Bild4.PNG)

 + Gewichtsmatrix ([Link zur Textdatei](./Bilder/myData.txt))
    ```
    G = table(weightMatrix)
    writetable(G,'myData.txt','Delimiter',';')
    ```  
      
+ wichtige Parameter für die HW- Simulation
    - Pixel Count
    - Feature Count
    - Gewichtsmatrix
    - (Bias) -> Toni sagt "NEIN!"
        * h-Balken
        * v-Balken
        * Fehler Detektion
    - Threshold (3. Ebene) -> Balkenausgabe
        * h-Balken
        * v-Balken
        * Fehler Detektion

    

+ Nächsten Ziele:
    + Blockschaltbild für seriellen Ablauf aus Sicht eines Merkmals (@Toni)
    + Bei Übersicht noch Bias verschieben an Phi und rund machen
    + Farbig machen und Gregorius nochmal schicken
    + wie funktioniert ein float, SW / HW (@Toni und Bryan)
    + definierte Schnittstelle (Vor-Simulation -> HW-Simulation)  (@Bryan)
        - 2 Funktionen für jede Simulation
    + Umrechnung von tatsächlichen in Fixed Point
    + Symetrische Aufteilung der Matrizen (@Bryan)
    + [Matrix-FixedPoint, Matrix-Fehler] = Float_to_Fixed(Matrix-Float, Format)
    + [Matrix-FixedPoint, Format] = Find_Fixed_for_Float(Matrix-Float, Maximale Abweichung) -> Fehler = Matrix-Float - Matrix-FixedPoint & Format ist eine Matrix die während der Suche befüllt
        
+ weitere Ziele:
    + Simulation für Hardware
        + HW - Neuron, erstmal mit großem integer Zahlenwert (@Bryan)
        + Gewichtmatrix aus Textdatei einlesen
        + Umwandlung von float in integer (fixpoint)
    + Funktion für Zahlenbereichsoptimierung
    + simuliertes Hardware-Neuron
        - Addierer
        - Multiplizierer
        - Größe Summe des Ausgangs -> Zweierpotenz
    + automatische Optimierung der Gewichte auf eines Zahlenbereich
