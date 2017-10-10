function [iterationValues] = NewtonRaphson(polynomialCoefficients, startingPoint, tolerance)

polynomialDegree = size(polynomialCoefficients,2);
%checkNonNegativePolynomialDegree = polynomialDegree < 0;
checkTooLowPolynomialDegree = polynomialDegree < 2;

%if checkNonNegativePolynomialDegree
%    disp("...error in NewtonRaphson (polynomial degree order is negative) --> terminating");
%    return
%end

if checkTooLowPolynomialDegree
    disp("...error in NewtonRaphson (polynomial degree order is < 2) --> terminating");
    return
end

xi = 1e6;
xj = startingPoint;
iterationValues = NaN(1e6, 1);
iterationValues(1) = xj;

i=2;
while abs(xj-xi) > tolerance  
    xi = xj;
    fiPrim = PolynomialDifferentation(polynomialCoefficients,1);
    fiPPrim = PolynomialDifferentation(polynomialCoefficients,2);
    fxiPrim = Polynomial(xi, fiPrim);
    fxiPPrim = Polynomial(xi, fiPPrim);
    if fxiPPrim == 0
        disp("... f''(x) == 0 --> terminating");
        return;
    end
    xj = NewtonRaphsonStep(xi, fxiPrim, fxiPPrim);
    iterationValues(i)=xj;
    i=i+1;
end

iterationValues(isnan(iterationValues)) = [];

%disp("iteration values");
%disp(iterationValues);



end