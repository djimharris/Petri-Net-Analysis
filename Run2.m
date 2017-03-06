global xSum t p perm permI count;
app = zeros(1,1);
n = 1;
count = 0;
perm = zeros(1,1);
permI = 1;
flagValidity = 0;

dm = [1 1 1 0;0 0 0 1;0 0 1 0];
dp = [1 0 0 0;0 2 1 0;0 0 0 1];

d = dp-dm;

m0 = [1 0 1 0];
m1 = [1 8 0 1];
%m1 = [9 9 9 9];
m=m1-m0;
t = 3;
p = 4;
%x = m*pinv(d);
x = [0 3 2];
flag = 0;

x = int32(x);
xSum = sum(x);
for i = 1:t
    
    if x(i) < 0
        flag = 1;
    end
end
if flag == 1
   disp('Not reachable');
end
if flag == 0
    permGen(x,app,n);

    for i = 1:size(perm,1)
        flag = 1;
        mold = m0;
        for j = 1:xSum
            for z = 1:p
                if(mold(z) < dm(perm(i,j),z))
                    flag = 0;
                end
            end
            if flag == 1
                e = zeros(1,t);
                e(perm(i,j)) = 1;
                mnew = mold + (e*d);
                mold = mnew;
            end
        end
        if flag == 1
            permfinal = perm(i,:);
            flagValidity = 1;
        end
    end
    if flagValidity == 0
        disp('Not reachable - no valid transitions');
    end

end