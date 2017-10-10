function fitness = EvaluateIndividual(x)
    
    if nargin ~= 1
        x = [2 1];
    end
    
    gx = ObjectiveFunction(x);
    
    fitness = 1/gx;
    

% fN1 = exp(-x(1)^2 - x(2)^2);
% fN2 = sqrt(5)*(sin(x(2)*x(1)*x(1))^2);
% fN3 = 2*(cos(2*x(1)+3*x(2))^2);
% fNumerator = fN1 + fN2 + fN3;
% fDenominator = 1 + x(1)^2 + x(2)^2;
% fitness = fNumerator/fDenominator;

end