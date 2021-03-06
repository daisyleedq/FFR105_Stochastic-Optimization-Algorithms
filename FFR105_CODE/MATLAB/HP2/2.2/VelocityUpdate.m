function  [v] = VelocityUpdate(x, v, xPB, xSB, c1, c2, dt, w)

    %% BIOM p. 123: Algorithm 5.1, velocity update
    % Given the current values of xpbi and xsb, the velocity of particle pi
    % is then updated. Where q and r are uniform random numbers in [0, 1], 
    % and c1 and c2 are positive constants, typically both set to 2, so that
    % the statistical mean of the two factors c1q and c2r is equal to 1. 
    % The term involving c1 is sometimes referred to as the cognitive 
    % component and the term involving c2 the social component. 
    % The cognitive component measures the degree of self-confidence of a 
    % particle, i.e. the degree to which it trusts its own previous 
    % performance as a guide towards obtaining better results. Similarly, 
    % the social component measures a particle�s trust in the ability of 
    % the other swarm members to find better candidate solutions
    % %%
    
    %% ivIW - inertia weight importance
    % Here, w is referred to as the inertia weight. If w > 1, the particle
    % favours exploration over exploitation, i.e. it assigns less 
    % significance to the cognitive and social components than if w < 1, 
    % in which case the particle is more attracted towards the current best
    % positions. As in the case of EAs, exploration plays a more important
    % role than exploitation in the early stages of optimization, whereas 
    % the opposite holds towards the end.
    %
    % In fact, the use of an inertia weight is so common that we will define
    % the standard PSO algorithm as Algorithm 5.1, but with the velocity 
    % equation (eqn(5.14))replaced by eqn(5.20), and with a variation scheme
    % for w of the kind just described.
    %% 
    
    
    
    [N, n] = size(x);
    r = rand(N,n);
    q = rand(N,n);
    vIW = w .* v;
    vCC = c1 .* q .* (xPB - x) ./ dt;
    vSC = c2 .* r .* (xSB - x) ./ dt;
    v = vIW + vCC + vSC;
    

    
end