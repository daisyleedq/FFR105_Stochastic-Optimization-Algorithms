function [pathPlotHand,textPlotHand] = InitializeConnections(cityLocation)
    
    if nargin == 0
        clear all;
        clc, clf;
        cityLocation = LoadCityLocations();
    end
    
    
    nCity = size(cityLocation,1);
    
    pathPlotHand = zeros(nCity,1);
    
    for i = 1:nCity-1
        j = i + 1;
        tmp = cityLocation(i:j,:);
        pathPlotHand(i) = line(tmp(:,1), tmp(:,2));
    end
    
    
    cityLast = cityLocation(nCity,:);
    cityFirst = cityLocation(1,:);
    tmp = [cityLast ; cityFirst];
    pathPlotHand(nCity) = line(tmp(:,1), tmp(:,2));
    
    textPlotHand = text(21,19,'');
    
end