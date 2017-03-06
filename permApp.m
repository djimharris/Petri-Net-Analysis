function [] = permApp(app)
global perm permI xSum;
% disp(['permapp ']);

for i = 1:xSum
    perm(permI,i) = app(i);
end
permI = permI + 1;





% perm(permI,permJ) = i2;
% disp(['Perm value = ',num2str(perm(permI,permJ))]);
% if permJ == xSum
%     permJ = 1;
%     permI = permI + 1;
% else
%     permJ=permJ+1;
% end
%hello