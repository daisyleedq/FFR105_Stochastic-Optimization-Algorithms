function  [v] = VelocityRestrict(v, vMax)
    
    %% BIOM p. 123 Algorithm 5.1 - update velocities
    % Once the velocities have been
    % updated, restriction to a given range |vij| < vmax is carried out, a 
    % crucial step for maintaining the coherence of the swarm, i.e. to keep
    % it from expanding indefinitely (see Section 5.3.3). 
    % It should be noted that the restriction of particle velocities does
    % not imply that the positions will be constrained to the range 
    % [xmin, xmax]; it only means that particle positions will remain bounded.
    %%
    %% BIOM p. 126-127 Maintaining coherence
    % Thus, in practice, the divergence of particle trajectories must somehow
    % be controlled actively. The simplest way of doing so is to introduce
    % a limit on particle velocities. Typically, the velocity of particle 
    % pi is restricted such that |vij| < vMax.
    % Thus if, after an update using eqn (5.14), vij > vmax, then vij is 
    % simply set equal to vmax. Similarly if vij < ?vmax, vij is set equal 
    % to ?vmax. This, however, is not the only way to maintain swarm coherence.
    %% 
    
    v = max(v, -vMax);
    v = min(v, vMax);

    
    
end