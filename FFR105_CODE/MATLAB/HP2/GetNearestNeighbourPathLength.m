function [NNPathLength, NNpath, cityStartingId] = ...
        GetNearestNeighbourPathLength(cityLocation)
    
    if nargin == 0
        clear all;
        clc;
        addpath('../');
        addpath('../TSPgraphics');
        %cityLocation = LoadCityLocations();
        cityLocation = [0 0.1; 1 1.1; 2 2.1; 3 3.1; 4 4.1; 5 5.1];
        cityLocationId = randperm(6);
        cityLocation = cityLocation(cityLocationId,:) + 1
        
    end
    
    nCity = size(cityLocation,1);
    
    %% create path array with random starting city
    pathRange = [1, nCity];
    cityStartingId = randi(pathRange,1,1); %set to 1 will give same result, 144.8726
    path = zeros(nCity,1);
    path(1) = cityStartingId(1);
    pathLeft = (1:1:nCity)';
    pathLeft(cityStartingId) = [];
    
    %% variables changed over iteration
    isPathLeft = true; % while loop terminating boolean
    distance = 0; %total distance of path
    
    %% iterate until path array is filled with cities ordered by their
    %% nearest neighbors
    pathEndId = 1;
    while(isPathLeft == true)
        %% get last city from current path array
        cityLastId = path(pathEndId);
        cityLast = cityLocation(cityLastId,:);
        
        cityNearestNeighbourDistance = inf;
        cityNearestNeighbourId = 0;
        cityNearestNeighbour = [0 0];
        nPathLeft = length(pathLeft);
        iPathLeftToDelete = 0;
        
        %% iterate over city locations
        for iPathLeft = 1:nPathLeft
           % disp("########### while ###########");
            iCity = pathLeft(iPathLeft);
            % check if city is already in path
            
            cityNext = cityLocation(iCity,:);
            %last city from path and current city distance
            cityNeighbourDistance = CartesianDistance(cityLast, cityNext);
            %check if current city is closes neighbour to last city
            %from path
            isCityNextCloserToLast = cityNeighbourDistance < ...
                cityNearestNeighbourDistance;
            
            if(isCityNextCloserToLast == true)
                cityNearestNeighbourId = iCity;
                cityNearestNeighbour(:) = cityNext;
                cityNearestNeighbourDistance = cityNeighbourDistance;
                iPathLeftToDelete = iPathLeft;
                
            end
        end
        
        pathLeft(iPathLeftToDelete) = [];
        
        pathEndId = pathEndId + 1;
        path(pathEndId) = cityNearestNeighbourId;
        distance = distance + cityNearestNeighbourDistance;
        
        isPathLeft = ~isempty(pathLeft);
        
    end
    
    isPathCorrect = sum(path) == sum(1:1:nCity);
  
    NNpath = path;

    if (isPathCorrect == true)
        %result may seems big due to last point in path to last point in pathLeft
        NNPathLength = distance; 
    else
        disp("...GetNearestNeighbourPathLength : error -> return NaN");
        NNPathLength = NaN;
    end
    
end