I = imread('BioID_1454.pgm.png');
%I = imread('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\DoubleTest\BioID_0712.pgm.png');
%I = imread('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\ExtraTest\WonderW.jpg');
%I = rgb2gray(I);

figure
imshow(I);
hold on
cont = 1;
[n m] = size(I);
cellSize = [1 2];  % tiene que ser igual que el entrenamiento
result = zeros(1,2);
maxscore = 0;
for i = 60 : 2 : n - 200 %para acelerar el proceso asumimos que los ojos estaran de la mitad 
    %para arriba y del 30% de las filas para abajo
    for j = 100 : 2 : n - 200 % tambien asumimos que estará entre los 2/4 y 3/4 de las columnas aprox.
        subimage = I(i:i+30, j:j+120); %Ventana de escaneo de la imagen en busca de posibles ojos
        %la ventana es ligeramente mayor que la ventana del predictor por
        %temas de proximidad de la cara a la camara.
        subimage = imresize(subimage, [31 110]); % subImagen candidata
        predFeatures = extractHOGFeatures(subimage, 'CellSize', cellSize); % predicción
        [label score] = predict(classifier, predFeatures); %[predicción puntuación]
        sc = abs(score(2));
        if (label ~= 'NoEye' & sc > maxscore) %Nos quedamos con la ventana con mayor puntuación
            result(1) = i;
            result(2) = j;
            maxscore = sc;
        end
    end
end

eye.prob = maxscore;
eye.j = result(2);
eye.i = result(1);
EYES(cont) = eye;
rectangle('Position',[result(2),result(1),130,31],...
        'Curvature',[0.8,0.4],...
        'EdgeColor', 'r',...
        'LineWidth', 1,...
        'LineStyle','-')

