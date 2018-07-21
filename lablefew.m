
id=unique(labelsTrain);
idxtemp = randperm(length(id));
numTrain=(labelRatio*length(id));
idxtrain=idxtemp(1:numTrain);
lablesTrainFew=zeros(size(labelsTrain));%for testing
for k=1:length(labelsTrain)
    is_train=0;
    for j=1:length(idxtrain)
        if labelsTrain(k)==id(idxtrain(j))
            is_train=1;
            break;
        end
    end
    if is_train==0
        lablesTrainFew(k)=-1;
    else
        lablesTrainFew(k)=labelsTrain(k);
    end
        
end


