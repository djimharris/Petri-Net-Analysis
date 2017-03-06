%Main Program

% global xSum t p perm permI count;

clc
disp('Petri Net Analysis:');
disp(' ');
disp('1. Default Values');
disp('2. User Input Values');
c = input('Enter choice (1-2): ');
clc
switch(c)
    case 1
%         dm=[1 0 0 0 1;0 1 0 0 1;0 0 1 0 0;0 0 0 1 0];   %Test for conversation
%         dp=[0 0 1 0 0;0 0 0 1 0;1 0 0 0 1;0 1 0 0 1];
        dm=[1 1 1 0;0 0 0 1;0 0 1 0];                   %Test for reachability
        dp=[1 0 0 0;0 2 1 0;0 0 0 1]
        d=dp-dm;

    case 2
        a = input('Enter D- matrix: ','s');
        dm = str2num(a);
        a = input('Enter D+ matrix: ','s');
        dp = str2num(a);
        d = dp - dm;
end


clc
    
disp('Tests:');
disp(' ');
disp('1. Conservation');
disp('2. Reachability');
disp('5. Exit');
c = input('Enter choice (1-2): ');
disp(' ');

switch(c)
    case 1
        disp('1. General Weighting vector');
        disp('2. Specific Weighting vector');
        c2 = input('Enter choice (1-2): ');
        disp(' ');
        switch(c2)
             case 1
                if isConservative(d)==1
                    disp('A weighting vector exists for which petri net is conservative');
                    disp(' ');
                    w=wConservative(d)
                else
                    disp('The petri net is not conservative');
                end
             case 2

                a = input('Enter weighting vector: ','s');
                w = str2num(a);
                if(iswConservative(d,w)==1)
                    disp('The petri net is conservative for the given weighting vector');
                else
                    disp('The petri net not is conservative for the given weighting vector');
                end
        end
    case 2
        disp('Initial Marking:');
        disp('1. Default marking');
        disp('2. User input marking');
        c3 = input('Enter choice (1-2): ');
        disp(' ');
        switch(c3)
            case 1
                m0=[1 0 1 0];
                m1=[1 8 0 1];
            case 2
                a = input('Enter initial marking: ','s');
                m0 = str2num(a);
                a = input('Enter marking for which reachability is to be checked: ','s');
                m1 = str2num(a);
        end
        [reachValid,fVector]=reachability(dm,dp,m0,m1);
        switch(reachValid)
            case 1
                disp('Marking is not reachable');
            case 2
                disp('Marking is not reachable. No valid transition.');
            case 3
                disp('Marking is reachable');
                disp('Possible transition orders:');
                disp(fVector);
        end
        
        
end

%     w = null(d);
%     s = size(w);
%     new = zeros([s(1),1]);
% 
%     for i = 1:s(2)
%         flag = 1;
%         for j = 1:s(1)
%             if(w(j,i)<0)
%                 flag = 0;
%             end
%         end
%         if(flag)
%             new = w(:,i);
%         end
%     end
% end

