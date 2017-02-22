function [ alfa, threshWeak, polarityWeak, feat] = trainBoosting( Xtrain, Ytrain, T)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    Samples = size(Xtrain,2);
    %Step 1.
    dweights = 1/Samples*ones(Samples,1);
    %Initialize vectors
    feat = zeros(T,1);
    threshWeak = zeros(size(T,1),1);%T,1);
    polarityWeak = zeros(size(T,1),1);%T,1);
    alfa = zeros(size(T,1),1);
    
    %For each classifier
    for t = 1:T %size(Xtrain,1)%
        t
        
        %Train a weak classifier
       [threshWeak(t,1),polarityWeak(t,1), errorVec, emin, featureMin] = ...
           trainDecisionStump(Xtrain,Ytrain(:),dweights);
      
       feat(t) = featureMin;
       
       %Change the weights
       for i = 1:size(dweights,1)
          alfa(t,1) = 0.5 * log((1-emin)/emin);
          if(imag(alfa(t)) ~= 0)
              213;
          end
          if(errorVec(i) == 1) 
              dweights(i) = dweights(i) * exp(alfa(t));
            % Deal with outliers
            %  if(dweights(i) > 0.3)
            %      dweights(i) = 0;
            %  end
          else
              dweights(i) = dweights(i) * exp(-alfa(t));
          end
       end
      %Normalize weights
      dweights = dweights / sum(dweights);
    end
end

