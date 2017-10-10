function [] = PlotPath(pathPlotHand, cityLocation, path,...
        resultsString, textPlotHand)
    
    if nargin == 0
        
        clear all, clc, close all;
        
        
        cityLocation = LoadCityLocations();
        nCity = size(cityLocation,1);
        
        path = randperm(nCity);
        fitnessMax = 0;
        fitnessAvg = fitnessMax;
        distanceMin = 1e6;
        
        resultsString = sprintf(...
            "... results:\n"...
            +"avg fitness = %1.4f\n"...
            +"max fitness = %1.4f\n"...
            +"min distance = %5.2f\n",...
            fitnessAvg, fitnessMax, distanceMin);
        
        [figureInitPopulation,...
            textPlotHand,...
            pathPlotHand] = ...
            PlotInitPopulation(cityLocation);
        
    end
    
    nCity = size(cityLocation,1);
    
    for i = 1:nCity-1
        j = i + 1;
        pathI = path(i);
        pathJ = path(j);
        cityI = cityLocation(pathI,:);
        cityJ = cityLocation(pathJ,:);
        tmpX = [cityI(:,1) cityJ(:,1)];
        tmpY = [cityI(:,2) cityJ(:,2)];
        set(pathPlotHand(i),'XData',tmpX);
        set(pathPlotHand(i),'YData',tmpY);
    end
    
    pathI = path(nCity);
    pathJ = path(1);
    cityI = cityLocation(pathI,:);
    cityJ = cityLocation(pathJ,:);
    tmpX = [cityI(:,1) cityJ(:,1)];
    tmpY = [cityI(:,2) cityJ(:,2)];
    
    set(pathPlotHand(nCity),'XData',tmpX);
    set(pathPlotHand(nCity),'YData',tmpY);
    
    if nargin == 5
        set(textPlotHand, 'String', resultsString);%sprintf('best: %4.3f',maxFitness));
    end
    
    drawnow;
    
end