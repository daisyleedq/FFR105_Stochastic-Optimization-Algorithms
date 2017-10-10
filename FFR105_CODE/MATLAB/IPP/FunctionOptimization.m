clear all;
close all;

nPopulation = 30;
nGenes = 40;
crossoverProb = 0.8;
mutationProb = 0.025;
tournamentSelectionParam = 0.75;
varRange = 3.0;
nGenerations = 100;

fitness = zeros(nPopulation,1);

[fitnessFigHand,bestPlotHand,textHand] = FitnessFigure(nGenerations);

[surfFigHand,populationPlotHand,decodedPopulation] = ...
    PopulationSurfaceFigure(fitness,varRange,nPopulation);

population = InitializePopulation(nPopulation, nGenes);

for iGeneration = 1:nGenerations
    maxFitness = 0.0; %Assumes non-negative fitness values!
    xBest = zeros(1,2); %[0 0]
    bestIndividualIdx = 0;
    for i=1:nPopulation
        chromosome = population(i,:);
        x = DecodeChromosome(chromosome, varRange);
        decodedPopulation(i,:)=x;
        fitness(i) = EvaluateIndividual(x);
        if (fitness(i) > maxFitness)
            maxFitness = fitness(i);
            bestIndividualIdx = i;
            xBest = x;
        end
    end
    
    %disp('xBest'); % Output suppressed. Retained for debugging.
    % disp(xBest);
    % disp('maximumFitness');
    % disp(maximumFitness);
    
    tmpPopulation = population;
    
    for i=1:2:nPopulation
        
        [chromosome1, chromosome2] = SelectPairChromosomes(...
            fitness,population, crossoverProb, ...
            tournamentSelectionParam ...
            );
        
        tmpPopulation(i,:) = chromosome1;
        tmpPopulation(i+1,:) = chromosome2;
        
    end
    
    for i=1:nPopulation
        originalChromosome = tmpPopulation(i,:);
        mutatedChromosome = Mutate(...
            originalChromosome, ...
            mutationProb ...
            );
        tmpPopulation(i,:) = mutatedChromosome;
    end
    
    tmpPopulation(1,:) = population(bestIndividualIdx,:);
    population = tmpPopulation;
    
    PlotCurrentGeneration(...
        iGeneration,maxFitness,fitness, ...
        decodedPopulation,bestPlotHand, ...
        textHand,populationPlotHand ...
        );
end

format long;
disp('xBest');
disp(xBest);
disp('maxFitness');
disp(maxFitness);


