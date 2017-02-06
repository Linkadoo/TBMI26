function [ found ] = myfind(array, value)
%FIND Summary of this function goes here
%   Detailed explanation goes here
    found = 0;
    arraySize = size(array);
    for i = 1:arraySize
        if(array(i) == value)
            found = 1;
            return;
        end
    end
end

