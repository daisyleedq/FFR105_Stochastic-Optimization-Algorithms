function [fitness] = EvaluateIndividual(cityLocations, cityPath)
    
    if nargin == 0
                
        clear all, clc, clf;
        
        cityLocations = LoadCityLocations();
        nCities = size(cityLocations, 1);
        cityPath = 1:1:nCities;
    end
    
    distance = GetPathLength( cityPath, cityLocations);
    
    fitness = 1/distance;
    
    if nargin == 0
       disp('distance'); 
       disp(distance); 
       
       disp('fitness'); 
       disp(fitness); 
    end
    
end