function [modulus] = VectorModulus(vector)
   
    modulus = sum(vector.^2)^0.5;
    
end