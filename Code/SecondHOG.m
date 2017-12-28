clear;
%path = 'C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\DoubleTrain';
%path = 'C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTrain';
path = 'C:\Users\David\Desktop\Universidad\Quatrimestre7\VC\lab\ShortProject\github\SecondTrainSeparated';
trainingSet = imageDatastore(path,   'IncludeSubfolders', true, 'LabelSource', 'foldernames');

numImages = numel(trainingSet.Files);

cellSize = [1 2]; % Este parametro se debe ajustar para probar distintos resultados

img = readimage(trainingSet, 1);
[a,b] = extractHOGFeatures(img, 'CellSize', cellSize);

trainingFeatures = zeros(numImages, length(a), 'single');

for i = 1:numImages
    img = readimage(trainingSet, i);

    trainingFeatures(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);
end

% Get labels for each image.
trainingLabels = trainingSet.Labels;

%100 de cada para testear la validez
testFeatures = [trainingFeatures(1:100,:);trainingFeatures(numImages-99:numImages,:)];
testLabels = [trainingLabels(1:100,:);trainingLabels(numImages-99:numImages,:)];

trainingFeatures = trainingFeatures(101:numImages-99,:);
trainingLabels = trainingLabels(101:numImages-99,:);

classifier = fitcecoc(trainingFeatures, trainingLabels);


%%%%%%%%%%%%%%TEST VALIDEZ MATRIZ DE CONFUSION

% Make class predictions using the test features.
predictedLabels = predict(classifier, testFeatures);

% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);

DisplayConfusionMatrix(confMat);