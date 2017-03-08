function [ totalError, Error] = weakClassifier(Xdata, Ydata, threshold, weights)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

Error = zeros(size(Xdata,1),1);

    for j = 1:size(Xdata,1)
       if(Xdata(j) < threshold)
           Xdata(j) = -1;
       else
           Xdata(j) = 1;
       end
       
       if(Ydata(j) ~= Xdata(j))
           Error(j) = 1;
       end
       %Error(j) = Ydata(j) - Xdata(j);
       %Change negative sign to positive
       %if(Error(j) < 0)
       %    Error(j) = Error(j) * -1;
       %end
    end
    
    totalError = sum(Error .* weights);
    
    if(threshold == -273)
        weights;
        Error;
        totalError;
        x = 3;
    end
    
    if(totalError < 0.001)
        totalError = 0.001;
    elseif(totalError > 1)
        totalError = 1;
    end
end

