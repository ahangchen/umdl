function W2=constructWwith2Camsknn(features,cams,k)
n=size(features,2);
if isempty(cams)
   cams=-2*ones(1,n); 
end



for i=1:n
    for j=1:n
        if cams(i)>-1 && cams(i)==cams(j)
            Ws(i,j)=-1;
        else
            Ws(i,j)=distance(features(:,i),features(:,j),'COS');
           
        end
    end
end


W1=zeros(n,n);
for i=1:n

    if cams(i)>0||cams(i)<0
      
        [maxt, mindex]=sort(Ws(i,:)); 
        for j=0:k-1
            W1(i,mindex(n-j))=1;
            W1(mindex(n-j),i)=1;
        end
    end
    
    
end

W2=W1.*Ws;
W2=sparse(W2);

end




