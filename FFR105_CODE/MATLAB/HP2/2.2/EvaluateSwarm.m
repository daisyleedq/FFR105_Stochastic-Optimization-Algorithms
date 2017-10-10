function [fxy] = EvaluateSwarm(positions)
    
    x = positions(:,1);
    y = positions(:,2);

    gx = x.^2 + y    - 11;
    hx = x    + y.^2 - 7;
    
    fxy = gx.^2 + hx.^2;

end
