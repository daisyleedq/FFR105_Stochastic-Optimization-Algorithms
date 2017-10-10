%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ant system (AS) for TSP.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
addpath('..');
addpath('../TSPgraphics'); %added to avoid making copy of TSPgraphics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cityLocation = LoadCityLocations();
numberOfCities = length(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = size(cityLocation,1);   % To do: Set to appropriate value.
alpha = 1.0;        % To do: Set to appropriate value.
beta = 5.0;         % To do: Set to appropriate value.
rho = 0.5;          % To do: set to appropriate value.

% To do: Write the GetNearestNeighbourPathLength function
nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocation); % To do: Write the GetNearestNeighbourPathLength function
tau0 = numberOfAnts/nearestNeighbourPathLength;

targetPathLength = 123.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocation, range);
connection = InitializeConnections(cityLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0); % To do: Write the InitializePheromoneLevels
visibility = GetVisibility(cityLocation);                         % To do: write the GetVisibility function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimumPathLength = inf;

iIteration = 0;
pathCollection = zeros(numberOfAnts, numberOfCities);
pathLengthCollection = zeros(numberOfAnts,1);

while (minimumPathLength > targetPathLength)
    iIteration = iIteration + 1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate paths:
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for k = 1:numberOfAnts
        path = GeneratePath(pheromoneLevel, visibility, alpha, beta);   % To do: Write the GeneratePath function (and any necessary functions called by GeneratePath).
        pathLength = GetPathLength(path,cityLocation);                  % To do: Write the GetPathLength function
        if (pathLength < minimumPathLength)
            minimumPathLength = pathLength;
            tmpStringForm = 'Iteration %d, ant %d: path length = %.5f\n';
            tmpString = sprintf(tmpStringForm,iIteration,k,minimumPathLength);
            fprintf(tmpString);
            PlotPath(connection,cityLocation,path);
        end
        pathCollection(k,:) = path;
        pathLengthCollection(k) = pathLength;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Update pheromone levels
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);  % To do: write the ComputeDeltaPheromoneLevels function
    pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho);          % To do: write the UpdatePheromoneLevels function
    
end

%% example output for long run
% Iteration 1, ant 1: path length = 166.69182
% Iteration 1, ant 4: path length = 135.67235
% Iteration 4, ant 49: path length = 134.58756
% Iteration 10, ant 49: path length = 131.85507
% Iteration 13, ant 23: path length = 130.01021
% Iteration 14, ant 38: path length = 126.11777
% Iteration 52, ant 30: path length = 124.51313
% Iteration 491, ant 14: path length = 123.91085
% Iteration 1412, ant 42: path length = 122.67804
%%





