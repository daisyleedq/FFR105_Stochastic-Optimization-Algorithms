function [velocity] = VelocityInitialize( N,n,xMin,xMax,alpha,dt )
    
    r = rand(N,n);
    dx = xMax - xMin;
    
    velocity = alpha/dt .* (- 0.5 .* dx + r .* dx);
    

end

