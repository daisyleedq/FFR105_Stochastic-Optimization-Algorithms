function iSelected = TournamentSelection(fitness, pTournament)

populationSize = size(fitness,1);
iTmp1 = 1 + fix(rand * populationSize);
iTmp2 = 1 + fix(rand * populationSize);
fTmp3 = fitness(iTmp1) > fitness(iTmp2);

r = rand;

if (r < pTournament)
    if (fTmp3)
        iSelected = iTmp1;
    else
        iSelected = iTmp2;
    end
    
else
    if (fTmp3)
        iSelected = iTmp2;
    else
        iSelected = iTmp1;
        
    end
end

end