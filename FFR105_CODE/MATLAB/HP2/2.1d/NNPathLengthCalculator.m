
%% initialize
clear all, clc;
addpath('..');
%% load city coordinates
cityLocation=LoadCityLocations();
%% compute length of path with random starting city
[NNPathLength, NNPath, cityStartingId] = GetNearestNeighbourPathLength(cityLocation);
%% display results
stringForm = "NNPathLengthCalculator : "...
             + "starting city = %d, nn-path length = %.4f\n"...
             + "nn-path = \n";
fprintf(stringForm,cityStartingId, NNPathLength);
display(NNPath');

%% Example output:
% NNPathLengthCalculator : starting city = 41, nn-path length = 145.2056
% nn-path = 
%   Columns 1 through 29
%
%     41    39    42    45    43    37    38    35    34    31    33    25    26    23    19    16    17    14    13     8     7     3     6    12    18    21    24    27    15
% 
%   Columns 30 through 50
% 
%      9     5     4     2     1    10    11    22    29    32    36    40    48    46    47    44    30    28    20    50    49