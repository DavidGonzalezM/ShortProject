I = imread('BioID_0240.pgm.png');
figure
imshow(I);
hold on
cont = 1;
[n m] = size(I)
for i = 1 : 3 : n - 35
    i
    for j = 1 : 3 : n - 65
        subimage = imadjust(I(i:i+20, j:j+40));
        %imshow(subimage);
        predFeatures = extractHOGFeatures(subimage, 'CellSize', cellSize);
        predictedLabels = predict(classifier, predFeatures);
        if (predictedLabels ~= 'NoEye')
             rectangle('Position',[j,i,41,21],...
                 'Curvature',[0.8,0.4],...
                 'EdgeColor', 'r',...
                 'LineWidth', 1,...
                 'LineStyle','-');
        end
    end
end

