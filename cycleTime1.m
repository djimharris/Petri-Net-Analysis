% Cycle Times: Petri Net 1

m=[1 0 0 0 1 0 0 0];
dm=[1 0 0 0 0 0 0 0;0 1 0 0 1 0 0 0;0 0 0 1 0 0 0 0;0 0 0 0 0 1 0 0;0 0 1 0 0 0 1 0;0 0 0 0 0 0 0 1];
dp=[0 1 1 0 0 0 0 0;0 0 0 1 0 0 0 0;0 0 0 0 0 1 1 0;0 0 0 0 1 0 0 0;0 0 0 0 0 0 0 1;1 0 0 0 0 0 0 0];

t=[1 1 1 4 1 3];

c1=[1 1 3 5 8 6 1];
c2=[1 1 2 2 4 3 7 5 8 6 1];
c3=[5 2 4 3 6 4 5];

t1=0;
n1=0;

for i=1:2:size(c1,2)-1
    t1=t1+t(c1(i+1));
    n1=n1+m(c1(i));
end
timeC1=t1/n1;

t1=0;
n1=0;

for i=1:2:size(c2,2)-1
    t1=t1+t(c2(i+1));
    n1=n1+m(c2(i));
end
timeC2=t1/n1;

t1=0;
n1=0;

for i=1:2:size(c3,2)-1
    t1=t1+t(c3(i+1));
    n1=n1+m(c3(i));
end
timeC3=t1/n1;