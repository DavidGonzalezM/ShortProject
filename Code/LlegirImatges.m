% script per llegir les imatges d'un carpeta
imf = dir('..\..\Dataset\*.pgm'); % llista d'imatges amb extensio pgm
n = length(imf); % nombre d'imatges en el directori
images = zeros([n,400,400]); % array n imatges de mida 400 x 400
eyes = zeros([n,4]);

for i = 1 : 10
     name = imf(i).name;
     nameEye = strrep(name,'pgm','eye');
     im = imread(strcat('..\..\Dataset\', name));
     images(i,:,:) = imresize(im,[400 400]);
     
     fileID = fopen(strcat('..\..\Dataset\', nameEye));
     fgetl(fileID);
     imEye=strsplit(fgetl(fileID));
     fclose(fileID);
     [y x] = size(im);
     diffx = 400/x;
     diffy = 400/y;
     eyes(i,:) = cellfun(@str2num, imEye);
     eyes(i,1) = eyes(i,1) * diffx;
     eyes(i,2) = eyes(i,2) * diffy;
     eyes(i,3) = eyes(i,3) * diffx;
     eyes(i,4) = eyes(i,4) * diffy;
end

% mostrem les imatges
for index = 1 : 10
    figure
    I =  uint8(squeeze(images(index,:,:))); % squeeze elimina les dimensions que tenen mida 1 (singletons)
    imshow(I,[]);
    hold on
    plot([eyes(index,1)], [eyes(index,2)], 'r.');
    plot([eyes(index,3)], [eyes(index,4)], 'r.');
    hold off
end   