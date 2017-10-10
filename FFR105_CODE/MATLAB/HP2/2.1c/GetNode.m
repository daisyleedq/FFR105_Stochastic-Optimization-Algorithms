function nextNode = GetNode(pheromoneLevel,visibility,alpha,beta,tabuList)
    
    if (nargin == 0)
        clear all, clc;
        
        cityLocation = LoadCityLocations();
        numberOfCities = length(cityLocation);
        
        alpha = 1.0;
        beta = 5.0;
        nAnts = size(cityLocation,1);
        
        nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocation);
        tau0 = nAnts/nearestNeighbourPathLength;
        pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0);
        visibility = GetVisibility(cityLocation);
        
        nVisibility = length(visibility);
        
        pathRange = [1 nVisibility];
        startingNode=randi(pathRange);
        tabuList=zeros(nVisibility,1);
        tabuList(1) = startingNode;
        
        
        
    end
    
    nVisibility = size(visibility,1);
    nTabuList=length(tabuList);
    pathLeft=1:1:nVisibility;
    
    cityLastId=tabuList(end);
    %Remove visited cities
    for i=1:nTabuList
        nodeId = tabuList(i);
        isNodeInPathLeft = pathLeft == nodeId;
        pathLeft(isNodeInPathLeft)=[];
    end
    
    tauIJ = pheromoneLevel(cityLastId,pathLeft);
    tauAlphaIJ = tauIJ.^alpha;
    etaIJ = visibility(cityLastId,pathLeft);
    etaBetaIJ = etaIJ.^beta;
    
    stepProbabilitiesNominator=tauAlphaIJ.*etaBetaIJ;
    stepProbabilitiesDenominator = sum(stepProbabilitiesNominator);
    
    stepProbabilities =  stepProbabilitiesNominator/stepProbabilitiesDenominator;
    
    r=rand;
    iCity = 0;
    probabilitiesSum=0;
    while (probabilitiesSum<r)
        iCity = iCity + 1;
        iCityProbability = stepProbabilities(:,iCity);
        probabilitiesSum = probabilitiesSum+iCityProbability;
        
    end
    nextNode=pathLeft(iCity);
end