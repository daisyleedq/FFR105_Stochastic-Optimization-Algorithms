function PlotCurrentGeneration(iGeneration,maxFitness,fitness,decodedPopulation,bestPlotHand,textHand,populationPlotHand)
    plotVec = get(bestPlotHand,'YData');
    plotVec(iGeneration) = maxFitness;
    set(bestPlotHand,'YData',plotVec);
    set(textHand, 'String', sprintf('best: %4.3f',maxFitness));
    set(populationPlotHand, 'XData', ...
        decodedPopulation(:, 1), 'YData',  ...
        decodedPopulation(:,2), 'ZData', ....
        fitness(:));
    drawnow; 
end