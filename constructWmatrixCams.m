function W= constructWmatrixCams(labels,features,cams,k)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if length(labels)>0
W1=zeros(length(labels),length(labels));
for i=1:length(labels)
    for j=1:length(labels)
       if labels(i)==labels(j)
            W1(i,j)=1;
       else%if cams(i)~=cams(j)
            W1(i,j)=0;   
        end
    end
end
else
 n=size(features,2);
for i=1:n
    D=[];
    for j=1:n
        if cams(j)~=cams(i)
            D=[D,features(:,j)];
        end
    end
      param.mode=2;
 param.lambda=0.5;
 param.lambda2=0.0;%0.6%0.15%0.03 %caviar 1.2 iLID 0.2
 param.iter=15;
    %XX=learn_coefficients_fast(D,features(:,i),0,0.1,[]);
    XX=full(mexLasso(features(:,i),D, param));
       t=1;
     for j=1:n
         
         if cams(i)==cams(j)
              W1(i,j)=-1;
         else
           W1(i,j)=XX(t,1);
           t=t+1;
         end;
         
     end
      [maxt, mindex]=sort(W1(i,:)); 
       W1(i,mindex(1:n-k))=0;
     
        %W1(i,mindex(n-k+1:end))=1;
        
      % W1(i,mindex(n-k+1:n))=0;
end
    
   

    for i=1:0
    W2=W1;
    W1=(W2.*W2').^0.5;
    end
end


% W1=(W1+W1')./2;
W1=double(W1);
W=sparse(W1);
end
