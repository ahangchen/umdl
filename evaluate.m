function [ r,result,index ] = evaluate( Xa,Xb,labelsA,labelsB)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[m,n1]=size(Xa);
[m,n2]=size(Xb);
for i=1:n2
   for j=1:n1
       score=sum(Xa(:,j).*Xb(:,i))/sqrt(sum(Xa(:,j).^2)*sum(Xb(:,i).^2));
       result(i,j)=-1*score;
   end
end

% dis=squareform(pdist([Xa';Xb'],'cosine'));
% for i=1:n2
%    for j=1:n1
%        result(i,j)=-1*dis(i,n2+j);  
%    end
% end

[Sa,index]=sort(result);
save('evaluationResult-1.mat','Sa', 'index');
z=1;
for i=1:1:min(50,size(index,1))
    s=0;
    for j=1:n1
        for k=1:i
            if labelsB(index(k,j))==labelsA(j)
                s=s+1;
            end
        end
    end
    r(z)=s/n1;
    z=z+1;
    
end





end

