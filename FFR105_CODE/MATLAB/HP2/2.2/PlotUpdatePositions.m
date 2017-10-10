function [] = PlotUpdatePositions(minimaPlotHand,positions)
    
    nPositions = size(positions,1);
    
    wh = 0.25;
    wh_2 = wh/2;
    for i = 1:nPositions
        tmp = [positions(i,1)-wh_2 positions(i,2)-wh_2 wh wh];
        set(minimaPlotHand(i),'Position', tmp);
    end
    
        drawnow;

    
end