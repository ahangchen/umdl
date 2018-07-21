 function [ r,result,index] = evaluateCHUK( Xtest,labels,camID)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes her
% Xtest=feature;
% labels=ID;

if ~isempty(camID)>0
index_camA=find(camID(:)==2);
index_camB=find(camID(:)==1);
Xa=Xtest(:,index_camA);
Xb=Xtest(:,index_camB);
labelsA=labels(index_camA);
labelsB=labels(index_camB);
[r,result,index]=evaluate( Xa,Xb,labelsA,labelsB);

save('evaluationResult0.mat','Xa','Xb','labelsA','labelsB','Xtest','result','labelsA','labelsB','index_camA','index_camB');
else
[m,n]=size(Xtest);

for i=1:n
    for j=1:n
       s0=0;
       s1=0;
       s2=0;
       
       for k=1:m
           s0=s0+Xtest(k,j)*Xtest(k,i);
           s1=s1+Xtest(k,i)*Xtest(k,i);
           s2=s2+Xtest(k,j)*Xtest(k,j);
       end
        score=-1*s0/sqrt(s1*s2);
        result(i,j)=score;
    end
end

pid=unique(labels);

rand_iters=10;
for iter=1:rand_iters
idx_A=[];
idx_B=[];
labels_A=[];
labels_B=[];

    
    for i=1:length(pid)
        idxpid=(find(labels(:)==pid(i)))';
        n=length(idxpid);
        idxtemp = randperm(n);
        idx_A=[idx_A, idxpid(idxtemp(1))];
        labels_A=[labels_A,pid(i)];
        idx_B=[idx_B,idxpid(idxtemp(2:n))];
        labels_B=[labels_B, labels(idxpid(2:n))];
             
    end
    score=-1*result(idx_A,idx_B);
    save('evaluationResult0.mat','idxpid','idx_A','idx_B','labels_B','labels_A','-append');
  % rrr(iter,:) = EvalCMC( score, labels_A, labels_B, 20 );
   rr=result(idx_A,idx_B); 
   [Sa,index]=sort(rr);
   n1=length(idx_B);
   z=1;
    for i=1:5:min(91,size(index,1))
    s=0;
    
    for j=1:n1
        for k=1:i
            if labels_A(index(k,j))==labels_B(j)
                s=s+1;
            end
        end
    end
    rrr(iter,z)=s/n1;
    z=z+1;
    
   end
    
    
    
end

r=sum(rrr,1)./rand_iters;
end
 end

