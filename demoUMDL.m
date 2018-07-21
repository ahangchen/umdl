clc;
clear;
warning('off', 'all');                                                

pars.alpha=5;   % lambda in (1)
pars.gamma=0.1; %
pars.vars=1.0;  %To make ||d^2_i||<=1
pars.beta=0.8;  % һ6
lambda2=0.25;   % For testing procedure.
pars.numbaseS=150; %The size of the Shared dictionary 
pars.numbaseU=150; %The size of the Unique dictionary 
pars.numbaseR=150; %The size of the Residual dictionary. 
pars.numIters=40; %The number of iterations 
labelRatio=0.0;  % The ratio of labelled data in the train dataset from the target data. For example,1 for supervised learning and 0 for un-supervised learning. 0.33 means 33% of training samples are labelled.
tasks=[];
loadSourceData; % Load train data from source datasets.
tasks=[tasks,10];
target_task=length(tasks);

t=1;
%for ntrials=1:10  %10 training-test splits
%loadVIPeRData;    % Load the target data from VIPeR
%loadUndergroundData;
loadMarket1501Data;
lablefew;         %
M{target_task}= zeros(length(labelsTrain),length(labelsTrain));%
disp('M constructed');
Dinit=[];
tic;
for iter=1:3%
%% Dictionary Learning
[ Ds,Du,Dr] = learnUMDL( F_MT_train,tasks,target_task,M,weight,pars,Dinit); %Training
D=[Ds,Du];%
DD=[D,Dr{target_task}];

%% Update graph laplacian matrix in the target data
XA=learn_coefficients_noise(DD,featureTrain,lambda2);%add 29-1
%XA=learn_coefficients_noise(DD,featureTrain(175:5138,:),lambda2);%for testing
X1=XA(1:size(D,2),:); 
Mtf=constructWmatrix(lablesTrainFew,X1,camTrain,1);
M{target_task}= Mtf;

%% 
 Dinit.Ds=Ds;
 Dinit.Du=Du;
 Dinit.Dr=Dr;
 toc;
 tic;
mfl=matfile('trainingResult.mat');
save('trainingResult.mat','DD','featureTest','XA','labelsTest','camTest','D','camID');
 evaluateUMDL; %Test
 toc;
rss(t,:)=r; %Evaluation result 
t=t+1;
end
%rs(ntrials,:)=r;
%end

mf=matfile('evaluationResult.mat');
save('evaluationResult.mat','rss','r','result');










%% Target dataset retrain  %%


% Untitled;
