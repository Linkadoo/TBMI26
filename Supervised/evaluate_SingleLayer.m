%% This script will help you test out your single layer neural network code

%% Select which data to use:

% 1 = dot cloud 1
% 2 = dot cloud 2
% 3 = dot cloud 3
% 4 = OCR data

dataSetNr = 4; % Change this to load new data 

[X, D, L] = loadDataSet( dataSetNr );

%% Select a subset of the training features

numBins = 2; % Number of Bins you want to devide your data into
numSamplesPerLabelPerBin = 100; % Number of samples per label per bin, set to inf for max number (total number is numLabels*numSamplesPerBin)
selectAtRandom = true; % true = select features at random, false = select the first features

[ Xt, Dt, Lt ] = selectTrainingSamples(X, D, L, numSamplesPerLabelPerBin, numBins, selectAtRandom );

% Note: Xt, Dt, Lt will be cell arrays, to extract a bin from them use i.e.
% XBin1 = Xt{1};
%% Modify the X Matrices so that a bias is added

% The Training Data
Xtraining = [];
Xtraining  = [ones(1,size(Xt{1},2));Xt{1}]; % Remove this line

% The Test Data
Xtest = [];
Xtest  = [ones(1,size(Xt{2},2));Xt{2}]; % Remove this line


%% Train your single layer network
% Note: You nned to modify trainSingleLayer() in order to train the network

numIterations = 40000; % Change this, Numner of iterations (Epochs)
learningRate = 0.00005; % Change this, Your learningrate % OBS 0.0005 4th data set diverges.
W0 = zeros(size(D,1),size(Xtraining,1)); % Change this, Initiate your weight matrix W

[W, trainingError, testError, Wvalue ] = trainSingleLayer(Xtraining,Dt{1},Xtest,Dt{2}, W0,numIterations, learningRate );

% Plot errors
figure(1101)
clf
[mErr, mErrInd] = min(testError);
plot(trainingError,'k','linewidth',1.5)
hold on
plot(testError,'r','linewidth',1.5)
plot(mErrInd,mErr,'bo','linewidth',1.5)
hold off
title('Training and Test Errors, Single Layer')
legend('Training Error','Test Error','Min Test Error')


figure;
plot(Wvalue);
%% Calculate The Confusion Matrix and the Accuracy of the Evaluation Data
% Note: you have to modify the calcConfusionMatrix() function yourselfs.

[ Y, LSingleLayerTraining ] = runSingleLayer(Xtraining, W);
[ Y, LSingleLayerTest ] = runSingleLayer(Xtest, W);

% The confucionMatrix
cM = calcConfusionMatrix( LSingleLayerTest, Lt{2})

% The accuracy
acc = calcAccuracy(cM)

%% Plot classifications
% Note: You do not need to change this code.

if dataSetNr < 4
    plotResultSingleLayer(W,Xtraining,Lt{1},LSingleLayerTraining,Xtest,Lt{2},LSingleLayerTest)
else
    plotResultsOCR( Xtest, Lt{2}, LSingleLayerTest)
end
