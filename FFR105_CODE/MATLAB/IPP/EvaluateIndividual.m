function f = EvaluateIndividual(x)

fN1 = exp(-x(1)^2 - x(2)^2);
fN2 = sqrt(5)*(sin(x(2)*x(1)*x(1))^2);
fN3 = 2*(cos(2*x(1)+3*x(2))^2);
fNumerator = fN1 + fN2 + fN3;
fDenominator = 1 + x(1)^2 + x(2)^2;
f = fNumerator/fDenominator;

end