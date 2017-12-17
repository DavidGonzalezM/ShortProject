path = 'C:\Users\ruben.ajenjo\Desktop\ImagenesShortProject\Train\';
%Se han de guardar en la subcarpeta EYE los ojos y en la subcarpeta NO_EYE
%los no ojos para entrenamiento.

A = fullfile(path);

eyeData = imageDatastore(A,...
    'IncludeSubfolders',true,'LabelSource','foldernames');
perm = randperm(10000,20);

layers = [
    imageInputLayer([21 41 1])

    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(3,32,'Padding',1)
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(3,64,'Padding',1)
    batchNormalizationLayer
    reluLayer

    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

labelCount = countEachLabel(eyeData);

[trainData,valData] = splitEachLabel(eyeData,1800,'randomize');

options = trainingOptions('sgdm',...
    'MaxEpochs',3, ...
    'ValidationData',trainData,...
    'ValidationFrequency',30,...
    'Verbose',false,...
    'Plots','training-progress');


net = trainNetwork(valData,layers,options);