function [surfFigHand,populationPlotHand,decodedPopulation] = ...
        PlotPopulationSurfaceFigure(fitness,varRange,nPopulation, solutionIndex)
    surfFigHand = figure;
    hold on;
    set(surfFigHand, 'DoubleBuffer', 'on');
    delta = 0.1;
    limit = fix(2*varRange/delta) + 1;
    [xVals, yVals] = meshgrid(...
        -varRange:delta:varRange, ...
        -varRange:delta:varRange ...
        );
    zVals = zeros(limit, limit);
    for j=1:limit
        for k=1:limit
            tmp = [xVals(j,k) yVals(j,k)];
            z = EvaluateIndividual(tmp);
            zVals(j,k) = z;
        end
    end
    surfl(xVals, yVals, zVals);
    colormap gray;
    shading interp;
    view([-7 -9 10]);
    decodedPopulation = zeros(nPopulation,2);
    populationPlotHand = plot3(...
        decodedPopulation(:,1), ...
        decodedPopulation(:,2), ...
        fitness(:), ...
        'kp' ...
        );
    hold off;
    title(sprintf('Solution no. (%d)', solutionIndex));
    drawnow;
end