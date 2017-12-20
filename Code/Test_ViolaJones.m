% Test Viola-Jones

I = imread('..\..\Dataset\BioID_0000.pgm');
faceDetector = vision.CascadeObjectDetector('RightEye');
bboxes = step(faceDetector, I);
IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Eyes');   
figure, imshow(IFaces);


% openExample('vision/TrainAStopSignDetectorExample')

% 
% positiveFolder = fullfile('D:\Q7\VC\lab\Short Project\Train\Eye');
% positiveInstances = imageDatastore(positiveFolder);
% negativeFolder = fullfile('D:\Q7\VC\lab\Short Project\Train\NoEye');
% negativeImages = imageDatastore(negativeFolder);
% 
% trainCascadeObjectDetector('eyeDetector.xml',positiveInstances, ...
%     negativeFolder,'FalseAlarmRate',0.1,'NumCascadeStages',5);