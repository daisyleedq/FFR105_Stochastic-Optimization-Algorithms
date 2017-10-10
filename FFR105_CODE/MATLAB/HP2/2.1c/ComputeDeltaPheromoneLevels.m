function [deltaPheromoneLevel] = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
    nPath=length(pathCollection(:,1));
    deltaPheromoneLevel=zeros(nPath,nPath);
    nAnts=length(pathCollection(1,:));
    
    for k=1:nAnts
        pathCollectionK = pathCollection(k,:);
        pheromoneIncrease =  1/pathLengthCollection(k);

        for i=1:nPath-1
            j = i +1;
            nodeI=pathCollectionK(i);
            nodeJ=pathCollectionK(j);
            
            tmp= deltaPheromoneLevel(nodeJ,nodeI)+pheromoneIncrease;
            deltaPheromoneLevel(nodeJ,nodeI)=tmp;
        end
        
        nodeI=pathCollectionK(nPath);
        nodeJ=pathCollectionK(1);
        
        tmp = deltaPheromoneLevel(nodeJ,nodeI)+pheromoneIncrease;
        deltaPheromoneLevel(nodeJ,nodeI)=tmp;
    end
end