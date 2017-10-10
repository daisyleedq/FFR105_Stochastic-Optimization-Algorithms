function [minimaPlotHand] = PlotFunction(positions, axisRange, minimaPositions, minimaValues)
    
    
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
        
        positions = PositionInitialize(...
            nParticles,nVariables, positionMin, positionMax);
        
        minimaPositions = [];
        minimaValues = [];
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
    ylabel('f(x,y)','FontSize',20)
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
    
    set(gca, 'xminorgrid', 'on')
    set(gca,'Xtick',axisRange(1):0.5:axisRange(2))
    set(gca,'Fontsize',10)
    xlabel('x','FontSize',10)
    ylabel('y','FontSize',20)
    set(figureContour, 'Position', [620,50,900,700]);
    
    contour(positionsGridX,positionsGridY,logFunctionValues)
    
    % minVal = functionValues(minIdx);
    
    if (positions == false)
        minimaPlotHand = zeros(nPositions,1);
        
        for i = 1:nPositions
            tmp = [positions(i,1)-0.25 positions(i,2)-0.25 0.5 0.5];
            minimaPlotHand(i) = rectangle('Position', tmp,'Curvature', [1 1]);
        end
    end
    
    plot(xMin,yMin,'r*');
    
    hold off;
    
    if (isempty(minimaPositions) == false && isempty(minimaValues) == false)
        dataOutput = [minimaPositions(:,1) minimaPositions(:,2) minimaValues]';
        stringFormat = 'f(%4.6f, %4.6f) = %4.2f\n';
        nMinima = size(minimaValues,1);
        for i=1:nMinima
            string = sprintf(stringFormat,dataOutput(:,i));
            text(minimaPositions(i,1)*1.13, minimaPositions(i,2)*1.13,string);
        end
    end
    
end