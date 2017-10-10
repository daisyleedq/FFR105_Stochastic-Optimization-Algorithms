function [gx] = ObjectiveFunction(x)
    
    if nargin ~= 1
        x = [2 1];
    end
    
    x1 = x(1);
    x2 = x(2);
    
    gx11 = (x1 + x2 + 1)^2;
    gx12 = 19 - 14*x1 + 3*x1^2 - 14*x2 + 6*x1*x2 + 3*x2^2;
    
    gx21 = (2*x1 - 3*x2)^2;
    gx22 = 18 - 32*x1 + 12*x1^2 + 48*x2 - 36*x1*x2 + 27*x2^2;
    
    gx1 = (1 + gx11*gx12);
    gx2 = (30 + gx21*gx22);
    
    gx = gx1*gx2;
    
    
end