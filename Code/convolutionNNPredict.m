I = imread('BioID_0240.pgm.png');
figure
imshow(I);
hold on
cont = 1;
[n m] = size(I)
for i = 1 : 3 : n - 20
    i
    for j = 1 : 3 : n - 40
        subimage = I(i:i+20, j:j+40);
        %imshow(subimage);
        P = predict(net,subimage);
        %P(1) es EYE en mi caso. Podría cambiar según modelo entrenado
        if (P(1) > 0.50)
            eye.prob = P(1);
            eye.j = j;
            eye.i = i;
            EYES(cont) = eye;
            cont = cont + 1;
%                 rectangle('Position',[j,i,41,21],...
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

