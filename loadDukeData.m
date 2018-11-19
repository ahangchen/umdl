ntrials=1;

%%  ��ȡ����   %%
load('data/Feature/duke_norm_feature.mat'); %��ȡhand-draft����
% h_feature=feature;
%   load('data/cnndata/VIPeR_CNNfeature.mat'); %��ȡCNN����
%  cnn_feature=feature;
% feature=[cnn_feature/20;h_feature];
clear pattribute;
%% ��ݼ����� %%
 load('data/Split/duke_split_kcca.mat');  %KCCA �������õ��Ļ��ַ�ʽ

labelsAtrain=trials(ntrials).labelsAtrain;
labelsAtest=trials(ntrials).labelsAtest;
pattribute=[];
featureTrain=[];%zeros(size(feature,1),length(labelsAtrain)*2);
labelsTrain=[];%zeros(1,length(labelsAtrain)*2);
   camTrain=[];%zeros(1,length(labelsAtrain)*2);
   featureTest=[];%zeros(size(feature,1),length(labelsAtest)*2);
   labelsTest=[];%zeros(1,length(labelsAtest)*2);
   camTest=[];%zeros(1,length(labelsAtest)*2);
   
   for i=1:length(labelsAtrain)
       index=find(ID(:)==labelsAtrain(i));
       featureTrain=[featureTrain,double(feature(:,index))];
    
       labelsTrain=[labelsTrain,ID(index)];
       camTrain=[camTrain,camID(:,index)];
   end
     for i=1:length(labelsAtest)
       index=find(ID(:)==labelsAtest(i));
       featureTest=[featureTest,feature(:,index)];

       labelsTest=[labelsTest,ID(index)];
       camTest=[camTest,camID(:,index)];
     end
     F_MT_train{target_task}=featureTrain;
%F_MT_train{target_task}=featureTrain(175:5138,:);%change for testing last 4964
weight(target_task)=1;
 clear trials;
    
  disp('Target data loaded');