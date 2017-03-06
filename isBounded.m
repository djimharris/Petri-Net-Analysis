function [s,b] = isBounded(node,lastNode,lastLevel,pLimit)
s=1;
b=zeros(1,pLimit);
for i=1:lastLevel
    for j=1:lastNode(i)
        for k=1:pLimit
            if node(i,j).marking(k)>b(k)
                b(k)=node(i,j).marking(k);
            end
        end
    end
end

if max(b)==93772
    s=0;
end