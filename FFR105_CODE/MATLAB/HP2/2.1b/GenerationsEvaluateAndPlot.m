function [fitness,fitnessMax,bestPath] = ...
        GenerationsEvaluateAndPlot(nGenerations,cityLocations, ...
                                      population,pathPlotHand)
    
    if nargin == 0
        
        clear all, clc, clf;
        
        nGenerations = 1e5;
        nPopulation = 80;
        
        cityLocations = LoadCityLocations();
        nCities = size(cityLocations,1);
        
        population = InitializePopulation(nPopulation,nCities);
        
        [figureInitPopulation,...
            cityPlotHand,...
            pathPlotHand] = ...
            PlotInitPopulation(cityLocations);
        
    end
    
    [nPopulation,nCities] = size(population); %nGenerations = nCities
    fitness=zeros(nPopulation,1);
    bestPath = zeros(nCities,1);
    fitnessMax = 0;
    
    
    for iGeneration=1:nGenerations
        for iPopulation = 1:nPopulation
            pathTemp=population(iPopulation,:);
            fitnessTemp = EvaluateIndividual(cityLocations,pathTemp)
            fitness(iPopulation)=fitnessTemp;
            isFitnessBetter = fitnessTemp>fitnessMax;
            
            if(isFitnessBetter == true)
                fitnessMax(:) = fitnessTemp
                bestPath(:) = pathTemp;
                PlotCityPath(pathPlotHand,cityLocations,bestPath);
            end
        end
        
    end