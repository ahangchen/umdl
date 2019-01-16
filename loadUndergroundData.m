% ntrials=1;

%%  ��ȡ����   %%
load('data/Feature/underground_norm_feature.mat'); %��ȡhand-draft����
% h_feature=feature;
%   load('data/cnndata/VIPeR_CNNfeature.mat'); %��ȡCNN����
%  cnn_feature=feature;
% feature=[cnn_feature/20;h_feature];
clear pattribute;
%% ��ݼ����� %%
 load('data/Split/grid_split_kcca.mat');  %KCCA �������õ��Ļ��ַ�ʽ

labelsAtrain=trials(ntrials).labelsAtrain;
labelsAtest=trials(ntrials).labelsAtest;
pattribute=[];
featureTrain=[];%zeros(size(feature,1),length(labelsAtrain)*2);
labelsTrain=[];%zeros(1,length(labelsAtrain)*2);
   camTrain=[];%zeros(1,length(labelsAtrain)*2);
   featureTest=[];%zeros(size(feature,1),length(labelsAtest)*2);
   labelsTest=[];%zeros(1,length(labelsAtest)*2);
   camTest=[];%zeros(1,length(labelsAtest)*2);
   indx=zeros(174,1);
   for i=1:174%add for testing,every29-1
       indx(i)=29*i;%%%
   end%%% add 29-1
   for i=1:length(labelsAtrain)
       index=find(ID(:)==labelsAtrain(i)-1);
       featureTrain=[featureTrain,feature(:,index)];
    
       labelsTrain=[labelsTrain,ID(index)];
       camTrain=[camTrain,camID(:,index)];
   end
     featureTrain(indx,:)=[];
     for i=1:length(labelsAtest)
       index=find(ID(:)==labelsAtest(i)-1);
       featureTest=[featureTest,feature(:,index)];

       labelsTest=[labelsTest,ID(index)];
       camTest=[camTest,camID(:,index)];
     end
     featureTest(indx,:)=[];
     F_MT_train{target_task}=featureTrain;
%F_MT_train{target_task}=featureTrain(175:5138,:);%change for testing last 4964
weight(target_task)=1;
 clear trials;
    
  disp('Target data loaded');