function [ alfa, threshWeak, polarityWeak, feat] = trainBoosting( Xtrain, Ytrain, T)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    Samples = size(Xtrain,2);
    %Step 1.
    dweights = 1/Samples*ones(Samples,1);
    feat = zeros(T,1);
    threshWeak = zeros(size(T,1),1);%T,1);
    polarityWeak = zeros(size(T,1),1);%T,1);
    alfa = zeros(size(T,1),1);
    for t = 1:T %size(Xtrain,1)%
        feat(t) = randi([1 size(Xtrain,1)]);
        if(t==69)
            213;
        end
       [threshWeak(t,1),polarityWeak(t,1), errorVec, emin] = ...
           trainDecisionStump(Xtrain(feat(t),:),Ytrain(:),dweights);
      for i = 1:size(dweights,1)
          alfa(t,1) = 0.5 * log((1-emin)/emin);
          if(imag(alfa(t)) ~= 0)
              213;
          end
          if(errorVec(i) == 1) 
              dweights(i) = dweights(i) * exp(alfa(t));
            %  if(dweights(i) > 0.3)
            %      dweights(i) = 0;
            %  end
          else
              dweights(i) = dweights(i) * exp(-alfa(t));
          end
      end
      dweights = dweights / sum(dweights);
    end
end

