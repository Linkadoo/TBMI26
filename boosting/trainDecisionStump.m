function [threshMin, polarityMin, errorVec, emin, kmin] = trainDecisionStump( featureMatrix, Y, weights)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    threshMin = 0;
    emin = inf;
    polarityMin = 0;
    kmin = 0;
    errorVec = zeros(size(Y,1),1);

for k = 1:size(featureMatrix,1)          
    
    kthFeature = featureMatrix(k,:)';    
    for j = 1:size(kthFeature,1)
       polarity = 1;
       tempThresh = kthFeature(j);
       [errorTemp, errorTempV] = weakClassifier(kthFeature,Y,tempThresh,weights); 
       if(errorTemp > 0.5)
            polarity = -1;
            errorTemp = 1 - errorTemp;
       end
       if(errorTemp < emin)
           kmin = k;
           threshMin = tempThresh;
           emin = errorTemp;
           if(emin < 0.000001)
               emin = 0.000001
           end
           polarityMin = polarity;
           errorVec = errorTempV;
       end 
    end 
   if(errorTemp < 0.0001)
       x = 12;
   end
end

