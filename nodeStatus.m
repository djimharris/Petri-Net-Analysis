function s = nodeStatus(node,lastNode,k1,k2,tLimit,dm)
flag=0;
for i=1:k1-1
    for j=1:lastNode(i)
        if sum(node(i,j).marking==node(k1,k2).marking) == size(node(1,1).marking==node(k1,k2).marking,2)
            flag=1;
        end
    end
end

if flag==1
    s=1;
else
    for k = 1:tLimit
        if sum(node(k1,k2).marking>=dm(k,:)) == size(node(k1,k2).marking>=dm(k,:),2)
            flag=1;
        end
    end
    if flag==0
        s=3;
    else
        s=2;
    end
end
        

% Status map
% 
% 0: Primary
% 1: Duplicate
% 2: Frontier        
% 3: Terminal   
% 4: Interior
         
     