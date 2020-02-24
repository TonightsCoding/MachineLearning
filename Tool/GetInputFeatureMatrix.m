function inputFeatureMatrix = GetInputFeatureMatrix( featureCnt, type )
%GetInputFeatureMatrix Erzeugt die Eingangs-Merkmale-Matrix (featureCnt x featureCnt)
    % featureCnt - Anzahl der Merkmale
    % Art der Eingangs-Merkmale ((default)'Cross', 'V_Line' und 'H_Line')

    if (nargin < 2) % default ('Cross') vorgeben
        type = 'Cross';
        warning('Kein Merkmaltyp angegeben: Es wurde "Cross" als default eingestellt!');
    end
    
    if (featureCnt > 2)
        if (mod(featureCnt, 2) == 0)  % Test ob featureCnt gerade ist        
            warning('Anzahl der Merkmale ist gerade und es werden die beiden innersten Merkmale gewählt!');
            type = [type '_even']; % type um '_even' ergaenzen
        end
    else
        error('Anzahl der Merkmale zu gering');    
    end
    
    inputFeatureMatrix = zeros(featureCnt, featureCnt);
    
    switch type % je nach type die Matrix mit 1 besetzen
        case 'V_Line'
            feature = ((featureCnt - 1)/2)+1;
            inputFeatureMatrix(1:featureCnt, feature) = 1;
        case 'V_Line_even'
            feature = featureCnt/2;
            inputFeatureMatrix(1:featureCnt, feature:(feature+1)) = 1;
        case 'H_Line'
            feature = ((featureCnt - 1)/2)+1;
            inputFeatureMatrix(feature, 1:featureCnt) = 1;
        case 'H_Line_even'
            feature = featureCnt/2;
            inputFeatureMatrix(feature:(feature+1), 1:featureCnt) = 1;
        case 'Cross'
            feature = ((featureCnt - 1)/2)+1;
            inputFeatureMatrix(1:featureCnt, feature) = 1;
            inputFeatureMatrix(feature, 1:featureCnt) = 1;
        case 'Cross_even'
            feature = featureCnt/2;
            inputFeatureMatrix(1:featureCnt, feature:(feature+1)) = 1;
            inputFeatureMatrix(feature:(feature+1), 1:featureCnt) = 1;
        otherwise 
            error('Unbekannter Merkmaltyp! Bitte aus "Cross", "V_Line" oder "H_Line" waehlen');
    end
    
    inputFeatureMatrix = uint8(inputFeatureMatrix);
    
end

