function [] = RerunBestAndWorstSolutions(allSettingsAndResults,nGenes,nVariables,...
            nGenerations,variablesRange,nCopiesBestIndividual)
    
    disp("############################ PART II ################################");
    disp("### ### ### ### RERUN BEST/WORST SOLUTIONS AND PLOT (WITH SAVEFIG)");
    disp("");
    
           [nSolutions, nParameters] = size(allSettingsAndResults);
        
        bestSolution = 0;
        worstSolution = 1e6;
        bestAverageSolution = 0;
        worstAverageSolution = 1e6;
        
        bestSolutionId = -1;
        worstSolutionId = -1;
        bestAverageSolutionId = -1;
        worstAverageSolutionId = -1;
        
        for solutionId=1:nSolutions
            settingsAndResults = allSettingsAndResults(solutionId,:)';
            solutionIndex = settingsAndResults(1);
            bestSolutionMean = settingsAndResults(11);
            averageFitnessMean = settingsAndResults(12);
            
            if bestSolutionMean > bestSolution
                bestSolution = bestSolutionMean;
                bestSolutionId = solutionIndex;
            end
        
             if averageFitnessMean > bestAverageSolution
                bestAverageSolution = averageFitnessMean;
                bestAverageSolutionId = solutionIndex;
             end
            
            if bestSolutionMean < worstSolution
                worstSolution = bestSolutionMean;
                worstSolutionId = solutionIndex;
            end
        
             if averageFitnessMean < worstAverageSolution
                worstAverageSolution = averageFitnessMean;
                worstAverageSolutionId = solutionIndex;
            end
             
        end
        
    doPlot = true;
    doPrint = true;
    
    disp('### ### ### ### rerun and plot for worstSolutionId ### ### ### ###');
    solutionIndex = allSettingsAndResults(worstSolutionId,1);
    nPopulation = allSettingsAndResults(worstSolutionId,2);
    crossoverProbability = allSettingsAndResults(worstSolutionId,3);
    mutationProbability  = allSettingsAndResults(worstSolutionId,4);
    tournamentSelectionParameter = allSettingsAndResults(worstSolutionId,5);
    nTournament = allSettingsAndResults(worstSolutionId,6);
    seed = allSettingsAndResults(worstSolutionId,7);
    title = 'worst solution';
    
    GeneticAlgorithm(nTournament, nCopiesBestIndividual,...
        nVariables, nPopulation,...
        nGenes,crossoverProbability,...
        mutationProbability,tournamentSelectionParameter,...
        variablesRange,nGenerations,...
        doPlot, doPrint, solutionIndex,title, seed);
    
    disp("");
    disp('### ### ### ### rerun and plot for bestSolutionId ### ### ### ###');
    solutionIndex = allSettingsAndResults(bestSolutionId,1);
    nPopulation = allSettingsAndResults(bestSolutionId,2);
    crossoverProbability = allSettingsAndResults(bestSolutionId,3);
    mutationProbability  = allSettingsAndResults(bestSolutionId,4);
    tournamentSelectionParameter = allSettingsAndResults(bestSolutionId,5);
    nTournament = allSettingsAndResults(bestSolutionId,6);
    seed = allSettingsAndResults(bestSolutionId,7);
    title = 'best solution';
    
    GeneticAlgorithm(nTournament, nCopiesBestIndividual,...
        nVariables, nPopulation,...
        nGenes,crossoverProbability,...
        mutationProbability,tournamentSelectionParameter,...
        variablesRange,nGenerations,...
        doPlot, doPrint, solutionIndex,title, seed);
    
    disp("");
    disp('### ### ### ### rerun and plot for bestAverageSolutionId ### ### ### ###');
    solutionIndex = allSettingsAndResults(bestAverageSolutionId,1);
    nPopulation = allSettingsAndResults(bestAverageSolutionId,2);
    crossoverProbability = allSettingsAndResults(bestAverageSolutionId,3);
    mutationProbability  = allSettingsAndResults(bestAverageSolutionId,4);
    tournamentSelectionParameter = allSettingsAndResults(bestAverageSolutionId,5);
    nTournament = allSettingsAndResults(bestAverageSolutionId,6);
    seed = allSettingsAndResults(bestAverageSolutionId,7);
    title = 'best average solution';
    
    GeneticAlgorithm(nTournament, nCopiesBestIndividual,...
        nVariables, nPopulation,...
        nGenes,crossoverProbability,...
        mutationProbability,tournamentSelectionParameter,...
        variablesRange,nGenerations,...
        doPlot, doPrint, solutionIndex, title, seed);
    
    disp("");
    disp('### ### ### ### rerun and plot for worstAverageSolutionId ### ### ### ###');
    solutionIndex = allSettingsAndResults(worstAverageSolutionId,1);
    nPopulation = allSettingsAndResults(worstAverageSolutionId,2);
    crossoverProbability = allSettingsAndResults(worstAverageSolutionId,3);
    mutationProbability  = allSettingsAndResults(worstAverageSolutionId,4);
    tournamentSelectionParameter = allSettingsAndResults(worstAverageSolutionId,5);
    nTournament = allSettingsAndResults(worstAverageSolutionId,6);
    seed = allSettingsAndResults(worstAverageSolutionId,7);
    title = 'worst average solution';
    
    GeneticAlgorithm(nTournament, nCopiesBestIndividual,...
        nVariables, nPopulation,...
        nGenes,crossoverProbability,...
        mutationProbability,tournamentSelectionParameter,...
        variablesRange,nGenerations,...
        doPlot, doPrint, solutionIndex,title, seed);
    
end

