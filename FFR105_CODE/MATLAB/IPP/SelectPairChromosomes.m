function [chromosome1, chromosome2] = SelectPairChromosomes(fitness,population, crossoverProb, tournamentSelectionParam)
    i1 = TournamentSelection(fitness,tournamentSelectionParam);
    i2 = TournamentSelection(fitness,tournamentSelectionParam);
    chromosome1 = population(i1,:);
    chromosome2 = population(i2,:);
    
    r=rand;
    if (r < crossoverProb)
        newChromosomePair = Cross(chromosome1, chromosome2);
        chromosome1 = newChromosomePair(1,:);
        chromosome2 = newChromosomePair(2,:);        
    end
    
end