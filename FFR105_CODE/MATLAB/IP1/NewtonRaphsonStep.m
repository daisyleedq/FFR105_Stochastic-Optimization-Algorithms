function [xj] = NewtonRaphsonStep(xi,fxiPrim,fxiPPrim)
% Function NewtonRaphsonStep takes value of point on abscisa "xi", 
% its tangent (slope) value "fxiPrim" on ordinata, 
% and its normal value "fxiPPrim" on ordinata,
% tangent if first derivative of f(x_i)
% normal is second derivative of f(x_i)

xj = xi - fxiPrim / fxiPPrim;

end