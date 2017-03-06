m0=[1 0 0 0];
dm=[1 0 0 0;1 0 0 0;1 0 0 0;0 1 0 0;0 0 2 0;0 0 0 1];
dp=[0 1 0 0;0 1 1 0;0 0 1 0;0 0 1 0;0 0 0 1;1 0 0 0];
d=dp-dm;

pLimit=size(dm,2);
tLimit=size(dm,1);

node(1,1).marking = m0;
transitionChildrenCount = 0; 									% Counter for keeping track of the number of children each node has
for i = 1:tLimit
%     sum(node(1,1).marking>=dm(i,:))
%     size(node(1,1).marking>=dm(i,:))
	if sum(node(1,1).marking>=dm(i,:)) == size(node(1,1).marking>=dm(i,:),2) % sum(a>=b) == size(a>=b,2) | Checking if the previous marking is large enough for the transition we're looking into
		transitionChildrenCount = transitionChildrenCount + 1;	% Increase the children count by 1
		node(1,1).children(transitionChildrenCount) = i;		% Store the transition's number into the children array
		node(1,1).childNodes(transitionChildrenCount) = transitionChildrenCount;
	end
end

lastNodeAtLevel(1) = 1;											% Well, obviously
lastNodeAtLevel(2) = transitionChildrenCount;					% To keep track of the last node at the next level; here, it's the number of children from the previous level.
nodeCount = 1;	

for i = 1:transitionChildrenCount								% Inserting markings for next level
	node(2,nodeCount).marking = node(1,1).marking + d(node(1,1).children(i),:);
	node(2,nodeCount).transitionedFrom = node(1,1).children(i);
	node(2,nodeCount).parent = 1;
	nodeCount = nodeCount + 1;
end

% NOTE: treeEndFlag takes 1 when hitting the end of a tree or when going into an indefinite tree, check for null markings at nodes to end it there.
% NOTE: Have a total count of nodes at every level. Or look for the last node. 
i = 2;
treeEndFlag = 0;
nodesNotSimilar = 0;

while(i<6)
    nodeCount = 1;
        for j = 1:lastNodeAtLevel(i)
            if size(node(i,j).marking, 2) >= 1													% Checking if the node has content or not through the size of the marking
                transitionChildrenCount = 0; 
                for k = 1:tLimit
                    if sum(node(i,j).marking>=dm(k,:)) == size(node(i,j).marking>=dm(k,:),2)
                        transitionChildrenCount = transitionChildrenCount + 1;					% Increase the children count by 1
                        node(i,j).children(transitionChildrenCount) = k;
                        node(i,j).childNodes(transitionChildrenCount) = nodeCount + transitionChildrenCount;
                    end
                end

                for childrenCounter = 1:transitionChildrenCount
                    node(i+1,nodeCount).marking = node(i,j).marking + transition(node(i,j).children(childrenCounter)).change;
                    node(i+1,nodeCount).transitionedFrom = node(i,j).children(childrenCounter);
                    node(i+1,nodeCount).parent = j;
                    nodeCount = nodeCount + 1;
                end
            end
        end
        lastNodeAtLevel(i+1) = nodeCount - 1;
        i=i+1;
end


