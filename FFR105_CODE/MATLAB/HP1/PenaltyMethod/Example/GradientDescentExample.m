function [] = GradientDescentExample(startingPoint, penaltyParameter, stepLength, treshold)
    %startingPoint = [x10 x20]; 
    %penaltyParameter = mu;
    %stepLength = eta;
    %treshold = T;
    
    currentPoint = startingPoint;
    searchDirection = [0 0];
  
    while (true)
        
        x1 = currentPoint(1);
        x2 = currentPoint(2);
        
        gradientPenaltyFunction = GradientExample(x1, x2, penaltyParameter);
        modulusGradientPenaltyFunction = VectorModulus(gradientPenaltyFunction);
        tresholdReached = modulusGradientPenaltyFunction < treshold;
        
        if tresholdReached == true
            break
        end
        
        searchDirection = - gradientPenaltyFunction;
        currentPoint = currentPoint + stepLength*searchDirection;
       
    end
    
    disp('gradientPenaltyFunction');
    disp(gradientPenaltyFunction);
    disp('modulusGradientPenaltyFunction');
    disp(modulusGradientPenaltyFunction);
    disp('searchDirection');
    disp(searchDirection);
    disp('stepLength');
    disp(stepLength);
    disp('currentPoint');
    disp(currentPoint);
    
end