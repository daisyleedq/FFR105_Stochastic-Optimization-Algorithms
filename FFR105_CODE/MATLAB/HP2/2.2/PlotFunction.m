function [minimaPlotHand] = PlotFunction(positions, axisRange)
    
    
    if nargin == 0
        
        clear all
        clc
        close all
        
        nParticles = 30;
        nVariables = 2;
        positionMin = -5;
        positionMax = 5;
        axisRange = [positionMin positionMax...
            positionMin positionMax];
        
        positions = InitializeParticlePositions(...
            nParticles,nVariables, positionMin, positionMax);
        
    end
    
    numberOfPoints=500;
    positionsRange=linspace(-5,5,numberOfPoints);
    [positionsGridX,positionsGridY]=meshgrid(positionsRange,positionsRange);
    
    logFunctionValues=zeros(numberOfPoints,numberOfPoints);
    positionsI = zeros(numberOfPoints,2);
    functionValues = zeros(numberOfPoints,numberOfPoints);
    
    for i=1:numberOfPoints
        positionsI(:,1) = positionsGridX(i,:);
        positionsI(:,2) = positionsGridY(i,:);
        functionValues(i,:) = EvaluateSwarm(positionsI);
        logFunctionValues(i,:)=log10(0.01+functionValues(i,:));
    end
    
    x = positionsGridX(:);
    y = positionsGridY(:);
    Z =functionValues(:);
    
    minIdx = abs(Z)<5e-02;
    
    xMin = x(minIdx);
    yMin = y(minIdx);
    zMin = Z(minIdx);
    
    nPositions = size(positions,1);
    
    figureSurface = figure(2);
    hold on;
    surface = surf(positionsGridX, positionsGridY, functionValues);
    surface.EdgeColor = 'none';
    surface.FaceAlpha = 0.9;
    plot3(xMin,yMin,zMin,'r*');
    title('surface of : f(x, y)','Fontsize',25)
    xlabel('x [l.u.]');
    ylabel('y [l.u.]');
    set(gca,'Fontsize',10)
    xlabel('x','FontSize',20)
    ylabel('y','FontSize',20)
    colorbar();
    view(80, 45);
    set(figureSurface, 'Position', [0,50,600,600]);

    hold off;
    
    
    figureContour = figure(1);
    hold on;
    axis manual;
    axis(axisRange);
    axis square;
    grid on;
    
    set(figureContour,'DoubleBuffer','on');
    title('contour of : log(a + f(x, y))','Fontsize',25)
    xlabel('x [l.u.]');
    ylabel('y [l.u.]');
    
    set(gca,'Fontsize',10)
    xlabel('x','FontSize',20)
    ylabel('y','FontSize',20)
    set(gca,'Fontsize',15)
    set(gca, 'xminorgrid', 'on')
    set(gca,'Xtick',axisRange(1):0.5:axisRange(2))
    set(figureContour, 'Position', [650,50,600,600]);

    contour(positionsGridX,positionsGridY,logFunctionValues)
    
    % minVal = functionValues(minIdx);
    
    minimaPlotHand = zeros(nPositions,1);
    
    for i = 1:nPositions
        tmp = [positions(i,1)-0.25 positions(i,2)-0.25 0.5 0.5];
        minimaPlotHand(i) = rectangle('Position', tmp,'Curvature', [1 1]);
    end
    
    plot(xMin,yMin,'r*');
    
    hold off;
    
end