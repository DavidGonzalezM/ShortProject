img = imread('EYE1_BioID_0011.eye.png');
[featureVector,hogVisualization] = extractHOGFeatures(img, 'CellSize',[2 2]);


imshow(img);
figure;
imshow(zeros(21,41)); 
hold on;
plot(hogVisualization);