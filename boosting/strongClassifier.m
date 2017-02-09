function [ classification ] = strongClassifier(X, polarity, threshold, alfa )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

       temp = repmat(polarity,1,size(X,2)).*X >= ...
           repmat(polarity.*threshold,1,size(X,2));
       classification =  sign(sum(repmat(alfa,1,size(X,2)) .* (2*temp-1),1));

end

