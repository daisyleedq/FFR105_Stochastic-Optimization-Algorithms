function [population]=InitializePopulation(nPopulation,nCity)
    % * initialize population setting each chromosome as random permutation
    % of city
    % * following solution of task 2.1, population could only contain set
    % of distinct paths, all the rest are ommited
    
    if nargin == 0
        clear all, clc, clf;

        nPopulation = 80;
        cityLocations = LoadCityLocations();
        nCity = size(cityLocations,1);
        
    end
    
    population=zeros(nPopulation,nCity);
    badPopulation =zeros(nPopulation*100,nCity);
    chromosome = zeros(1,nCity);
    pathRange = [1, nCity];
    %% select starting city
    %set to 1 will give same result, 144.8726
    %this will require better ending point
    
    cityStartingId = randi(pathRange,1,1); 
    chromosome(1) = cityStartingId(1);
    
    n=1;
    m=1;
    while (nPopulation>=n)
        chromosomePart = randperm(nCity);
        chromosomePart(chromosomePart == cityStartingId) = [];
        chromosome(:,2:nCity) = chromosomePart;
        isChromosomeBad = ismember(chromosome,badPopulation);
        if (isChromosomeBad == false)
            isPathDistinct = IsPathDistinct(population,chromosome);
            if (isPathDistinct == true)
                population(n,:) =  chromosome;
                n = n + 1;
            else
                badPopulation(m,:) = chromosome;
                m = m +1;
            end
        end
    end
    
end