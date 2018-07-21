function d = distance( X1,X2,options )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if strcmpi(options,'COS')
    if sum(sum(X1.^2))*sum(sum(X2.^2))==0
        d=0;
    else
    
    
    d=X1'*X2;
    d=d/sqrt(sum(sum(X1.^2))*sum(sum(X2.^2)));
    end
end

if strcmpi(options,'L2')
    E=X1-X2;
    d=sum(sum(E.^2));
end

if strcmpi(options,'Heat')
    t=100;
    E=X1-X2;
     d=sum(sum(E.^2));
     d=exp(-1*d/t);
end


end
