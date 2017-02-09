function [ alfa, threshWeak, polarityWeak ] = trainBoosting( Xtrain, Ytrain, T)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    Samples = size(Xtrain,2);
    %Step 1.
    dweights = 1/Samples*ones(Samples,1);
    
    threshWeak = zeros(size(Xtrain,1),1);%T,1);
    polarityWeak = zeros(size(Xtrain,1),1);%T,1);
    alfa = zeros(size(Xtrain,1),1);
    for t = 1:size(Xtrain,1)%T
        if(t==64)
            213;
        end
       [threshWeak(t),polarityWeak(t), errorVec, emin] = ...
           trainDecisionStump(Xtrain(t,:),Ytrain(:),dweights);
      for i = 1:size(dweights,1)
          alfa(t) = 0.5 * log((1-emin)/emin);
            if(errorVec(i) == 1) 
                dweights(i) = dweights(i) * exp(alfa(t));
            else
                dweights(i) = dweights(i) * exp(-alfa(t));
            end
      end
      dweights = dweights / sum(dweights);
    end
end

