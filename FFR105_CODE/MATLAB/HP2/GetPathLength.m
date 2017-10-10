function [distance] = GetPathLength( cityPath, cityLocations)
    
    if nargin == 0
                
        clear all, clc, clf;
        
        cityLocations = LoadCityLocations();
        nCities = size(cityLocations, 1);
        cityPath = 1:1:nCities;
    end
    
    nCities = size(cityLocations, 1);
    
    distance = 0;
    distanceTmp = 0;
    
    for i=1:nCities-1
        j = i + 1;
        pathI = cityPath(:,i);
        pathJ = cityPath(:,j);
        cityI = cityLocations(pathI,:);
        cityJ = cityLocations(pathJ,:);
        distanceTmp(:) = CartesianDistance(cityI, cityJ);
        distance(:) = distance + distanceTmp;
    end
    
    
    pathLast = cityPath(nCities);
    pathFirst = cityPath(1);
    cityLast = cityLocations(pathLast,:);
    cityFirst = cityLocations(pathFirst,:);
    distanceTmp(:) = CartesianDistance(cityLast,cityFirst);
    distance(:) = distance + distanceTmp;
    
end