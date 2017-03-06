function s = treeComplete(node,lastNode,lastLevel)

s=1;
for i=1:lastLevel
    for j=1:lastNode(i)
        if node(i,j).status==2
            s=0;
        end
    end
end
