% Script per classificar manualment si una imatge ull est� mirant a la c�mera o no
% 1 => mira, 0 => no mira

% Generar todos los pares de ojos
imf = dir('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\Dataset\*.pgm'); % llista d'imatges amb extensio pgm
n = length(imf); % nombre d'imatges en el directori
x = 384;
y = 286;
diffx = 400/x;
diffy = 400/y;
for i = 1 : n
     name = imf(i).name;
     im = imread(strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\Dataset\', name));
     im_imadjust = imadjust(im);  
     im = imresize(im_imadjust,[400 400]); 
     nameEye = strrep(name,'pgm','eye');
     fileID = fopen(strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\Dataset\', nameEye));
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
         imwrite(eye1,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyes\EYE1_',nameEye,'.png'));
     end
end

% Por cada ojo, mostrar su imagen y clickar en 1 o 0 (si mira o no)
imf = dir('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyes\*.png');
for i = 1 : n
    name = imf(i).name;
    im = imread(strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyes\', name));
    imshow(im);
    button = questdlg('Mira a c�mera?');
    if strcmp(button,'Yes')
        imwrite(im,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyesClassified\Miran\',name));
    else if strcmp(button,'No')
            imwrite(im,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyesClassified\NoMiran\',name));
        else
            break;
        end
    end
    close(gcf)
end


% Classificaci� autom�tica amb el Excel proporcionat al Rac�
imf = dir('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyes\*.png');
n = length(Majoria);
for i = 1:n
    name = imf(i).name;
    im = imread(strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyes\', name));
    if Majoria(i)
        imwrite(im,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyesClassified\Miran\',name));
    else
        imwrite(im,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyesClassified\NoMiran\',name));
    end
end


% Separaci� en Train i Test
imf = dir('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyes\*.png');
n = length(Majoria);
for i = 1:n
    name = imf(i).name;
    im = imread(strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyes\', name));
    if rand < 0.7  
        if Majoria(i)
            imwrite(im,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTrain\Miran\',name));
        else
            imwrite(im,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTrain\NoMiran\',name));
        end
    else
        imwrite(im,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTest\',name));
    end
end


% Generar todos los ojos separados
imf = dir('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\Dataset\*.pgm'); % llista d'imatges amb extensio pgm
n = length(imf); % nombre d'imatges en el directori
x = 384;
y = 286;
diffx = 400/x;
diffy = 400/y;

for i = 1 : n
     name = imf(i).name;
     im = imread(strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\Dataset\', name));
     im_imadjust = imadjust(im);    
     im = imresize(im_imadjust,[400 400]);
     nameEye = strrep(name,'pgm','eye');
     fileID = fopen(strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\Dataset\', nameEye));
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
         imwrite(eye1,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyesSeparated\EYE1_',nameEye,'.png'));
         imwrite(eye2,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyesSeparated\EYE2_',nameEye,'.png'));
     end
end

% Separaci� en Train i Test
imf = dir('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyesSeparated\*.png');
n = length(Majoria);
for i = 1:n
    name1 = imf(i).name;
    name2 = strrep(name1,'EYE1','EYE2');
    im1 = imread(strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyesSeparated\', name1));
    im2 = imread(strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\AllEyesSeparated\', name2));
    if rand < 0.7  
        if Majoria(i)
            imwrite(im1,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTrainSeparated\Miran\',name1));
            imwrite(im2,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTrainSeparated\Miran\',name2));
        else
            imwrite(im1,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTrainSeparated\NoMiran\',name1));
            imwrite(im2,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTrainSeparated\NoMiran\',name2));
        end
    else
        imwrite(im1,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTestSeparated\',name1));
        imwrite(im2,strcat('C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTestSeparated\',name2));
    end
end