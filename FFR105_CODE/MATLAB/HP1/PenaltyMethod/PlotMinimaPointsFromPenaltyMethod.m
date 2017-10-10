function PlotMinimaPointsFromPenaltyMethod()
    
    global MINIMA_POINTS;

    x1 = MINIMA_POINTS(:,1);
    x2 = MINIMA_POINTS(:,2);
    y = MINIMA_POINTS(:,3);
    
    plot3(x1,x2,y,'o-k');

    
end