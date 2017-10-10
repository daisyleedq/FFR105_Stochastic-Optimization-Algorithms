%
% syms x a b c
% simplify(sin(x)^2 + cos(x)^2)
% simplify(exp(c*log(sqrt(a+b))))

syms x1 x2 f(x1,x2) gradF(x1,x2);

gx11 = (x1 + x2 + 1)^2;
gx12 = 19 - 14*x1 + 3*x1^2 - 14*x2 + 6*x1*x2 + 3*x2^2;

gx21 = (2*x1 - 3*x2)^2;
gx22 = 18 - 32*x1 + 12*x1^2 + 48*x2 - 36*x1*x2 + 27*x2^2;

gx1 = (1 + gx11*gx12);
gx2 = (30 + gx21*gx22);

f(x1,x2) = gx1*gx2;

gradF(x1,x2) = gradient(f(x1,x2),[x1,x2])


f(2,1)
f(0,-1)
gradF(2,1)
gradF(0,-1)