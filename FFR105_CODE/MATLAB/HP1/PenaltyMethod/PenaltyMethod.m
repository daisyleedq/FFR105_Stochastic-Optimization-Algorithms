clc;
clf;

global PENALTY_METHOD_ITERATION_INDEX;
global NUMBER_OF_PENALTY_PARAMETERS;
global MINIMA_POINTS;

stepLenght = 1e-4;
treshold = 1e-6;
penaltyParameters = [0 1 10 100 1000 1249 1250];
startingPoint = [1 2]; % vector of [x1,x2] of unconstrained minimum
% from gradient of unconstrained objective function
% for mu = 0 -> nabla*fp(x)=nabla*f(x)+nabla*(0*p(x))=nabla*f(x);

NUMBER_OF_PENALTY_PARAMETERS = size(penaltyParameters,2);
MINIMA_POINTS = zeros(NUMBER_OF_PENALTY_PARAMETERS,3);

penaltyFunctionOrdinata = zeros(NUMBER_OF_PENALTY_PARAMETERS,1);

for PENALTY_METHOD_ITERATION_INDEX=1:NUMBER_OF_PENALTY_PARAMETERS
    mu = penaltyParameters(PENALTY_METHOD_ITERATION_INDEX);
    GradientDescent(startingPoint,mu,stepLenght,treshold);
    statingPoint=MINIMA_POINTS(PENALTY_METHOD_ITERATION_INDEX,1:2);
end

for i=1:NUMBER_OF_PENALTY_PARAMETERS
    % roots of x1, x2 goten from penalty method with gradient descent
    mu = penaltyParameters(i);
    x1 = MINIMA_POINTS(i,1);
    x2 = MINIMA_POINTS(i,2);
    gx = x1.^2 + x2.^2 - 1; %inequality constraint g(x) <= 0;
    hx = 0; %equality constraint h(x) = 0
    px =  mu*(max(0,gx).^2 + hx^2); % penalty term p(x,mu) = mu*(max(0,gx)^2 + hx^2);
    fx = (x1 - 1).^2 + 2*(x2-2).^2; % objective function
    fpx = fx + px; % unconstrained objective function by penalty term;
    MINIMA_POINTS(i,3) = fpx;
end

outputTable = zeros(NUMBER_OF_PENALTY_PARAMETERS,4);
for i=1:NUMBER_OF_PENALTY_PARAMETERS
    mu = penaltyParameters(1,i);
    x1 = MINIMA_POINTS(i,1);
    x2 = MINIMA_POINTS(i,2);
    fpx = UnconstrainedObjectiveFunction(x1,x2,mu);
    outputTable(i,1) = penaltyParameters(1,i);
    outputTable(i,2) = MINIMA_POINTS(i,1);
    outputTable(i,3) = MINIMA_POINTS(i,2);
    outputTable(i,4) = fpx;
    
    
end


%disp('MINIMA POINTS');
%fprintf(1, 'x1\t\t\tx2\t\t\tFp(x, mu)\n')    % Column Titles
%fprintf(1, '%1.3f\t\t%1.3f\t\t%1.3f\n', MINIMA_POINTS')      % Write Rows

disp('OUTPUT TABLE');
fprintf(1, 'mu\t\tx1\t\tx2\t\tfp(x,mu)\n')    % Column Titles
fprintf(1, '%4.d\t%5.3f\t%5.3f\t%5.3f\n', outputTable')      % Write Rows


figure(1)
hold on;
view(0,90);
PlotObjectiveFunctionAndConstrainedArea();
PlotMinimaPointsFromPenaltyMethod();

