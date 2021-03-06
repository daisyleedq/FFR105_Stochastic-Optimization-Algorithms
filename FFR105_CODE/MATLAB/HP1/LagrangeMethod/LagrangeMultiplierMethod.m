syms x1 x2 lambda;
x = [x1,x2];
syms f(x1,x2) h(x1,x2) L(x1,x2,lambda) gradL(x1,x2,lambda) hessL(x1,x2,lambda);


f(x1,x2) = 15 + 2*x1 + 3*x2;
h(x1,x2)= x1.^2 + x1.*x2 + x2.^2 - 21;

L(x1,x2,lambda) = f(x1,x2) + lambda*h(x1,x2);

gradL(x1,x2,lambda)= jacobian(L(x1,x2,lambda),[x1,x2,lambda]);
hessL(x1,x2,lambda)= jacobian(gradL(x1,x2,lambda),[x1,x2,lambda]);
