function [x] = PositionInitialize(N,n,xMin,xMax)
    %N - # particles, n - # variables
    
    r = rand(N,n);
    dx = xMax - xMin;
    x = xMin + dx.*r;
    
    %   for i=1:N
    %     for j=1:n
    %       r=rand;
    %       position(i,j)=xMin+r*(xMax-xMin);
    %     end
    %   end
    
    
end
