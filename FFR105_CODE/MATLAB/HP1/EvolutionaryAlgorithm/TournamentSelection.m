function iSelected = TournamentSelection(fitness, pTournament,nTournament)
    
    if nTournament < 2
        nTournament = 2;
    end
    
    nPopulation = size(fitness,1);
    
    indexTournamentIndividuals = zeros(1,nTournament);
    for i=1:nTournament
        indexTournamentIndividuals(:,i) = 1 + fix(rand * nPopulation);
    end
    
    iSelected = -1;
    
    while (true)
        if isempty(indexTournamentIndividuals) == true
            disp('...return by error in TournamentSelection : indexTournamentIndividuals == empty');
            return
        end
        
        
        r = rand;
        
        if (r < pTournament)
            winningFitness = 0;
            for j=indexTournamentIndividuals
                if (fitness(j) >= winningFitness)
                    winningFitness = fitness(j);
                    iSelected = j;
                end
            end
            return;
        else
            
            
            selectedFitness = 0;
            for j=indexTournamentIndividuals
                if (fitness(j) >= selectedFitness)
                    selectedFitness = fitness(j);
                    iSelected = j;
                end
            end
            
            index2delete = indexTournamentIndividuals==iSelected;
            countIndex2delete = sum(index2delete);
            if countIndex2delete > 1
                firstIndex2delete = find(index2delete~=0, 1, 'first');
                indexTournamentIndividuals(firstIndex2delete)= [];
            else
                indexTournamentIndividuals(index2delete) = [];
            end
        end
        
        if size(indexTournamentIndividuals,2) == 1
            iSelected = indexTournamentIndividuals(1);
            return;
        end
    end
end