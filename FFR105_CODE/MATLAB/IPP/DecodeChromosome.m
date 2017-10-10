function x = DecodeChromosome(chromosome, variableRange)
    
    nGenes = size(chromosome, 2);
    nHalf = fix(nGenes/2);
    
    x(1) = 0.0;
    x(2) = 0.0;
   
    for j=1:nHalf
        gene1 = chromosome(j);
        gene2 = chromosome(j+nHalf);
        x(1) = x(1) + gene1*2^(-j);
        x(2) = x(2) + gene2*2^(-j);
    end
    
    tmp = 2*variableRange/(1-2^(-nHalf));
    x(1) = -variableRange + tmp*x(1);
    x(2) = -variableRange + tmp*x(2);
    
end
