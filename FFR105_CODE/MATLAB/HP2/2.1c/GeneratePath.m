function [path] = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    
    nVisibility = length(visibility);
    
    pathRange = [1 nVisibility];
    nodeFirst=randi(pathRange);
    tabuList=zeros(1, nVisibility);
    tabuList(1,1) = nodeFirst;
    
    for i=2:nVisibility
        tabuListTemp = tabuList(1,1:i-1);
        nextNode=GetNode(pheromoneLevel,visibility,alpha,beta,tabuListTemp);
        tabuList(1,i) = nextNode;
    end
    
    path=tabuList;
    
end