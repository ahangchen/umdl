%ntrials=4;

%%  ��ȡ����   %%
load('/home/zzy/下载/data/Feature/VIPeR_norm_feature.mat'); %��ȡhand-draft����
%load('E:\2017srp\code_ReID_cvpr/data/Feature/underground_norm_feature.mat'); %��ȡhand-draft����
% h_feature=feature;
%   load('data/cnndata/VIPeR_CNNfeature.mat'); %��ȡCNN����
%  cnn_feature=feature;
% feature=[cnn_feature/20;h_feature];
clear pattribute;
%% ��ݼ����� %%
 load('/home/zzy/下载/data/Split/VIPeR_split_kcca.mat');  %KCCA �������õ��Ļ��ַ�ʽ
%load('E:\2017srp\code_ReID_cvpr\data\Split\underground_split_kcca.mat');
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
       index=find(ID(:)==labelsAtrain(i)-1);
       featureTrain=[featureTrain,feature(:,index)];
       labelsTrain=[labelsTrain,ID(index)];
       camTrain=[camTrain,camID(:,index)];
   end
   
     for i=1:length(labelsAtest)
       index=find(ID(:)==labelsAtest(i)-1);
       featureTest=[featureTest,feature(:,index)];
       labelsTest=[labelsTest,ID(index)];
       camTest=[camTest,camID(:,index)];
     end
F_MT_train{target_task}=featureTrain;
weight(target_task)=1;
 clear trials;
    
  disp('Target data loaded');


