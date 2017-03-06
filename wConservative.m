function w = wConservative(d)
w1 = null(d);
s = size(w1);
w = zeros([s(1),1]);
counter=1;

for i = 1:s(2)
    flag = 1;
    for j = 1:s(1)
        if(w1(j,i)<0)
            flag = 0;
        end
    end
    if(flag)
        w(:,counter) = w1(:,i);
    end
end

m=min(w);

for i = 1:size(w,2)
    for j=1:size(w,1)
        w(j,i)=w(j,i)/m(i);
    end
end
w=int64(w);