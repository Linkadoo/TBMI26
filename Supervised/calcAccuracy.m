function [ acc ] = calcAccuracy( cM )
%CALCACCURACY Takes a confusion matrix amd calculates the accuracy

acc = 0; % Replace with your own code


correct = sum(diag(cM));
total = sum(sum(cM));

acc = correct/total;

end

