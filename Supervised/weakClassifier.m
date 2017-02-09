function [ totalError, errorVector] = weakClassifier(Xdata, Ydata, threshold, weights)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

Error = zeros(size(Xdata,1),1);

    for j = 1:size(Xdata,1)
       if(Xdata(j) < threshold)
           Xdata(j) = -1;
       else
           Xdata(j) = 1;
       end
       
       Error(j) = Ydata(j) - Xdata(j);
       %Change negative sign to positive
       if(Error(j) < 0)
           Error(j) = Error(j) * -1;
       end
    end
    
    totalError = sum(Error/2 .* weights);
    errorVector = Error/2;

end

