
%%   %%

load trainingResult.mat;
 lambda2=0.2;
 XA=learn_coefficients_noise(DD,featureTest,lambda2);%add 29-1
 % XA=learn_coefficients_noise(DD,featureTest(175:5138,:),lambda2);
 [ r,result,index]=evaluateCHUK( XA(1:size(D,2),:),labelsTest,camTest); %;r is the evaluation results.
 r(1)