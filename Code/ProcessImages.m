imf = dir('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\*.pgm'); % llista d'imatges amb extensio pgm
n = length(imf); % nombre d'imatges en el directori
x = 384;
y = 286;
diffx = 400/x;
diffy = 400/y;

for i = 1 : n
     name = imf(i).name;
     im = imread(strcat('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\', name));
     im_imadjust = imadjust(im);    
     im = imresize(im_imadjust,[400 400]);

     if rand < 0.7  % 70% de les imatges son de Train
         % Generar 2 ulls i 18 no-ulls
         % Guardar aquestes 20 imatges de 41x21 en Train
         nameEye = strrep(name,'pgm','eye');
         fileID = fopen(strcat('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\', nameEye));
         fgetl(fileID);
         imEye=strsplit(fgetl(fileID));
         fclose(fileID);
         eyes = cellfun(@str2num, imEye);
         eyes(1) = round(eyes(1) * diffx);
         eyes(2) = round(eyes(2) * diffy);
         eyes(3) = round(eyes(3) * diffx);
         eyes(4) = round(eyes(4) * diffy);
         if  (20<eyes(1) && eyes(1)<380) && (10<eyes(2) &&  eyes(2)<390) && (20<eyes(3) && eyes(3)<380) && (10<eyes(4) && eyes(4)<390)
             eye1 = im((eyes(2)-10):(eyes(2)+10),(eyes(1)-20):(eyes(1)+20));
             eye2 = im((eyes(4)-10):(eyes(4)+10),(eyes(3)-20):(eyes(3)+20));
             imwrite(eye1,strcat('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\Train\Eye\EYE1_',nameEye,'.png'));
             imwrite(eye2,strcat('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\Train\Eye\EYE2_',nameEye,'.png'));
             noeyes = generateNoEyes(eyes);
             count = 1;
             for j = 1:2:36
                 noeye = im((noeyes(j+1)-10):(noeyes(j+1)+10),(noeyes(j)-20):(noeyes(j)+20));
                 imwrite(noeye,strcat('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\Train\NoEye\NOEYE',int2str(count),'_',nameEye,'.png'));
                 count = count + 1;
             end
         end
     else           % 30% de les imatges son de Test
         % Guardar imatge en Test
         imwrite(im,strcat('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\Test\',name,'.png'))
     end
end