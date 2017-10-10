function [polynomialDerivativeCoefficients] = PolynomialDifferentation(polynomialCoefficients, derivativeOrder)

%disp('polynomialCoefficients');
%disp(polynomialCoefficients);

polynomialDegree = size(polynomialCoefficients,2);
polynomialDerivativeDegree = polynomialDegree - derivativeOrder;

checkDerivativeOrder = derivativeOrder < 0 ;
checkPolynomialDerivativeDegree = polynomialDerivativeDegree <= 0;
checkPolynomialDegree = polynomialDegree < 0;

if checkPolynomialDegree
    disp('...error in PolynomialDifferentation (polynomial degree order is negative) --> return');
    return
end

if checkDerivativeOrder
    disp('...error in PolynomialDifferentation (derivative order is negative) --> return');
    return
end

if checkPolynomialDerivativeDegree
    disp('...error in PolynomialDifferentation (polynomial derivative degree is <= 0) --> return');
    return
end


polynomialDerivativeCoefficients = ...
polynomialCoefficients(:,derivativeOrder+1:end);

for j=1:derivativeOrder
    for i=1:polynomialDerivativeDegree
        a = polynomialDerivativeCoefficients(i);
        aJPrim = a * (i + derivativeOrder - j); 
        %how to name it? aPrim, primA? Its nonsense! In this way do not
        %match simple "a". I hate it :( . Want to cry but no tears left....
        polynomialDerivativeCoefficients(i) = aJPrim;
    end
end

%disp("polynomialDerivativeCoefficients");
%disp(polynomialDerivativeCoefficients);

end