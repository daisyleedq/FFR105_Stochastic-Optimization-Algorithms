function [] = GradientDescent(startingPoint, penaltyParameter, stepLength, treshold)
    
    %startingPoint = [x10 x20];
    %penaltyParameter = mu;
    %stepLength = eta;
    %treshold = T;
    
    global PENALTY_METHOD_ITERATION_INDEX;
    global MINIMA_POINTS;
    
    currentPoint = startingPoint;    
    searchDirection = [0 0];
    modulusGradientFpx = 1;
    
    while (true)
        
        x1 = currentPoint(1);
        x2 = currentPoint(2);
        
        %Fpx : Fp(x) = F(x) + p(x);
        %gradientFpx : nabla * Fp(x);
        
        gradientFpx(:) = Gradient(x1, x2, penaltyParameter);
        modulusGradientFpx(:) = VectorModulus(gradientFpx);
        
        isNanModulusGradientFpx = isnan(modulusGradientFpx);
        tresholdReached = modulusGradientFpx < treshold;
        
        if isNanModulusGradientFpx == true
            fprintf(2, '...error in GradientDescent.m (line 27) : |nabla*Fp(x1, x2, mu=%d)| = NaN\n', penaltyParameter);
            break
        end
        
        if tresholdReached == true
            break
        end
        
        searchDirection(:) = - gradientFpx;
        currentPoint(:) = currentPoint + stepLength*searchDirection;
        
        
    end
    
    currentPoint = [currentPoint 0];
    MINIMA_POINTS(PENALTY_METHOD_ITERATION_INDEX,:) = currentPoint;
    
end