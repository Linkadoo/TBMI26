function [threshMin, polarityMin, errorVec, emin] = trainDecisionStump( featureMatrix, Y, weights)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

for k = 1:size(featureMatrix,1)
    
    kthFeature = featureMatrix(k,:)';
    
    kthFeature2 = sort(kthFeature);
    kthFeature2 = [kthFeature(1)-1; kthFeature; kthFeature(end)+1];
    
    emin = inf;
    for j = 1:size(kthFeature2,1)-1
       polarity = 1;
       tempThresh = (kthFeature2(j) + kthFeature2(j+1))/2;
       [errorTemp, errorTempV] = weakClassifier(kthFeature,Y,tempThresh,weights); 
       
       if(errorTemp > 0.5)
            polarity = -1;
            errorTemp = 1 - errorTemp;
       end
       
       if(errorTemp < emin)
           threshMin = tempThresh;
           emin = errorTemp;
           polarityMin = polarity;
           errorVec = errorTempV;
           if(emin < 0)
               213;
           end
       end 
    end
end

