function [fitnessFigHand,bestPlotHand,averagePlotHand,textHand]=...
        PlotFitnessFigure(nGenerations, solutionString,settingsString)
    
    fitnessFigHand = figure;
    hold on;
    set(fitnessFigHand, 'Position', [50,50,600,200]);
    set(fitnessFigHand, 'DoubleBuffer', 'on');
    axis([1 nGenerations 0 1.1]);
    bestPlotHand = plot(1:nGenerations, zeros(1, nGenerations));
    averagePlotHand = plot(1:nGenerations, zeros(1,nGenerations));
    textHand = text(4,.75,'');
    title(solutionString+settingsString);
    hold off;
    drawnow;
    
end
