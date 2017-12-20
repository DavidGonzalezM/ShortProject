imf = dir('..\..\Dataset\*.pgm'); % llista d'imatges amb extensio pgm
n = length(imf); % nombre d'imatges en el directori
x = 384;
y = 286;
diffx = 200/x;
diffy = 200/y;

for i = 1 : n
     name = imf(i).name;
     im = imread(strcat('..\..\Dataset\', name));
     im = imresize(im,[200 200]);

     if rand < 0.7  % 70% de les imatges son de Train
         % Generar 2 ulls i 18 no-ulls
         % Guardar aquestes 20 imatges de 21x11 en Train
         nameEye = strrep(name,'pgm','eye');
         fileID = fopen(strcat('..\..\Dataset\', nameEye));
         fgetl(fileID);
         imEye=strsplit(fgetl(fileID));
         fclose(fileID);
         eyes = cellfun(@str2num, imEye);
         eyes(1) = round(eyes(1) * diffx);
         eyes(2) = round(eyes(2) * diffy);
         eyes(3) = round(eyes(3) * diffx);
         eyes(4) = round(eyes(4) * diffy);
         if  (10<eyes(1) && eyes(1)<190) && (5<eyes(2) &&  eyes(2)<195) && (10<eyes(3) && eyes(3)<190) && (5<eyes(4) && eyes(4)<195)
             eye1 = imadjust(im((eyes(2)-5):(eyes(2)+5),(eyes(1)-10):(eyes(1)+10)));
             eye2 = imadjust(im((eyes(4)-5):(eyes(4)+5),(eyes(3)-10):(eyes(3)+10)));
             imwrite(eye1,strcat('..\..\Train\Eye\EYE1_',nameEye,'.png'));
             imwrite(eye2,strcat('..\..\Train\Eye\EYE2_',nameEye,'.png'));
             noeyes = generateNoEyes(eyes);
             count = 1;
             for j = 1:2:36
                 noeye = im((noeyes(j+1)-5):(noeyes(j+1)+5),(noeyes(j)-10):(noeyes(j)+10));
                 imwrite(noeye,strcat('..\..\Train\NoEye\NOEYE',int2str(count),'_',nameEye,'.png'));
                 count = count + 1;
             end
         end
     else           % 30% de les imatges son de Test
         % Guardar imatge en Test
         imwrite(im,strcat('..\..\Test\',name,'.png'))
     end
end