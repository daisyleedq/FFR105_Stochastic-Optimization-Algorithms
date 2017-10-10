function [fx] = Polynomial(x, polynomialCoefficients)

polynomialDegree = size(polynomialCoefficients,2);
checkNonNegativePolynomialDegree = polynomialDegree < 0;

if checkNonNegativePolynomialDegree
    disp('...error in NewtonRaphson (polynomial degree order is negative) --> terminating');
    return
end


fx = 0;

for i=1:polynomialDegree
    a = polynomialCoefficients(i);
    fx = fx + a * x^(i-1);
end


end