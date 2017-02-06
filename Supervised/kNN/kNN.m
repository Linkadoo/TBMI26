function [ labelsOut ] = kNN(X, k, Xt, Lt)
%KNN Your implementation of the kNN algorithm
%   Inputs:
%               X  - Features to be classified - okänd
%               k  - Number of neighbors
%               Xt - Training features
%               LT - Correct labels of each feature vector [1 2 ...]'
%
%   Output:
%               LabelsOut = Vector with the classified labels

labelsOut  = zeros(size(X,2),1);
classes = unique(Lt);
numClasses = length(classes);
euclidianDistance = zeros(size(Xt,2),1);
numFeatures = size(X,1);
sizeTraining = size(Xt,2);
sizeToClassify = size(X,2);

for iter = 1:sizeToClassify
    
toBeClassified = X(1:end,iter);

% For each training sample 
for j = 1:sizeTraining
    
    currentTrainingSample = Xt(1:end,j);
    
    % Calc distance for one point and one training data:
    for i=1:numFeatures 
        euclidianDistance(j) = euclidianDistance(j) + (toBeClassified(i) - currentTrainingSample(i))^2;  
    end
    euclidianDistance(j) = sqrt(euclidianDistance(j));

end

knn = zeros(k,1);

%Get index for each k nearest neighbour
for i = 1:k
   %Big value!
   min = 1000000;
   
   for j = 1:sizeTraining
       if(euclidianDistance(j) < min)
           %Checks if index already exists in knn
           if(myfind(knn,j) == 0)
               min = euclidianDistance(j);
               knn(i) = j;
           end
       end
   end
end

count = zeros(numClasses,1);

for i = 1:k
    class = Lt(knn(k));
    count(class) = count(class) + 1;
end

for i = 1:numClasses
    largest = 0;
    if(count(i) > largest)
        labelsOut(iter) = i;
        largest = count(i);
    elseif(count(i) == largest)
        %If k id even and it is a tie, we decide with the closest
        %neighbour.
        labelsOut(iter) = Lt(knn(1));
    end

end

end

