
function [averageFitness, maxFitness, xBest, fxBest, population] = GeneticAlgorithm(...
        nTournament, nCopiesBestIndividual, nVariables, nPopulation, ...
        nGenes, crossoverProbability, mutationProbability, ...
        tournamentSelectionParameter,variablesRange, ...
        nGenerations, doPlot, doPrint, solutionIndex, title, seed )
    
    
    if nargin == 0
        rng(0);
        clc;
        close all;
        
        nTournament = 2;
        nCopiesBestIndividual = 1;
        nVariables = 2;%# variables in function
        nPopulation = 30; %# chromosomes
        nGenes = 25*nVariables; %# bits for chromosome
        
        crossoverProbability = 0.5;
        mutationProbability = 0.025;
        tournamentSelectionParameter = 0.6;
        variablesRange = 5.0;
        nGenerations = 100;
        
        doPlot = true;
        doPrint = true;
        solutionIndex = -1;
        title = 'test plot';
    end
    
    if nargin == 15
        rng(seed);
    end
    
    
    solutionString = sprintf(" .:: SOLUTION no. (%d), title '%s' ::. \n", solutionIndex,title);
    
    settingsString = sprintf(...
        "... parameters : \n" ...
        + "... ... population size = %d, crossover probab. = %.1f, mutation probab. = %.3f,\n"...
        + "... ... tournament selection param. = %.1f, tournament size = %d\n",...
        nPopulation, crossoverProbability, mutationProbability,...
        tournamentSelectionParameter, nTournament);
    
    
    fitness = zeros(nPopulation,1);
    population = InitializePopulation(nPopulation, nGenes);
    
    if doPlot
        
        [fitnessFigHand,bestPlotHand,averagePlotHand,textHand] = ...
            PlotFitnessFigure(nGenerations,solutionString,settingsString);
        
        [surfFigHand,populationPlotHand,decodedPopulation] = ...
            PlotPopulationSurfaceFigure(fitness,variablesRange,nPopulation, solutionIndex);
    end
    
    for iGeneration = 1:nGenerations
        maxFitness = 0.0; %Assumes non-negative fitness values!
        xBest = zeros(1,2); %[0 0]
        fxBest = 0;
        averageFitness = 0;
        bestIndividualIdx = 0;
        for i=1:nPopulation
            chromosome = population(i,:);
            x = DecodeChromosome(chromosome, nVariables, variablesRange);
            decodedPopulation(i,:)=x;
            fitness(i) = EvaluateIndividual(x);
            averageFitness = averageFitness + fitness(i);
            if (fitness(i) > maxFitness)
                maxFitness = fitness(i);
                bestIndividualIdx = i;
                xBest = x;
                fxBest = ObjectiveFunction(x);
            end
        end
        averageFitness = averageFitness/nPopulation;
        
        %disp('xBest'); % Output suppressed. Retained for debugging.
        % disp(xBest);
        % disp('maximumFitness');
        % disp(maximumFitness);
        
        tmpPopulation = population;
        
        for i=1:2:nPopulation
            
            [chromosome1, chromosome2] = GenerateNewChromosomes(...
                fitness,population, crossoverProbability, ...
                tournamentSelectionParameter, nTournament ...
                );
            
            tmpPopulation(i,:) = chromosome1;
            tmpPopulation(i+1,:) = chromosome2;
            
        end
        
        for i=1:nPopulation
            originalChromosome = tmpPopulation(i,:);
            mutatedChromosome = Mutate(...
                originalChromosome, ...
                mutationProbability ...
                );
            tmpPopulation(i,:) = mutatedChromosome;
        end
        
        bestIndividual = population(bestIndividualIdx,:);
        population = InsertBestIndividual(...
            tmpPopulation, bestIndividual, nCopiesBestIndividual);
        
        
        %     tmpPopulation(1,:) = population(bestIndividualIdx,:);
        %     population = tmpPopulation;
        %
        
        resultsString = sprintf(...
            "... results : avg/max fitness = %.3f/%.3f, f(x1=%.3f, x2=%.3f) = %.3f\n",...
            averageFitness, maxFitness, xBest(1), xBest(2), fxBest);
        
        
        if doPlot
            PlotCurrentGeneration(...
                iGeneration,maxFitness,fitness, ...
                averageFitness,decodedPopulation,...
                bestPlotHand,averagePlotHand,...
                textHand,resultsString,populationPlotHand ...
                );
        end
    end
    
    if doPrint
        printString = sprintf("*** *** *** *** *** %s%s%s",solutionString, settingsString, resultsString);
        
        fprintf(printString);
    end
    
    if doPlot
        fileNameFitnessFigure = sprintf('Figs\\GeneticAlgorithm_solution(%d)_fitness_title(%s)',solutionIndex,title);
        fileNameSurfaceFigure = sprintf('Figs\\GeneticAlgorithm_solution(%d)_surface_title(%s)',solutionIndex,title);
        
        saveas(fitnessFigHand,fileNameFitnessFigure,'png');
        saveas(surfFigHand,fileNameSurfaceFigure,'png');
        
        view(0,90);
        
        saveas(surfFigHand,sprintf('%s%s',fileNameSurfaceFigure,'_view(0,90)'),'png');
        
        close all;
        
    end
end