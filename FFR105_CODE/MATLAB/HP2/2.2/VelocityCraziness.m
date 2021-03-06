function [ v] = VelocityCraziness(v, vMax)
    
    %% BIOM p. 128-129
    
    % The final PSO component that will be considered here is the so called 
    % craziness operator. This operator, which is typically applied with a 
    % given probability pCR, sets the velocity of the particle pi in 
    % question to a uniform random value within the allowed range. 
    % Where r is a random number in [0, 1].
    
    % The craziness operator, which in some way serves the same function as
    % mutations in an EA, can be said to have a biological motivation:
    % in flocks of birds one can observe that, from time to time, one bird
    % suddenly shoots off in a seemingly random direction (only to re-enter
    % the swarm shortly thereafter)
    
    if nargin == 0
        clear all
        clc
        positionMin = -5;
        positionMax = 5;
        deltaT = 1;
        deltaPosition = positionMax-positionMin;
        vMax = deltaPosition / deltaT;
        
        v = [0 0; 1 1; -2 3; 3.3 0; 1 -2];

    end
    
    [N, n] = size(v); % N - # particles, n - # variables
    
    pCR = 1 / N;
    
    r = rand(N,n);
    q = rand(N,n);
    
    idx = r < pCR;
    
    vTemp = q(idx) .* 2 - 1;
    v(idx) = vTemp .* vMax;
    
    
end