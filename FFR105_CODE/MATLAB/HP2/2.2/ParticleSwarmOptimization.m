function [positionsSwarmBest, evaluationBestEver] = ParticleSwarmOptimization(nGenerations,...
        nParticles, nVariables, inertiaWeight, inertiaWeightMin, ...
        positionMax, positionMin, deltaT, alpha, inertiaWeightDecrementFactor, componentCognitive,...
        componentSocial, doPlot )
    
    if nargin == 0
        clear all
        clc
        close all
        pause on
        
        nParticles = 30;
        nGenerations = 1000;
        nVariables = 2;
        positionMin = -5;
        positionMax = 5;
        
        alpha = 1;
        deltaT = 1;
        % * cognitive component : measures the degree of self-confidence of a
        % particle, i.e. the degree to which it trusts its own previous 
        % performance as a guide towards obtaining better results
        % * social component measures a particle’s trust in the ability of 
        % the other swarm members to find better candidate solutions
        componentCognitive=2; %based on table 5.1 in BIOM book (small S.D.)
        componentSocial=2; %based on table 5.1 in BIOM book (small S.D.)
        
        % BIOM p. 128. : Thus, a common strategy is to start with a value 
        % larger than 1 (w = 1.4, say), and then reduce w by a constant 
        % factor ? ?]0, 1[ (typically very close to 1) in each iteration,
        % until w reaches a lower bound (typically around 0.3–0.4). 
        inertiaWeight = 1.4;
        inertiaWeightMin = 0.35;
        inertiaWeightDecrementFactor = 0.99; %beta

        doPlot = true;
    end
    
    deltaPosition = positionMax-positionMin;
    velocityMax = deltaPosition / deltaT;
    
    %% 1. Initialize positions and velocities of the particles pi:
    positions = PositionInitialize(nParticles,nVariables, ...
        positionMin, positionMax);
    velocities = VelocityInitialize( nParticles,nVariables,...
        positionMin,positionMax,alpha,deltaT );
    
    positionsBest = positions;
    positionsSwarmBest = positions(1,:);
    
    if (doPlot == true)
        range = [positionMin, positionMax, positionMin, positionMax];
        minimaPlotHand = PlotFunction(positions, range);
    end
    
    
    %% iterate over generations
    for k = 1:nGenerations
        
        %% 2. Evaluate each particle in the swarm, i.e. compute f (xi), i = 1, . . . , N.
        evaluation = EvaluateSwarm(positions);
        evaluationBest = EvaluateSwarm(positionsBest);
        evaluationBestEver = EvaluateSwarm(positionsSwarmBest);
        
        %% 3. Update the best position of each particle, and the global best position.
        % Thus, for all particles pi, i = 1, . . . , N:
        for i=1:nParticles
            %% 3.1. update best positions of swarm particles
            if evaluation(i) < evaluationBest(i)
                positionsBest(i,:) = positions(i,:);
                if (doPlot == true)
                    PlotUpdatePositions(minimaPlotHand,positions);
                    pause(0.02);
                end
            end
            
            %% 3.2. update global best position
            if evaluation(i) < evaluationBestEver
                positionsSwarmBest = positions(i,:);
                if (doPlot == true)
                    PlotUpdatePositions(minimaPlotHand,positions);
                    pause(0.02);
                end
            end
        end
        
        %% 4. Update particle velocities and positions
        velocities = VelocityUpdate(positions, velocities, ...
            positionsBest, positionsSwarmBest, componentCognitive,...
            componentSocial, deltaT, inertiaWeight);
        
        velocities = VelocityCraziness(velocities, velocityMax);
        velocities = VelocityRestrict(velocities, velocityMax);
        
        positions = PositionUpdate(positions, velocities, deltaT);
        
        inertiaWeight = InertiaWeightUpdate(inertiaWeight, ...
            inertiaWeightDecrementFactor, inertiaWeightMin);
        
    end
    
    disp('Best position found')
    disp(round(positionsSwarmBest))
    disp('with function value')
    disp(evaluationBestEver)
    
    
end