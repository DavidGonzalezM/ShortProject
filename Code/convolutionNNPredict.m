I = imread('BioID_0018.pgm.png');
figure
imshow(I);
hold on

[n m] = size(I)
maxEye = 0;
eyePos = [0 0];
for i = 1 : 2 : n - 20
    i
    for j = 1 : 2 : n - 40
        subimage = I(i:i+20, j:j+40);
        %imshow(subimage);
        P = predict(net,subimage);
        %P(1) es EYE en mi caso. Podría cambiar según modelo entrenado
        if (P(1) > 0.90 && P(1) > maxEye)
%             eyePos = [j i];
%             maxEye = P(1);
                rectangle('Position',[j,i,41,21],...
                    'Curvature',[0.8,0.4],...
                    'EdgeColor', 'r',...
                    'LineWidth', 1,...
                    'LineStyle','-')
        end
    end
end
