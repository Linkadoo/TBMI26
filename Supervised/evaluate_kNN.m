%% This script will help you test out your kNN code

run setupSupervisedLab.m
%% Select which data to use:

% 1 = dot cloud 1
% 2 = dot cloud 2
% 3 = dot cloud 3
% 4 = OCR data

dataSetNr = 3; % Change this to load new data 

[X, D, L] = loadDataSet( dataSetNr );

% You can plot and study dataset 1 to 3 by running:
%%
hold on
plotCase(X,D)

%% Select a subset of the training features

numBins = 3; % Number of Bins you want to devide your data into
numSamplesPerLabelPerBin = 30; % Number of samples per label per bin, set to inf for max number (total number is numLabels*numSamplesPerBin)
selectAtRandom = true; % true = select features at random, false = select the first features

[ Xt, Dt, Lt ] = selectTrainingSamples(X, D, L, numSamplesPerLabelPerBin, numBins, selectAtRandom );
    
% Note: Xt, Dt, Lt will be cell arrays, to extract a bin from them use i.e.
% XBin1 = Xt{1};

%% Use kNN to classify data
% Note: you have to modify the kNN() function yourselfs.

% Set the number of neighbors
k = 3;

LkNN = kNN(Xt{2}, k, Xt{1}, Lt{1});

%% Calculate The Confusion Matrix and the Accuracy
% Note: you have to modify the calcConfusionMatrix() function yourselfs.

% The confucionMatrix
cM = calcConfusionMatrix( LkNN, Lt{2});

% The accuracy
acc = calcAccuracy(cM);

%% Plot classifications
% Note: You do not need to change this code.
if dataSetNr < 4
    plotkNNResultDots(Xt{2},LkNN,k,Lt{2},Xt{1},Lt{1});
else
    plotResultsOCR( Xt{2}, Lt{2}, LkNN );
end
%% 
acc3 = zeros(15,1);
for i = 1:15
    
    i
    acc3(i) = crossValidation(Xt, Lt, numBins,i);
        
end

plot(acc3)
%%      
%Present accuracy

figure;
hold on
plot(acc1,'b');
plot(acc2,'r');
plot(acc3,'g');
plot(acc4,'black');
legend('Set 1', 'Set 2','Set 3','Set 4')
xlabel('Number of kNNs')
ylabel('Accuracy')