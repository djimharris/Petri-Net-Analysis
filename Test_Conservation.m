%{
TEST FOR CONSERVATION
Script to find all possible weighting vectors by using the property D.w=0
%}

a = input('Enter D-: ','s');
dm = str2num(a);
a = input('Enter D+: ','s');
dp = str2num(a);
d = dp - dm;
w = null(d);
s = size(w);
new = zeros([s(1),1]);

for i = 1:s(2)
    flag = 1;
    for j = 1:s(1)
        if(w(j,i)<0)
            flag = 0;
        end
    end
    if(flag)
        new = [new w(:,i+1)];
    end
end