
close all;
clc;

doRunOnlyTest = true;
doRunOnlyForPrecalculatedSolutions = false;

%hardcoded constant parameters
nCopiesBestIndividual = 2;
variablesRange = 5.0;
nGenerations = 100;
nVariables = 2;%# variables in function
nGenes = nVariables*25; %# bits for chromosome

if doRunOnlyTest
    disp("############################ PART 0 ################################");
    disp("### ### ### ### ### ### ### TEST RUN");
    
    clc;
    close all;
    
    nTournament = 6;
    nPopulation = 80; %# chromosomes
    crossoverProbability = 0.5;
    mutationProbability = 0.025;
    tournamentSelectionParameter = 0.8;
    
    doPlot = true;
    doPrint = true;
    solutionIndex = -1;
    title = 'test run';
    
    seed = fix(randi([0,20],1,1));
    rng(seed);
    
    [averageFitness, maxFitness, xBest, fxBest] = GeneticAlgorithm(...
        nTournament, nCopiesBestIndividual,...
        nVariables, nPopulation,...
        nGenes,crossoverProbability,...
        mutationProbability,tournamentSelectionParameter,...
        variablesRange,nGenerations,...
        doPlot, doPrint, solutionIndex, title, seed);
    
    return;
end

if doRunOnlyForPrecalculatedSolutions
    
    disp("############################ PART -1 ################################");
    disp("### ### ### ### ### ### ### RELOAD SAVED RESULTS");
    matFile = matfile('allSettingsAndResults.mat');
    
    try
        allSettingsAndResults = matFile.allSettingsAndResults;
        nResults = size(allSettingsAndResults);
        
        if nResults > 1
            RerunBestAndWorstSolutions(allSettingsAndResults,nGenes,nVariables,...
                nGenerations,variablesRange,nCopiesBestIndividual);
            return
        end
        
    catch
        disp("... RELOAD OF FILE FILED -> continue program");
    end
end

disp("############################ PART 0 ################################");
disp("### ### ### ### ### ### ### RUN NESTED FOR LOOP AND SAVE");

%hardcoded sets of parameters
nPopulations = [40 80]; %# chromosomes
nTournaments = [2 4 6];
mutationProbabilities = [0.025 0.05 0.075];
crossoverProbabilities = [0.3 0.5 0.7];
tournamentSelectionParameters = [0.2 0.5 0.8];

%run settings
doPlot = true;
doPrint = true;
nRuns2Stop = 1e6;
nAveragingRuns = 20;

disp("############################ PART I ################################");
disp("### RUN FOR DIFFERENT SETS OF PARAMETERS TO FIND BEST/WORST SOLUTIONS");


%reduce for loop input parameters to zero
nTournament=0;
nPopulation = 0;
mutationProbability=0.0;
crossoverProbability=0.0;
tournamentSelectionParameter=0.0;

%parameters
currentSettings = double(zeros(1,6));
allSettingsAndResults = double([]);

solutionIndex = 1;
iRunsIterator = 1;
for nPopulation=nPopulations
    for crossoverProbability=crossoverProbabilities
        for mutationProbability=mutationProbabilities
            for tournamentSelectionParameter=tournamentSelectionParameters
                for nTournament=nTournaments
                    
                    currentSettings(:) = [nPopulation, crossoverProbability, ...
                        mutationProbability, tournamentSelectionParameter, ...
                        nTournament, 0];
                    
                    xBestMean = double(zeros(nVariables));
                    fxBestMean = 0.;
                    maxFitnessMean = 0.;
                    averageFitnessMean = 0.;
                    seedMean = 0;
                    
                    for i=1:nAveragingRuns-1
                        
                        if nRuns2Stop <= iRunsIterator
                            break
                        end
                        
                        seed = fix(randi([0,20],1,1));
                        rng(seed);
                        
                        [averageFitness, maxFitness, xBest, fxBest] = GeneticAlgorithm(...
                            nTournament, nCopiesBestIndividual,...
                            nVariables, nPopulation,...
                            nGenes,crossoverProbability,...
                            mutationProbability,tournamentSelectionParameter,...
                            variablesRange,nGenerations,...
                            false, true, solutionIndex, ...
                            sprintf('averaging run (%d)',i) ...
                            );
                        
                        
                        averageFitnessMean = averageFitnessMean + averageFitness;
                        maxFitnessMean = maxFitnessMean + maxFitness;
                        xBestMean = xBestMean + xBest;
                        fxBestMean = fxBestMean + fxBest;
                        seedMean = seedMean + seed;
                        
                        iRunsIterator = iRunsIterator + 1;
                        
                    end
                    
                    seed = fix(randi([0,20],1,1));
                    rng(seed);
                    
                    [averageFitness, maxFitness, xBest, fxBest, population] = ...
                        GeneticAlgorithm(...
                        nTournament, nCopiesBestIndividual,...
                        nVariables, nPopulation,...
                        nGenes,crossoverProbability,...
                        mutationProbability,tournamentSelectionParameter,...
                        variablesRange,nGenerations,...
                        false, true, solutionIndex,...
                        sprintf('averaging run (%d)',i+1) ...
                        );
                    
                    averageFitnessMean = averageFitnessMean + averageFitness;
                    maxFitnessMean = maxFitnessMean + maxFitness;
                    xBestMean = xBestMean + xBest;
                    fxBestMean = fxBestMean + fxBest;
                    seedMean = seedMean + seed;
                    
                    averageFitnessMean = averageFitnessMean/nAveragingRuns;
                    maxFitnessMean = maxFitnessMean/nAveragingRuns;
                    xBestMean=xBestMean/nAveragingRuns;
                    fxBestMean = fxBestMean/nAveragingRuns;
                    seedMean = fix(seedMean/nAveragingRuns);
                    
                    currentSettings(6) = seedMean;
                    
                    currentResults = [solutionIndex, currentSettings, ...
                        xBestMean(1), xBestMean(2), fxBestMean,...
                        maxFitnessMean, averageFitnessMean];
                    
                    allSettingsAndResults = [allSettingsAndResults; currentResults];
                    solutionIndex = solutionIndex + 1;
                    
                end
            end
        end
    end
end


allMinFitness = 1e6;
allMaxFitness = 0;
allMaxAverageFitness = 0;
allMinAverageFitness = 1e6;

allMinFitnessId = 0;
allMaxFitnessId = 0;
allMaxAverageFitnessId = 0;
allMinAverageFitnessId = 0;

nResults = size(allSettingsAndResults,1);

save('allSettingsAndResults.mat','allSettingsAndResults');

RerunBestAndWorstSolutions(allSettingsAndResults,nGenes,nVariables,...
    nGenerations,variablesRange,nCopiesBestIndividual);

return;


