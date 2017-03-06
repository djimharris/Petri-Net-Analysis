function c = iswConservative(d,w)
t=d*transpose(w);
flag=0;
for i=1:size(t,1)
    if t(i)~=0
        flag=1;
    end
end
c=not(flag);