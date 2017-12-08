imf = dir('..\..\Dataset\*.pgm'); % llista d'imatges amb extensio pgm
n = length(imf); % nombre d'imatges en el directori
x = 384;
y = 286;
diffx = 400/x;
diffy = 400/y;

for i = 1 : 10
     name = imf(i).name;
     im = imread(strcat('..\..\Dataset\', name));
     im = imresize(im,[400 400]);

     if rand < 0.7  % 70% de les imatges son de Train
         % Generar 2 ulls i 18 no-ulls
         % Guardar aquestes 20 imatges de 40x20 en Train
         nameEye = strrep(name,'pgm','eye');
         fileID = fopen(strcat('..\..\Dataset\', nameEye));
         fgetl(fileID);
         imEye=strsplit(fgetl(fileID));
         fclose(fileID);
         eyes = cellfun(@str2num, imEye);
         eyes(1) = eyes(1) * diffx;
         eyes(2) = eyes(2) * diffy;
         eyes(3) = eyes(3) * diffx;
         eyes(4) = eyes(4) * diffy;
         eye1 = im((eyes(2)-10):(eyes(2)+10),(eyes(1)-20):(eyes(1)+20));
         eye2 = im((eyes(4)-10):(eyes(4)+10),(eyes(3)-20):(eyes(3)+20));
         imwrite(eye1,strcat('..\..\Train\',nameEye,'EYE1.png'));
         imwrite(eye2,strcat('..\..\Train\',nameEye,'EYE2.png'));
     else           % 30% de les imatges son de Test
         % Guardar imatge en Test
         imwrite(im,strcat('..\..\Test\',name,'.png'))
     end
end