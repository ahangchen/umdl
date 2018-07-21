function W=constructWwith2Cams(features,cams,k)
 n=size(features,2);
  for i=1:n
      for j=1:n
         if i==j
             W1(i,j)=0;
          elseif cams(i)==cams(j)
              W1(i,j)=0;
          else
         temp=distance(features(:,i),features(:,j),'COS');
         W1(i,j)=max(temp,0.05);
         W1(i,j)=W1(i,j);
         end;
         
     end
  end
%   k=3;
%   for i=1:n
% 
%               [maxt, mindex]=sort(W1(i,:));
%               W1(i,mindex(1:n-k))=0;
% 
% 
%   end

  % W2=(W1.*W1').^2;
     [W2,z]=Edmonds(-1.*W1);
       W=sparse(W2.*W1);

end

function W1=constructWcombined(features,cams,k)
 n=size(features,2);
W2=constructWwith2Camsknn(features,cams,k);
index=[];
for i=1:n
    if max(W2(i,:))==0
        index=[index,i];
    end
end

    W1=W2;
if length(index)>0

W3=constructWwith2Cams(features(:,index),cams(index));

for i=1:length(index)
    temp=find(W3(i,:)>0);
    W1(index(i),index(temp(1)))=1;
    
end
end
end
