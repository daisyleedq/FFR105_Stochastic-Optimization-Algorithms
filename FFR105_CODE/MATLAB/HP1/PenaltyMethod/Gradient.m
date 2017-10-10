function [gradientUnconstrainedObjectiveFunction] = Gradient(x1, x2, mu)
    %https://math.stackexchange.com/questions/1431226/gradient-descent-and-penalty-method
    
    % (max{0, g(x^n)}^2)' = (g(x^n)^2)' = n*x^(n-1)*g(x^n)
    % mu*max(x1^2 + x2^2 -1, 0)^2 = [...] = mu*4*(x1^2,x2^2)*(x1^2+x2^2-1) if x1^2+x2^2-1 >= 0 else (0,0);
    
    gradientPenaltyTerm = [0 0];
    isOutPenaltyFunctionValidDomain = x1^2 + x2^2 - 1 >=0;
    
    if isOutPenaltyFunctionValidDomain
        dp_dx1 = mu * 4 * x1 * (x1^2 + x2^2 - 1);
        dp_dx2 = mu * 4 * x2 * (x1^2 + x2^2 - 1);
        gradientPenaltyTerm(:) = [dp_dx1 dp_dx2];
    end
    
    % partial{(x1-1)^2 + 2(x2-2)^2} = ((x1-1)*2, 4*(x2-2))
    df_dx1 = 2*(x1-1);
    df_dx2 = 4*(x2-2);
    gradientObjectiveFunction(:) = [df_dx1 df_dx2];
    
    gradientUnconstrainedObjectiveFunction(:) = gradientObjectiveFunction + gradientPenaltyTerm;
    
    
    
end