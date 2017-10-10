function [fpx] = UnconstrainedObjectiveFunction(x1,x2,mu)
    
    fx = (x1-1)^2+ 2*(x2-2)^2;
    
    px = mu * max(0,x1^2+x2^2-1)^2;
    
    fpx = fx + px;
    
end