function [node,lastNodeAtLevel,lastLevel]= rTree(dm,dp,m0)

% Components of structure (node)
% marking to indicate the marking
% children to store the transitions to be fired
% childNodes to store the address of the children
% transitionedFrom to store the transition that fired to result in the
% given node
% status to store the nature of the node
% lastNodeAtLevel stores the number of nodes in each level
% lastLevel stores the maximum number of levels of a branch

d=dp-dm;
w=93772;

pLimit=size(dm,2);
tLimit=size(dm,1);

node(1,1).marking = m0;
node(1,1).status = 0;
transitionChildrenCount = 0; 									% Counter for keeping track of the number of children each node has

for i = 1:tLimit
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
    node(2,nodeCount).status=nodeStatus(node,lastNodeAtLevel,2,nodeCount,tLimit,dm);
	if(nodeStatus(node,lastNodeAtLevel,2,nodeCount,tLimit,dm)==2)
        node(2,nodeCount).transitionedFrom = node(1,1).children(i);
        node(2,nodeCount).parent = 1;
        nodeCount = nodeCount + 1;
    end
end

if lastNodeAtLevel(2)>0
    nodeCount = 0;
    lastLevel=2;
end

while treeComplete(node,lastNodeAtLevel,lastLevel)==0
    nodeCount=0;
    for j=1:lastNodeAtLevel(lastLevel)
        if(nodeStatus(node,lastNodeAtLevel,lastLevel,j,tLimit,dm)==2)
            transitionChildrenCount = 0; 
                for k = 1:tLimit
                    if sum(node(lastLevel,j).marking>=dm(k,:)) == size(node(lastLevel,j).marking>=dm(k,:),2)
                        transitionChildrenCount = transitionChildrenCount + 1;					% Increase the children count by 1
                        node(lastLevel,j).children(transitionChildrenCount) = k;
                        node(lastLevel,j).childNodes(transitionChildrenCount) = nodeCount + transitionChildrenCount;
                        node(lastLevel,j).status=4;
                    end
                end
                
                for childrenCounter = 1:transitionChildrenCount
                    nodeCount = nodeCount + 1;
                    %node(lastLevel+1,nodeCount).marking = node(i,j).marking + transition(node(i,j).children(childrenCounter)).change;
                    for a=1:pLimit
                        flag=0;
                        if node(lastLevel,j).marking(a)==w
                            node(lastLevel+1,nodeCount).marking(a)=w;
                            flag=1;
                        end
                        if flag==0
                            e=j;
                            for b = lastLevel:-1:1
                                g=0;
                                          for f=1:pLimit
                                              g=g+1;
                                              if node(lastLevel,j).marking(f)~=w
                                                  w1(g)=node(lastLevel,j).marking(f) + d(node(lastLevel,j).children(childrenCounter),f);
                                                  w2(g)=node(b,e).marking(f);
                                              end
                                              
                                          end
                                    if sum(w1>=w2)==size((w1==w2),2)
                                        if (node(lastLevel,j).marking(a) + d(node(lastLevel,j).children(childrenCounter),a))>(node(b,e).marking(a))
                                            flag=1;
                                        end
                                    end
                                    
                                e=node(b,e).parent;
                            end
                            if flag==1
                                node(lastLevel+1,nodeCount).marking(a)=w;
                            end
                        end
                        if flag==0
                            node(lastLevel+1,nodeCount).marking(a) = node(lastLevel,j).marking(a) + d(node(lastLevel,j).children(childrenCounter),a);
                        end
                    end
                    node(lastLevel+1,nodeCount).transitionedFrom = node(lastLevel,j).children(childrenCounter);
                    node(lastLevel+1,nodeCount).parent = j;
                    node(lastLevel+1,nodeCount).status=nodeStatus(node,lastNodeAtLevel,lastLevel+1,nodeCount,tLimit,dm);
                end
        end
    end
    lastLevel=lastLevel+1;
    lastNodeAtLevel(lastLevel)=nodeCount;
end