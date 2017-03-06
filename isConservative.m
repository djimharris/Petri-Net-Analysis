function c = isConservative(d)
w=null(d);
s = size(w);
c=0;
for i = 1:s(2)
    flag = 1;
    for j = 1:s(1)
        if(w(j,i)<0)
            flag = 0;
        end
    end
    if flag==1
        c=1;
    end
    
end