function [w] = InertiaWeightUpdate(w, beta, wmin)
   
   wbeta = w*beta;
   w = max(wbeta, wmin);
   
end