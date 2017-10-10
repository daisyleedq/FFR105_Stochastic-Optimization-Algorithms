function [population] = InsertBestIndividual(population, bestIndividual, nCopies)
    

    if nargin == 0
        population = zeros(5,10);
        bestIndividual = ones(1,10);
        nCopies = 1;
    elseif nargin == 1
        bestIndividual = ones(1,10);
        nCopies = 1;
    elseif nargin == 2
        nCopies = 1;
    end
    
    for i=1:nCopies
        population(i,:) = bestIndividual;
    end
    
end

