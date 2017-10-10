clear all
clc
close all
pause on

nParticles = 40;
nGenerations = 1000;
nVariables = 2;
positionMin = -5;
positionMax = 5;


deltaT = 1;
c1=2;
c2=2;
beta = 0.995;
alpha=1;
startingInertiaWeight = 1.4;
lowerBoundInertiaWeight = 0.35;

doParallelComputing = false;
doPlot = false;
nIterations = 100;


minimaPositions = zeros(nIterations,2);
minimaValues = zeros(nIterations,1);

if (doParallelComputing == true)
    p = gcp(); % get the current parallel pool
    for i = 1:nIterations
        
        futures(i) = parfeval(p,@ParticleSwarmOptimization,2, ...
            nGenerations, nParticles, nVariables, startingInertiaWeight,...
            lowerBoundInertiaWeight,  positionMax, positionMin, deltaT,...
            alpha, beta, c1, c2, doPlot );
    end
    
    for idx = 1:nIterations
        
        [solutionId, bestPositionEver, minimum] = fetchNext(futures);
        minimaPositions(solutionId,:) = bestPositionEver;
        minimaValues(solutionId,:) = minimum;
        
    end
    
else
    
    for i=1:nIterations
        
        [bestPositionEver, minimum] = ParticleSwarmOptimization(...
            nGenerations, nParticles, nVariables, startingInertiaWeight,...
            lowerBoundInertiaWeight,  positionMax, positionMin, deltaT,...
            alpha, beta, c1, c2, doPlot );
        
        minimaPositions(i,:) = bestPositionEver;
        minimaValues(i,:) = minimum;
        
    end
    
end

minimaPositions = round(minimaPositions,6);

[minimaPositions, minimaPointsId] = unique(minimaPositions,'rows');
minimaValues = minimaValues(minimaPointsId);

range = [positionMin, positionMax, positionMin, positionMax];

PlotFunction([], range, minimaPositions, minimaValues);

fprintf('-------------------------------------------------\n');
fprintf('|\t\t positions \t\t\t || \t minima \t|\n');
fprintf('|\t x \t\t\t\t y \t\t || \t f(x,y) \t|\n');
fprintf('-------------------------------------------------\n');
stringFormat = '| %4.6f\t|\t%4.6f \t || \t %4.6f \t|\n';
dataOutput = [minimaPositions(:,1) minimaPositions(:,2) minimaValues]';
stringOutput = sprintf(stringFormat,dataOutput);
fprintf(stringOutput);
fprintf('-------------------------------------------------\n');

cancelFutures = onCleanup(@() cancel(futures));



