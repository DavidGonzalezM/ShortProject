I = imread('BioID_0175.pgm.png');
figure
imshow(I);
hold on
cont = 1;
[n m] = size(I);
cellSize = [1 1];
for i = 60 : 1 : n - 200
    i
    for j = 100 : 1 : n - 100
        subimage = imadjust(I(i:i+20, j:j+40));
        %imshow(subimage);
        predFeatures = extractHOGFeatures(subimage, 'CellSize', cellSize);
        [label score] = predict(classifier, predFeatures);
        sc = abs(score(2));
        if (label ~= 'NoEye' & sc > 0.7)
            eye.prob = sc;
            eye.j = j;
            eye.i = i;
            EYES(cont) = eye;
            cont = cont + 1;
%             rectangle('Position',[j,i,41,21],...
%                     'Curvature',[0.8,0.4],...
%                     'EdgeColor', 'r',...
%                     'LineWidth', 1,...
%                     'LineStyle','-')
        end
    end
end
firstEye = [0 0];
secondEye = [0 0];
[n m] = size(EYES);
prob = 0;
pos = 0;
for i = 1:m
    if EYES(i).prob > prob
        prob = EYES(i).prob;
        pos = i;
    end
end

firstEye = [EYES(pos).j EYES(pos).i];
EYES(pos).prob = 0;

prob = 0;
pos2 = 0;
for i = 1:m
    dist = pdist2(firstEye,[EYES(i).j EYES(i).i],'euclidean'); %obtaining euclidean distance
    if EYES(i).prob > prob && dist > 20
        prob = EYES(i).prob;
        pos2 = i;
    end
end

secondEye = [EYES(pos2).j EYES(pos2).i];
rectangle('Position',[firstEye(1),firstEye(2),41,21],...
    'Curvature',[0.8,0.4],...
    'EdgeColor', 'r',...
    'LineWidth', 1,...
    'LineStyle','-')
rectangle('Position',[secondEye(1),secondEye(2),41,21],...
    'Curvature',[0.8,0.4],...
    'EdgeColor', 'r',...
    'LineWidth', 1,...
    'LineStyle','-')
