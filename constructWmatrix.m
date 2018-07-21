function W= constructWmatrix(labels,features,cams,k)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

index=find(labels(:)<0);
W=zeros(length(labels),length(labels));
if length(index)>0
     W1=zeros(length(index),length(index));
   %  W2=constructWwith2Camsknn(features(:,index),cams(index),3);
    if k==-1
    W1=zeros(length(index),length(index));
    else
    if length(cams)>0 && k==1
        W1=constructWwith2Cams(features(:,index),cams(index),k);
    elseif length(cams)>0 
        W1=constructWwith2Camsknn(features(:,index),cams(index),k);
    else
        W1=constructWwith2Camsknn(features(:,index),[],k);
    end
    end
%       W1=W1+W2; 
    W(index,index)=W1;
end
 n=length(labels);
 

for i=1:n
    for j=1:n
        if i==j
            W(i,j)=0;
        elseif labels(i)>=0 && labels(i)==labels(j)
            W(i,j)=1;
        elseif labels(i)>=0 && labels(i)~=labels(j)
            W(i,j)=0;
        end
        
        
    end
end

if length(cams)>0
for i=1:length(labels)
    for j=1:length(labels)
        if cams(i)==cams(j)
            W(i,j)=0;
        end
    end
end
end

W=sparse(W);





% 
% 
% 
% if length(labels)>0
% W1=zeros(length(labels),length(labels));
% for i=1:length(labels)
%     for j=1:length(labels)
%        if labels(i)==labels(j)
%             W1(i,j)=1;
%        else%if cams(i)~=cams(j)
%             W1(i,j)=0;   
%         end
%     end
% end
% else
%  
%      if length(cams)==0   
%  n=size(features,2);
%   for i=1:n
%       for j=1:n
%          
%    
%         W1(i,j)=distance(features(:,i),features(:,j),'COS');
% 
%       end
%       [maxt, mindex]=sort(W1(i,:)); 
%        W1(i,mindex(1:n-k))=0;
%      
%        W1(i,mindex(n-k+1:end))=1;
%         
%       % W1(i,mindex(n-k+1:n))=0;
%   end
%      else
%           n=size(features,2);
%           W1=constructWwith2Cams(features,cams);
%    
%     end
%    
% 
%     for i=1:0
%     W2=W1;
% W1=(W2.*W2').^0.5;
%     end
% end
% 
% 
% % W1=(W1+W1')./2;
% W1=double(W1);
% W=sparse(W1);
end


