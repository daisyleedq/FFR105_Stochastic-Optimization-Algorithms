clc;

penaltyParameter = [0 1 10 100 1000];
stepLenght = 1e-4;
treshold = 1e-6;

startingPoint = [0 -1]; %unconstrained minimum from gradient of fp(x,mu) for mu = 0;

resultPoints = zeros(5);
for mu=penaltyParameter
    disp('##### mu=');
    disp(mu);
    GradientDescentExample(startingPoint,mu,stepLenght,treshold);
end


