function [gradientPenaltyFunction] = GradientExample(x1, x2, mu)
   
   dp_dx1 = mu * 4 * x1 * (x1^2 + 2*x2^2 - 1); %derivative of penalty term over x1
   dp_dx2 = mu * 8 * x2 * (x1^2 + 2*x2^2 - 1); %derivative of penalty term over x2
   gradientPenaltyTerm = [dp_dx1 dp_dx2];
   
   dfx_dx1 = 10 * x1; %derivative of objective function over x1
   dfx_dx2 = 4*(x2+1)^3; %derivative of objective function over x2
   gradientFunction = [dfx_dx1 dfx_dx2];
   
   %gradient of penalty function;
   gradientPenaltyFunction = gradientFunction + gradientPenaltyTerm;
   
   
end