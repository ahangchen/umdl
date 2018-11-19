
%datanames={'PRID','CAVIAR4REID','i-LID','CUHK'};
% datanames={'underground','underground','underground','underground'};
% datanames={'market1501','market1501','market1501','market1501'};
% datanames={'VIPeR','VIPeR','VIPeR','VIPeR'};
datanames={'CUHK','CUHK','CUHK','CUHK'};
tasks=[1,2,3]; 
weight=[0.5,0.5,0.5];
t=0;
for d=tasks
    t=t+1;
   dataname=datanames{d};
   load(['data/Feature/',dataname,'_norm_feature.mat']);
   F_MT_train{t}=double(feature(1:4964,:));
   M{t}=constructWmatrix(ID,[],[],1);
end
clear feature;
clear pID;
clear pattribute;
disp('Source data loaded.');