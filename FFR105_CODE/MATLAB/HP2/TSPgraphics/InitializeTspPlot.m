function [tspFigure,cityPlotHand] = InitializeTspPlot(cityLocation,range)
    
    if nargin == 0
        clear all;
        clc, clf;
        cityLocation = LoadCityLocations();
    end
    
    nCity = size(cityLocation,1);
    
    tspFigure = figure(1);
    hold on;
    
    if nargin == 2
        axis([range(1),range(2),range(3),range(4)]);
    end
    
    title('Traveling Salesman Problem');
    xlabel('x [l.u.]');
    ylabel('y [l.u.]');
    axis square;
    grid on;
    set(tspFigure,'DoubleBuffer','on');
    plot(cityLocation(:,1),cityLocation(:,2),'b.');
    cityPlotHand = zeros(nCity);
    
    for i = 1:length(cityLocation)
        tmp = [cityLocation(i,1)-0.25 cityLocation(i,2)-0.25 0.5 0.5];
        cityPlotHand(i) = rectangle('Position', tmp,'Curvature', [1 1]);
    end
    hold off;
    
end