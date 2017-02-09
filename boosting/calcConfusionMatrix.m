function [ cM ] = calcConfusionMatrix( Lclass, Ltrue )
classes = unique(Ltrue);
numClasses = length(classes);
cM = zeros(numClasses);

    %For each classification put it in the correct spot in the cM
    for i = 1:length(Lclass)
        if(Lclass(i) == -1)
            Lclass(i) = 2;
        end
        
        if(Ltrue(i) == -1)
            Ltrue(i) = 2;
        end
        
        trueValue = Ltrue(i);
        ourValue = Lclass(i);
        cM(trueValue,ourValue) = cM(trueValue,ourValue) + 1;
    end


end

