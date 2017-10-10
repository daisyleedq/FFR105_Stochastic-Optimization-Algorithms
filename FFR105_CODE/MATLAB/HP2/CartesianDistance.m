function [d] = CartesianDistance(a,b)
    
    if nargin == 0
        a = [0,0.1]+1;
        b = [5,5.1]+1;
        % result should be 2.8284
    end
    
    %return math.sqrt((p0[0] - p1[0])**2 + (p0[1] - p1[1])**2)
    
    d = sqrt(sum(power(b - a,2)));
    
end