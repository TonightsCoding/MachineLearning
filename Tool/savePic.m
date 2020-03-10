function savePic(bild1, bild2, matrixtype, rauschen, pattern)

   saveas(bild1, strcat('Type', matrixtype, '_Rauschen', rauschen, '_', pattern, '_Layer1', '.png'));
   saveas(bild2, strcat('Type', matrixtype, '_Rauschen', rauschen, '_', pattern, '_Layer2', '.png'));
   saveas(bild1, strcat('Type', matrixtype, '_Rauschen', rauschen, '_', pattern, '_Layer1', '.eps'));
   saveas(bild2, strcat('Type', matrixtype, '_Rauschen', rauschen, '_', pattern, '_Layer2', '.eps'));
   saveas(bild1, strcat('Type', matrixtype, '_Rauschen', rauschen, '_', pattern, '_Layer1', '.pdf'));
   saveas(bild2, strcat('Type', matrixtype, '_Rauschen', rauschen, '_', pattern, '_Layer2', '.pdf'));

end

%savePic(bild1, bild2, weightType, int2str(noise), inFeatureType)
