function PlotCurrentGeneration(iGeneration,maxFitness,fitness,averageFitness,...
        decodedPopulation,bestPlotHand,averagePlotHand,...
        textHand,resultsString, populationPlotHand)
    
    plotBestVec = get(bestPlotHand,'YData');
    plotBestVec(iGeneration) = maxFitness;
    set(bestPlotHand,'YData',plotBestVec);
    
    plotAverageVec = get(averagePlotHand,'YData');
    plotAverageVec(iGeneration) = averageFitness;
    set(averagePlotHand, 'YData', plotAverageVec);
    
    set(textHand, 'String', resultsString);%sprintf('best: %4.3f',maxFitness));
    
    set(populationPlotHand, 'XData', ...
        decodedPopulation(:,1), 'YData',  ...
        decodedPopulation(:,2), 'ZData', ....
        fitness(:));
    
    drawnow; 
end