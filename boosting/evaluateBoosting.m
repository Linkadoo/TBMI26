%% Load face and non-face data and plot a few examples
load faces, load nonfaces
faces = double(faces); nonfaces = double(nonfaces);
figure(1)
colormap gray
for k=1:25
subplot(5,5,k), imagesc(faces(:,:,10*k)), axis image, axis off
end
figure(2)
colormap gray
for k=1:25
subplot(5,5,k), imagesc(nonfaces(:,:,10*k)), axis image, axis off
end
%% Generate Haar feature masks

nbrHaarFeatures = 100;
haarFeatureMasks = GenerateHaarFeatureMasks(nbrHaarFeatures);
figure(3)
colormap gray
for k = 1:25
subplot(5,5,k),imagesc(haarFeatureMasks(:,:,k),[-1 2])
axis image,axis off
end
%% Create a training data set with a number of training data examples
% from each class. Non-faces = class label y=-1, faces = class label y=1
nbrTrainExamples = 300;
trainImages = cat(3,faces(:,:,1:nbrTrainExamples),nonfaces(:,:,1:nbrTrainExamples));
testImages = cat(3,faces(:,:,nbrTrainExamples:nbrTrainExamples*2),nonfaces(:,:,nbrTrainExamples:nbrTrainExamples*2));
xTrain = ExtractHaarFeatures(trainImages,haarFeatureMasks);
xTest = ExtractHaarFeatures(testImages,haarFeatureMasks);
yTrain = [ones(1,nbrTrainExamples), -ones(1,nbrTrainExamples)];
yTest = [ones(1,size(testImages,3)/2), -ones(1,size(testImages,3)/2)];


%%
[alfa, thresh, polarity, feat] = trainBoosting(xTrain, yTrain,10);

Lclass = strongClassifier(xTest,polarity, thresh, alfa, feat);

cM = calcConfusionMatrix(Lclass,yTest);
acc = calcAccuracy(cM)
