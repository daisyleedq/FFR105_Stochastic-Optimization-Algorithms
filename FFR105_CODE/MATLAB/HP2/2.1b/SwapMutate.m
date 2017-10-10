function mutatedChromosome = SwapMutate(chromosome, mutationProbability)
    
    if nargin == 0
        clear all, clc;
        
        %% hardcoded settings that gave best average solutions
        nPopulation = 80;
        mutationProbability = 0.1;
        
        %% initialize arrays
        cityLocations = LoadCityLocations();
        nCities = size(cityLocations,1);
        population = InitializePopulation(nPopulation,nCities);
        
        chromosome = population(1,:);
    end
    
    nGenes = size(chromosome,2);
    swapRange = [1,nGenes];
    mutatedChromosome = chromosome;
    
    for j=1:nGenes
        r = rand;
        if (r < mutationProbability)
            swapId = randi(swapRange,1,1);
            while (swapId == j)
                swapId = randi(swapRange,1,1);
            end
            geneSwap = mutatedChromosome(swapId);
            geneTemp = mutatedChromosome(j);
            mutatedChromosome(swapId)=geneTemp;
            mutatedChromosome(j)=geneSwap;
        end
    end
    
    if nargin == 0
        disp("check if mutated path is swap properly");
        disp(sum(chromosome) == sum(mutatedChromosome));
    end
end
