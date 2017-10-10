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

doPlot = false;
nIterations = 1000;

p = gcp(); % get the current parallel pool
for i = 1:nIterations
    futures(i) = parfeval(p,@ParticleSwarmOptimization,2, nGenerations,...
        nParticles, nVariables, startingInertiaWeight, lowerBoundInertiaWeight, ...
        positionMax, positionMin, deltaT, alpha, beta, c1, c2, doPlot );
    
end

minimaPositions = zeros(nIterations,2);
minimaValues = zeros(nIterations,1);


%hWaitBar = waitbar(0, 'Blackjack progress', 'CreateCancelBtn', ...
%                   @(src, event) setappdata(gcbf(), 'Cancelled', true));
%setappdata(hWaitBar, 'Cancelled', false);


for idx = 1:nIterations
    [solutionId, bestPositionEver, minimum] = fetchNext(futures);
    minimaPositions(solutionId,:) = bestPositionEver;
    minimaValues(solutionId,:) = minimum;
    %waitbar(solutionId, hWaitBar);
end

minimaPositions = round(minimaPositions,6);
[minimaPositions, minimaPointsId] = unique(minimaPositions,'rows');
minimaValues = minimaValues(minimaPointsId);

sprintf("Minima Positions");
display(minimaPositions)
display(minimaValues)

cancelFutures = onCleanup(@() cancel(futures));
delete(hWaitBar);



