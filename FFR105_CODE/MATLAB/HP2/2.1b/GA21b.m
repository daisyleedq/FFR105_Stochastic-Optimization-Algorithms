%search shortest path between N cities
%use permutation encoding (p 48 cb):
%% ie chromosomes with lists of integers with indices of cities,
%% use randperm to generate chromosomes
%fitnes should be inverse of path length
%path length is ordinary cartesian measure
%paths should be syntactically correct (each city visited only once)
%each path start and end on same city

%selection operator same as in standard GA

clear all, clc, clf;
addpath('../TSPgraphics');
addpath('..');

NUMBER_OF_SAME_FITNESS_TO_STOP = inf;

%bases on my previous report:
%% hardcoded settings that gave best average solutions
nGenerations = 1e5;
nPopulation = 80;
crossoverProbability = 0.5;
mutationProbability = 0.025;
tournamentSelectionParam = 0.8;
nTournament = 100;
doPlot = true;
nCopiesBestIndividual = 1;

%% initialize arrays
cityLocation = LoadCityLocations();
nCities = size(cityLocation,1);
population = InitializePopulation(nPopulation,nCities);
fitness=zeros(nPopulation,1);

%% initialize plots

[tspFigure,cityPlotHand] = InitializeTspPlot(cityLocation,[0 20 0 20]);
[pathPlotHand,textPlotHand] = InitializeConnections(cityLocation);

fitnessMaxPrevious = zeros(nGenerations,1);
fitnessMaxTimeMean = zeros(nGenerations,1);
fitnessMax = 0;
nfitnessTimeNotChanged = 0;

%% begin for loop over generations
for iGeneration=1:nGenerations
    %% begin for loop over populations
    fitnessMaxPrevious(iGeneration) = fitnessMax;
    fitnessMax = 0;
    fitnessAvg = 0;
    distanceMin = 1e6;
    bestIndividualIdx = 0;
    bestPath = zeros(nCities,1);
    
    for iPopulation = 1:nPopulation
        %% evaluate fitness of populations, grep and plot best one
        pathTemp=population(iPopulation,:);
        fitnessTemp = EvaluateIndividual(cityLocation,pathTemp);
        fitnessAvg = fitnessAvg + fitnessTemp;
        fitness(iPopulation)=fitnessTemp;
        isFitnessBetter = fitnessTemp>fitnessMax;
        if(isFitnessBetter == true)
            bestPath(:) = pathTemp;
            fitnessMax(:) = fitnessTemp;
            distanceMin(:) = 1/fitnessMax;
            bestIndividualIdx = iPopulation;
            
            resultsString = sprintf(...
                "GENERATION: %5.d\n"...
                +"max fitness = %1.4f\n"...
                +"min distance = %5.2f\n",...
                iGeneration, fitnessMax, distanceMin);
            tmpStringForm = 'Iteration %d, generation %d: path length = %.5f\n';
            
            tmpString = sprintf(tmpStringForm,iPopulation,iGeneration,distanceMin);
            fprintf(tmpString);
            
            PlotPath(pathPlotHand, cityLocation, bestPath,...
                resultsString, textPlotHand);
        end
    end
    
    fitnessAvg = fitnessAvg / nPopulation;
    
    fitnessMaxTimeMeanTmp = sum(fitnessMaxPrevious)/iGeneration;
    fitnessMaxTimeMeanTmp = fitnessMaxTimeMeanTmp*(iGeneration > NUMBER_OF_SAME_FITNESS_TO_STOP);
    fitnessMaxTimeMean(iGeneration) = fitnessMaxTimeMeanTmp;
    
    jTmp = max(iGeneration,1);
    iTmp = max(iGeneration-NUMBER_OF_SAME_FITNESS_TO_STOP,1);
    
    fitnessTimeNotChanged = sum(fitnessMaxTimeMean(iTmp:jTmp))/max(fitnessMaxTimeMean);
    fitnessTimeNotChanged = fitnessTimeNotChanged / NUMBER_OF_SAME_FITNESS_TO_STOP;
    fitnessTimeNotChanged = fitnessTimeNotChanged > 1;
    nfitnessTimeNotChanged = (nfitnessTimeNotChanged + 1)*fitnessTimeNotChanged;
    if (nfitnessTimeNotChanged > NUMBER_OF_SAME_FITNESS_TO_STOP)
        break;
    end
    
    populationTemp = population;
    
    %% selection and crossover
    for i=1:2:nPopulation
        
        i1 = TournamentSelection(fitness,tournamentSelectionParam,nTournament);
        i2 = TournamentSelection(fitness,tournamentSelectionParam,nTournament);
        
        chromosome1 = population(i1,:);
        chromosome2 = population(i2,:);
        
        %% selection without crossover
        %         r=rand;
        %         if (r < crossoverProb)
        %             newChromosomePair = Cross(chromosome1, chromosome2);
        %             chromosome1 = newChromosomePair(1,:);
        %             chromosome2 = newChromosomePair(2,:);
        %         end
        
        populationTemp(i,:) = chromosome1;
        populationTemp(i+1,:) = chromosome2;
        
    end
    
    %% Mutation
    for i=1:nPopulation
        originalChromosome = populationTemp(i,:);
        mutatedChromosome = SwapMutate(...
            originalChromosome, ...
            mutationProbability ...
            );
        populationTemp(i,:) = mutatedChromosome;
    end
    
    %% copy best individual into new generation
    bestIndividual = population(bestIndividualIdx,:);
    population = InsertBestIndividual(...
        populationTemp, bestIndividual, nCopiesBestIndividual);
    
    
    %     tmpPopulation(1,:) = population(bestIndividualIdx,:);
    %     population = tmpPopulation;
    %
    
    
    %disp("best path");
    %disp(bestPath);
    
    
    
end


%% example output for long run
% Iteration 1, generation 1: path length = 495.63564
% Iteration 2, generation 1: path length = 494.47888
% Iteration 3, generation 1: path length = 456.01243
% Iteration 22, generation 1: path length = 454.26239
% Iteration 1, generation 2: path length = 454.26239
% Iteration 19, generation 2: path length = 445.85554
% Iteration 36, generation 2: path length = 407.27664
% Iteration 1, generation 3: path length = 407.27664
% Iteration 2, generation 3: path length = 404.06906
% Iteration 9, generation 3: path length = 403.71344
% Iteration 24, generation 3: path length = 398.33343
% Iteration 73, generation 3: path length = 392.86249
% Iteration 1, generation 4: path length = 392.86249
% Iteration 3, generation 4: path length = 392.61283
% Iteration 34, generation 4: path length = 384.94186
% Iteration 36, generation 4: path length = 384.86150
% Iteration 62, generation 4: path length = 384.19541
% Iteration 70, generation 4: path length = 382.57585
% Iteration 1, generation 5: path length = 382.57585
% Iteration 2, generation 5: path length = 379.46037
% Iteration 7, generation 5: path length = 377.49096
% Iteration 56, generation 5: path length = 368.99687
% Iteration 1, generation 6: path length = 368.99687
% Iteration 12, generation 6: path length = 363.44989
% Iteration 19, generation 6: path length = 360.54842
% Iteration 1, generation 7: path length = 360.54842
% Iteration 2, generation 7: path length = 355.15633
% Iteration 80, generation 7: path length = 352.54743
% Iteration 1, generation 8: path length = 352.54743
% Iteration 3, generation 8: path length = 340.56246
% Iteration 21, generation 8: path length = 336.85351
% Iteration 1, generation 9: path length = 336.85351
% Iteration 10, generation 9: path length = 332.20542
% Iteration 31, generation 9: path length = 329.08131
% Iteration 32, generation 9: path length = 325.37297
% Iteration 1, generation 10: path length = 325.37297
% Iteration 22, generation 10: path length = 323.17528
% Iteration 1, generation 11: path length = 323.17528
% Iteration 26, generation 11: path length = 310.23874
% Iteration 1, generation 12: path length = 310.23874
% Iteration 40, generation 12: path length = 302.37780
% Iteration 1, generation 13: path length = 302.37780
% Iteration 1, generation 14: path length = 302.37780
% Iteration 16, generation 14: path length = 292.67075
% Iteration 1, generation 15: path length = 292.67075
% Iteration 58, generation 15: path length = 288.07168
% Iteration 72, generation 15: path length = 286.67247
% Iteration 1, generation 16: path length = 286.67247
% Iteration 23, generation 16: path length = 285.16702
% Iteration 1, generation 17: path length = 285.16702
% Iteration 9, generation 17: path length = 281.70741
% Iteration 59, generation 17: path length = 270.91197
% Iteration 1, generation 18: path length = 270.91197
% Iteration 7, generation 18: path length = 264.68322
% Iteration 1, generation 19: path length = 264.68322
% Iteration 1, generation 20: path length = 264.68322
% Iteration 17, generation 20: path length = 257.74672
% Iteration 1, generation 21: path length = 257.74672
% Iteration 1, generation 22: path length = 257.74672
% Iteration 1, generation 23: path length = 257.74672
% Iteration 37, generation 23: path length = 256.61864
% Iteration 43, generation 23: path length = 255.65826
% Iteration 1, generation 24: path length = 255.65826
% Iteration 74, generation 24: path length = 254.00117
% Iteration 1, generation 25: path length = 254.00117
% Iteration 32, generation 25: path length = 253.86809
% Iteration 1, generation 26: path length = 253.86809
% Iteration 1, generation 27: path length = 253.86809
% Iteration 21, generation 27: path length = 253.10678
% Iteration 1, generation 28: path length = 253.10678
% Iteration 39, generation 28: path length = 252.99353
% Iteration 1, generation 29: path length = 252.99353
% Iteration 17, generation 29: path length = 250.91870
% Iteration 1, generation 30: path length = 250.91870
% Iteration 57, generation 30: path length = 249.89705
% Iteration 1, generation 31: path length = 249.89705
% Iteration 5, generation 31: path length = 247.72153
% Iteration 1, generation 32: path length = 247.72153
% Iteration 22, generation 32: path length = 245.93082
% Iteration 58, generation 32: path length = 241.12085
% Iteration 1, generation 33: path length = 241.12085
% Iteration 1, generation 34: path length = 241.12085
% Iteration 1, generation 35: path length = 241.12085
% Iteration 14, generation 35: path length = 240.53623
% Iteration 1, generation 36: path length = 240.53623
% Iteration 75, generation 36: path length = 240.30389
% Iteration 1, generation 37: path length = 240.30389
% Iteration 1, generation 38: path length = 240.30389
% Iteration 9, generation 38: path length = 237.48886
% Iteration 1, generation 39: path length = 237.48886
% Iteration 1, generation 40: path length = 237.48886
% Iteration 1, generation 41: path length = 237.48886
% Iteration 15, generation 41: path length = 236.90423
% Iteration 38, generation 41: path length = 236.12740
% Iteration 71, generation 41: path length = 231.17769
% Iteration 1, generation 42: path length = 231.17769
% Iteration 1, generation 43: path length = 231.17769
% Iteration 14, generation 43: path length = 231.02664
% Iteration 60, generation 43: path length = 227.67565
% Iteration 1, generation 44: path length = 227.67565
% Iteration 39, generation 44: path length = 225.70445
% Iteration 1, generation 45: path length = 225.70445
% Iteration 11, generation 45: path length = 221.91587
% Iteration 1, generation 46: path length = 221.91587
% Iteration 1, generation 47: path length = 221.91587
% Iteration 42, generation 47: path length = 220.33211
% Iteration 1, generation 48: path length = 220.33211
% Iteration 1, generation 49: path length = 220.33211
% Iteration 1, generation 50: path length = 220.33211
% Iteration 60, generation 50: path length = 219.29636
% Iteration 1, generation 51: path length = 219.29636
% Iteration 20, generation 51: path length = 219.09257
% Iteration 1, generation 52: path length = 219.09257
% Iteration 1, generation 53: path length = 219.09257
% Iteration 33, generation 53: path length = 215.78275
% Iteration 1, generation 54: path length = 215.78275
% Iteration 1, generation 55: path length = 215.78275
% Iteration 1, generation 56: path length = 215.78275
% Iteration 1, generation 57: path length = 215.78275
% Iteration 33, generation 57: path length = 214.68004
% Iteration 1, generation 58: path length = 214.68004
% Iteration 1, generation 59: path length = 214.68004
% Iteration 1, generation 60: path length = 214.68004
% Iteration 9, generation 60: path length = 213.12499
% Iteration 1, generation 61: path length = 213.12499
% Iteration 1, generation 62: path length = 213.12499
% Iteration 1, generation 63: path length = 213.12499
% Iteration 1, generation 64: path length = 213.12499
% Iteration 1, generation 65: path length = 213.12499
% Iteration 1, generation 66: path length = 213.12499
% Iteration 1, generation 67: path length = 213.12499
% Iteration 1, generation 68: path length = 213.12499
% Iteration 1, generation 69: path length = 213.12499
% Iteration 61, generation 69: path length = 212.74744
% Iteration 1, generation 70: path length = 212.74744
% Iteration 19, generation 70: path length = 212.13052
% Iteration 1, generation 71: path length = 212.13052
% Iteration 22, generation 71: path length = 208.38532
% Iteration 1, generation 72: path length = 208.38532
% Iteration 1, generation 73: path length = 208.38532
% Iteration 1, generation 74: path length = 208.38532
% Iteration 69, generation 74: path length = 207.88085
% Iteration 1, generation 75: path length = 207.88085
% Iteration 65, generation 75: path length = 207.86628
% Iteration 1, generation 76: path length = 207.86628
% Iteration 1, generation 77: path length = 207.86628
% Iteration 1, generation 78: path length = 207.86628
% Iteration 1, generation 79: path length = 207.86628
% Iteration 1, generation 80: path length = 207.86628
% Iteration 1, generation 81: path length = 207.86628
% Iteration 55, generation 81: path length = 207.58538
% Iteration 1, generation 82: path length = 207.58538
% Iteration 1, generation 83: path length = 207.58538
% Iteration 1, generation 84: path length = 207.58538
% Iteration 1, generation 85: path length = 207.58538
% Iteration 1, generation 86: path length = 207.58538
% Iteration 1, generation 87: path length = 207.58538
% Iteration 1, generation 88: path length = 207.58538
% Iteration 56, generation 88: path length = 206.93211
% Iteration 1, generation 89: path length = 206.93211
% Iteration 1, generation 90: path length = 206.93211
% Iteration 1, generation 91: path length = 206.93211
% Iteration 68, generation 91: path length = 206.05360
% Iteration 1, generation 92: path length = 206.05360
% Iteration 1, generation 93: path length = 206.05360
% Iteration 1, generation 94: path length = 206.05360
% Iteration 3, generation 94: path length = 205.90383
% Iteration 1, generation 95: path length = 205.90383
% Iteration 1, generation 96: path length = 205.90383
% Iteration 1, generation 97: path length = 205.90383
% Iteration 1, generation 98: path length = 205.90383
% Iteration 1, generation 99: path length = 205.90383
% Iteration 1, generation 100: path length = 205.90383
% Iteration 1, generation 101: path length = 205.90383
% Iteration 1, generation 102: path length = 205.90383
% Iteration 61, generation 102: path length = 204.67302
% Iteration 1, generation 103: path length = 204.67302
% Iteration 1, generation 104: path length = 204.67302
% Iteration 1, generation 105: path length = 204.67302
% Iteration 1, generation 106: path length = 204.67302
% Iteration 1, generation 107: path length = 204.67302
% Iteration 1, generation 108: path length = 204.67302
% Iteration 1, generation 109: path length = 204.67302
% Iteration 1, generation 110: path length = 204.67302
% Iteration 1, generation 111: path length = 204.67302
% Iteration 75, generation 111: path length = 203.02364
% Iteration 1, generation 112: path length = 203.02364
% Iteration 1, generation 113: path length = 203.02364
% Iteration 1, generation 114: path length = 203.02364
% Iteration 1, generation 115: path length = 203.02364
% Iteration 1, generation 116: path length = 203.02364
% Iteration 1, generation 117: path length = 203.02364
% Iteration 1, generation 118: path length = 203.02364
% Iteration 1, generation 119: path length = 203.02364
% Iteration 1, generation 120: path length = 203.02364
% Iteration 1, generation 121: path length = 203.02364
% Iteration 1, generation 122: path length = 203.02364
% Iteration 1, generation 123: path length = 203.02364
% Iteration 18, generation 123: path length = 199.76729
% Iteration 1, generation 124: path length = 199.76729
% Iteration 1, generation 125: path length = 199.76729
% Iteration 1, generation 126: path length = 199.76729
% Iteration 48, generation 126: path length = 191.79892
% Iteration 1, generation 127: path length = 191.79892
% Iteration 1, generation 128: path length = 191.79892
% Iteration 1, generation 129: path length = 191.79892
% Iteration 1, generation 130: path length = 191.79892
% Iteration 1, generation 131: path length = 191.79892
% Iteration 1, generation 132: path length = 191.79892
% Iteration 1, generation 133: path length = 191.79892
% Iteration 1, generation 134: path length = 191.79892
% Iteration 1, generation 135: path length = 191.79892
% Iteration 1, generation 136: path length = 191.79892
% Iteration 1, generation 137: path length = 191.79892
% Iteration 1, generation 138: path length = 191.79892
% Iteration 1, generation 139: path length = 191.79892
% Iteration 12, generation 139: path length = 191.65039
% Iteration 1, generation 140: path length = 191.65039
% Iteration 1, generation 141: path length = 191.65039
% Iteration 1, generation 142: path length = 191.65039
% Iteration 1, generation 143: path length = 191.65039
% Iteration 1, generation 144: path length = 191.65039
% Iteration 1, generation 145: path length = 191.65039
% Iteration 1, generation 146: path length = 191.65039
% Iteration 1, generation 147: path length = 191.65039
% Iteration 1, generation 148: path length = 191.65039
% Iteration 1, generation 149: path length = 191.65039
% Iteration 1, generation 150: path length = 191.65039
% Iteration 1, generation 151: path length = 191.65039
% Iteration 1, generation 152: path length = 191.65039
% Iteration 1, generation 153: path length = 191.65039
% Iteration 1, generation 154: path length = 191.65039
% Iteration 1, generation 155: path length = 191.65039
% Iteration 1, generation 156: path length = 191.65039
% Iteration 1, generation 157: path length = 191.65039
% Iteration 1, generation 158: path length = 191.65039
% Iteration 1, generation 159: path length = 191.65039
% Iteration 1, generation 160: path length = 191.65039
% Iteration 1, generation 161: path length = 191.65039
% Iteration 1, generation 162: path length = 191.65039
% Iteration 1, generation 163: path length = 191.65039
% Iteration 1, generation 164: path length = 191.65039
% Iteration 1, generation 165: path length = 191.65039
% Iteration 1, generation 166: path length = 191.65039
% Iteration 1, generation 167: path length = 191.65039
% Iteration 1, generation 168: path length = 191.65039
% Iteration 1, generation 169: path length = 191.65039
% Iteration 1, generation 170: path length = 191.65039
% Iteration 78, generation 170: path length = 191.37338
% Iteration 1, generation 171: path length = 191.37338
% Iteration 1, generation 172: path length = 191.37338
% Iteration 1, generation 173: path length = 191.37338
% Iteration 1, generation 174: path length = 191.37338
% Iteration 1, generation 175: path length = 191.37338
% Iteration 1, generation 176: path length = 191.37338
% Iteration 1, generation 177: path length = 191.37338
% Iteration 1, generation 178: path length = 191.37338
% Iteration 1, generation 179: path length = 191.37338
% Iteration 1, generation 180: path length = 191.37338
% Iteration 1, generation 181: path length = 191.37338
% Iteration 1, generation 182: path length = 191.37338
% Iteration 1, generation 183: path length = 191.37338
% Iteration 1, generation 184: path length = 191.37338
% Iteration 1, generation 185: path length = 191.37338
% Iteration 1, generation 186: path length = 191.37338
% Iteration 1, generation 187: path length = 191.37338
% Iteration 1, generation 188: path length = 191.37338
% Iteration 1, generation 189: path length = 191.37338
% Iteration 1, generation 190: path length = 191.37338
% Iteration 1, generation 191: path length = 191.37338
% Iteration 1, generation 192: path length = 191.37338
% Iteration 1, generation 193: path length = 191.37338
% Iteration 27, generation 193: path length = 190.98767
% Iteration 1, generation 194: path length = 190.98767
% Iteration 1, generation 195: path length = 190.98767
% Iteration 1, generation 196: path length = 190.98767
% Iteration 1, generation 197: path length = 190.98767
% Iteration 1, generation 198: path length = 190.98767
% Iteration 1, generation 199: path length = 190.98767
% Iteration 1, generation 200: path length = 190.98767
% Iteration 1, generation 201: path length = 190.98767
% Iteration 1, generation 202: path length = 190.98767
% Iteration 64, generation 202: path length = 188.38823
% Iteration 1, generation 203: path length = 188.38823
% Iteration 1, generation 204: path length = 188.38823
% Iteration 1, generation 205: path length = 188.38823
% Iteration 1, generation 206: path length = 188.38823
% Iteration 1, generation 207: path length = 188.38823
% Iteration 1, generation 208: path length = 188.38823
% Iteration 1, generation 209: path length = 188.38823
% Iteration 1, generation 210: path length = 188.38823
% Iteration 1, generation 211: path length = 188.38823
% Iteration 1, generation 212: path length = 188.38823
% Iteration 1, generation 213: path length = 188.38823
% Iteration 1, generation 214: path length = 188.38823
% Iteration 1, generation 215: path length = 188.38823
% Iteration 1, generation 216: path length = 188.38823
% Iteration 1, generation 217: path length = 188.38823
% Iteration 1, generation 218: path length = 188.38823
% Iteration 1, generation 219: path length = 188.38823
% Iteration 1, generation 220: path length = 188.38823
% Iteration 1, generation 221: path length = 188.38823
% Iteration 1, generation 222: path length = 188.38823
% Iteration 1, generation 223: path length = 188.38823
% Iteration 1, generation 224: path length = 188.38823
% Iteration 1, generation 225: path length = 188.38823
% Iteration 1, generation 226: path length = 188.38823
% Iteration 1, generation 227: path length = 188.38823
% Iteration 1, generation 228: path length = 188.38823
% Iteration 1, generation 229: path length = 188.38823
% Iteration 1, generation 230: path length = 188.38823
% Iteration 1, generation 231: path length = 188.38823
% Iteration 1, generation 232: path length = 188.38823
% Iteration 1, generation 233: path length = 188.38823
% Iteration 1, generation 234: path length = 188.38823
% Iteration 1, generation 235: path length = 188.38823
% Iteration 1, generation 236: path length = 188.38823
% Iteration 1, generation 237: path length = 188.38823
% Iteration 1, generation 238: path length = 188.38823
% Iteration 1, generation 239: path length = 188.38823
% Iteration 1, generation 240: path length = 188.38823
% Iteration 1, generation 241: path length = 188.38823
% Iteration 1, generation 242: path length = 188.38823
% Iteration 1, generation 243: path length = 188.38823
% Iteration 1, generation 244: path length = 188.38823
% Iteration 1, generation 245: path length = 188.38823
% Iteration 1, generation 246: path length = 188.38823
% Iteration 1, generation 247: path length = 188.38823
% Iteration 1, generation 248: path length = 188.38823
% Iteration 1, generation 249: path length = 188.38823
% Iteration 1, generation 250: path length = 188.38823
% Iteration 1, generation 251: path length = 188.38823
% Iteration 1, generation 252: path length = 188.38823
% Iteration 1, generation 253: path length = 188.38823
% Iteration 1, generation 254: path length = 188.38823
% Iteration 1, generation 255: path length = 188.38823
% Iteration 1, generation 256: path length = 188.38823
% Iteration 1, generation 257: path length = 188.38823
% Iteration 1, generation 258: path length = 188.38823
% Iteration 1, generation 259: path length = 188.38823
% Iteration 1, generation 260: path length = 188.38823
% Iteration 1, generation 261: path length = 188.38823
% Iteration 1, generation 262: path length = 188.38823
% Iteration 1, generation 263: path length = 188.38823
% Iteration 1, generation 264: path length = 188.38823
% Iteration 1, generation 265: path length = 188.38823
% Iteration 1, generation 266: path length = 188.38823
% Iteration 1, generation 267: path length = 188.38823
% Iteration 1, generation 268: path length = 188.38823
% Iteration 1, generation 269: path length = 188.38823
% Iteration 1, generation 270: path length = 188.38823
% Iteration 1, generation 271: path length = 188.38823
% Iteration 1, generation 272: path length = 188.38823
% Iteration 1, generation 273: path length = 188.38823
% Iteration 1, generation 274: path length = 188.38823
% Iteration 1, generation 275: path length = 188.38823
% Iteration 1, generation 276: path length = 188.38823
% Iteration 1, generation 277: path length = 188.38823
% Iteration 1, generation 278: path length = 188.38823
% Iteration 1, generation 279: path length = 188.38823
% Iteration 1, generation 280: path length = 188.38823
% Iteration 1, generation 281: path length = 188.38823
% Iteration 1, generation 282: path length = 188.38823
% Iteration 1, generation 283: path length = 188.38823
% Iteration 1, generation 284: path length = 188.38823
% Iteration 1, generation 285: path length = 188.38823
% Iteration 1, generation 286: path length = 188.38823
% Iteration 1, generation 287: path length = 188.38823
% Iteration 1, generation 288: path length = 188.38823
% Iteration 1, generation 289: path length = 188.38823
% Iteration 1, generation 290: path length = 188.38823
% Iteration 1, generation 291: path length = 188.38823
% Iteration 1, generation 292: path length = 188.38823
% Iteration 1, generation 293: path length = 188.38823
% Iteration 1, generation 294: path length = 188.38823
% Iteration 1, generation 295: path length = 188.38823
% Iteration 1, generation 296: path length = 188.38823
% Iteration 1, generation 297: path length = 188.38823
% Iteration 1, generation 298: path length = 188.38823
% Iteration 1, generation 299: path length = 188.38823
% Iteration 1, generation 300: path length = 188.38823
% Iteration 1, generation 301: path length = 188.38823
% Iteration 1, generation 302: path length = 188.38823
% Iteration 1, generation 303: path length = 188.38823
% Iteration 1, generation 304: path length = 188.38823
% Iteration 1, generation 305: path length = 188.38823
% Iteration 1, generation 306: path length = 188.38823
% Iteration 1, generation 307: path length = 188.38823
% Iteration 1, generation 308: path length = 188.38823
% Iteration 1, generation 309: path length = 188.38823
% Iteration 1, generation 310: path length = 188.38823
% Iteration 1, generation 311: path length = 188.38823
% Iteration 1, generation 312: path length = 188.38823
% Iteration 1, generation 313: path length = 188.38823
% Iteration 1, generation 314: path length = 188.38823
% Iteration 1, generation 315: path length = 188.38823
% Iteration 1, generation 316: path length = 188.38823
% Iteration 1, generation 317: path length = 188.38823
% Iteration 1, generation 318: path length = 188.38823
% Iteration 1, generation 319: path length = 188.38823
% Iteration 1, generation 320: path length = 188.38823
% Iteration 1, generation 321: path length = 188.38823
% Iteration 1, generation 322: path length = 188.38823
% Iteration 1, generation 323: path length = 188.38823
% Iteration 1, generation 324: path length = 188.38823
% Iteration 1, generation 325: path length = 188.38823
% Iteration 1, generation 326: path length = 188.38823
% Iteration 1, generation 327: path length = 188.38823
% Iteration 1, generation 328: path length = 188.38823
% Iteration 1, generation 329: path length = 188.38823
% Iteration 1, generation 330: path length = 188.38823
% Iteration 1, generation 331: path length = 188.38823
% Iteration 1, generation 332: path length = 188.38823
% Iteration 11, generation 332: path length = 188.02261
% Iteration 1, generation 333: path length = 188.02261
% Iteration 1, generation 334: path length = 188.02261
% Iteration 1, generation 335: path length = 188.02261
% Iteration 1, generation 336: path length = 188.02261
% Iteration 1, generation 337: path length = 188.02261
% Iteration 1, generation 338: path length = 188.02261
% Iteration 80, generation 338: path length = 187.31830
% Iteration 1, generation 339: path length = 187.31830
% Iteration 1, generation 340: path length = 187.31830
% Iteration 1, generation 341: path length = 187.31830
% Iteration 1, generation 342: path length = 187.31830
% Iteration 1, generation 343: path length = 187.31830
% Iteration 1, generation 344: path length = 187.31830
% Iteration 1, generation 345: path length = 187.31830
% Iteration 1, generation 346: path length = 187.31830
% Iteration 1, generation 347: path length = 187.31830
% Iteration 1, generation 348: path length = 187.31830
% Iteration 1, generation 349: path length = 187.31830
% Iteration 1, generation 350: path length = 187.31830
% Iteration 1, generation 351: path length = 187.31830
% Iteration 1, generation 352: path length = 187.31830
% Iteration 1, generation 353: path length = 187.31830
% Iteration 1, generation 354: path length = 187.31830
% Iteration 1, generation 355: path length = 187.31830
% Iteration 1, generation 356: path length = 187.31830
% Iteration 1, generation 357: path length = 187.31830
% Iteration 1, generation 358: path length = 187.31830
% Iteration 1, generation 359: path length = 187.31830
% Iteration 1, generation 360: path length = 187.31830
% Iteration 1, generation 361: path length = 187.31830
% Iteration 1, generation 362: path length = 187.31830
% Iteration 1, generation 363: path length = 187.31830
% Iteration 1, generation 364: path length = 187.31830
% Iteration 1, generation 365: path length = 187.31830
% Iteration 1, generation 366: path length = 187.31830
% Iteration 1, generation 367: path length = 187.31830
% Iteration 1, generation 368: path length = 187.31830
% Iteration 1, generation 369: path length = 187.31830
% Iteration 1, generation 370: path length = 187.31830
% Iteration 1, generation 371: path length = 187.31830
% Iteration 1, generation 372: path length = 187.31830
% Iteration 1, generation 373: path length = 187.31830
% Iteration 1, generation 374: path length = 187.31830
% Iteration 1, generation 375: path length = 187.31830
% Iteration 1, generation 376: path length = 187.31830
% Iteration 1, generation 377: path length = 187.31830
% Iteration 1, generation 378: path length = 187.31830
% Iteration 1, generation 379: path length = 187.31830
% Iteration 1, generation 380: path length = 187.31830
% ...
% Iteration 1, generation 23447: path length = 168.68907
% Iteration 1, generation 23448: path length = 168.68907
% Iteration 1, generation 23449: path length = 168.68907
% Iteration 1, generation 23450: path length = 168.68907
% Iteration 1, generation 23451: path length = 168.68907
% Iteration 1, generation 23452: path length = 168.68907
