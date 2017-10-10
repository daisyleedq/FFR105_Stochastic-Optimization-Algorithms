function newChromosomePair = Cross(chromosome1, chromosome2)
    
    nGenes = size(chromosome1,2); %Both chromosomes must have the same length!
    
    crossoverPoint = 1 + fix(rand*(nGenes-1));
    
    newChromosomePair = zeros(2,nGenes);
    
    n = 0;
    m = 0;
    for j=1:nGenes
        if (j <= crossoverPoint)
            n = 1;
            m = 2;
        else
            n = 2;
            m = 1;
        end
        newChromosomePair(n,j) = chromosome1(j);
        newChromosomePair(m,j) = chromosome2(j);
    end
    
end