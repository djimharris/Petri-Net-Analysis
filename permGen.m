function [] = permGen(x,app,n)
global t count;
count = count + 1;

% disp(['X1 = ',num2str(x(1))]);
% disp(['GenCount = ',num2str(count)]);
% disp('PermGen has begun');

if sum(x) == 0
    permApp(app);
else
    for i= 1:t    
        if x(i) > 0
            x2 = x;
            x2(i) = x2(i) - 1;
            app(n) = i;
            permGen(x2,app,n+1);
        end
    end
end

% disp('PermGen over');
