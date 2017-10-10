function x = DecodeChromosome(chromosome, nVariables, variableRange)
    
   
    nGenes = size(chromosome, 2);
    nVariableBits = fix(nGenes/nVariables);
    
    x = zeros(nVariables,1);
    
    variableGenes = zeros(nVariables,1);
    
    for j=1:nVariableBits
        for i=1:nVariables
            k = j+nVariableBits*(i-1);
            iGene = chromosome(k);
            variableGenes(i) = iGene;
        end
        x = x + variableGenes.*2^(-j);
    end
    
    tmp = 2*variableRange/(1-2^(-nVariableBits));
    x = -variableRange + tmp*x;
        
end
