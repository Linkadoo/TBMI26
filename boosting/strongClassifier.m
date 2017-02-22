function [ classification ] = strongClassifier(X, polarity, threshold, alfa, feat )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%Reconstruct X for weak classifiers:
Xfeat = zeros(size(feat,1),size(X,2));
for i = 1:size(feat,1)
    Xfeat(i,:) = X(feat(i),:);
end   
       temp = repmat(polarity,1,size(X,2)).*Xfeat >= ...
           repmat(polarity.*threshold,1,size(X,2));
       classification =  sign(sum(repmat(alfa,1,size(X,2)) .* (2*temp-1),1));

end

