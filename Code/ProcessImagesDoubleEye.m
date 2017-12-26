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

     if rand < 0.7  
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
             e1 = max(eyes(1),eyes(3));
             e2 = min(eyes(1),eyes(3));
             e3 = min(eyes(2),eyes(4));
             e4 = max(eyes(2),eyes(4));
             eye1 = imresize(im((e3-15):(e4+15),(e2-20):(e1+20)) , [31 110]);
             imwrite(eye1,strcat('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\DoubleTrain\Eye\EYE1_',nameEye,'.png'));
             noeyes = generateDoubleNoEyes(eyes);
             count = 1;
             for j = 1:2:18
                 noeye = imresize(im((noeyes(j+1)-15):(noeyes(j+1)+15),(noeyes(j)-20):(noeyes(j)+60)) , [31 110]);
                 imwrite(noeye,strcat('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\DoubleTrain\NoEye\NOEYE',int2str(count),'_',nameEye,'.png'));
                 count = count + 1;
             end
         end
     else           % 30% de les imatges son de Test
         % Guardar imatge en Test
         imwrite(im,strcat('C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\DoubleTest\',name,'.png'))
     end
end