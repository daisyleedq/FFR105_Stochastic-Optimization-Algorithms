function pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho)
    [nPaths,pathLength] = size(pheromoneLevel);
    
    if (nPaths == pathLength)
        for i=1:nPaths
            
            for j=i+1:nPaths
                pheromoneLevelTemp = (1-rho)*pheromoneLevel(i,j)+deltaPheromoneLevel(i,j);
                pheromoneLevel(i,j)= pheromoneLevelTemp;
                pheromoneLevel(j,i)= pheromoneLevelTemp;
            end
            
            pheromoneLevelTemp = (1-rho)*pheromoneLevel(i,i)+deltaPheromoneLevel(i,i);
            pheromoneLevel(i,i)= pheromoneLevelTemp;
            
        end
        
    else
        
        for i=1:pathLength
            for j=1:nPaths
                pheromoneLevel(i,j)=(1-rho)*pheromoneLevel(i,j)+deltaPheromoneLevel(i,j);
            end
        end
        
    end
end