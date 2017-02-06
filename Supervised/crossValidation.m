function [avgAcc] = crossValidation(Xdata, Ydata, kfolds,k)
% Compute a crossvalidation for a given data set and returns the average
% accurcy.
        
        acc = 0;
        for i = 1:kfolds
            trainingData = Xdata;
            testX = Xdata{i};
            trainingData(i) = [];
            Xmatrix = cell2mat(trainingData);
            trainingY = Ydata;
            testY = Ydata{i};
            trainingY(i) = [];
            Ymatrix = cell2mat(trainingY);
            
            predicted = kNN(testX,k,Xmatrix,Ymatrix);
            cM = calcConfusionMatrix(predicted, testY);
            acc = calcAccuracy(cM) + acc;
            
        end
        
        avgAcc = acc / kfolds;
    
    %obs
end