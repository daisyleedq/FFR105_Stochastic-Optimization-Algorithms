function PlotIterations(polynomialCoefficients, iterationValues)

minIterationValueAbscisa = min(iterationValues);
maxIterationValueAbscisa = max(iterationValues);

startLinePointAbscisa = minIterationValueAbscisa-abs(minIterationValueAbscisa*0.1);
endLinePointAbscisa = maxIterationValueAbscisa+abs(maxIterationValueAbscisa*0.1);

minIterationValueOrdinata = Polynomial(minIterationValueAbscisa,polynomialCoefficients);
maxIterationValueOrdinata = Polynomial(maxIterationValueAbscisa,polynomialCoefficients);

nPointsLine = 1000;

linePolynomialAbscisa = linspace( ...
    startLinePointAbscisa,...
    endLinePointAbscisa,...
    nPointsLine ...
    );

linePolynomialOrdinata = zeros(nPointsLine,1);

for i=1:nPointsLine
    x = linePolynomialAbscisa(i);
    y = Polynomial(x,polynomialCoefficients);
    linePolynomialOrdinata(i) = y;
end

numIterationValues = size(iterationValues,1);
iterationValuesOrdinata = zeros(numIterationValues,1);

for i=1:numIterationValues
    x = iterationValues(i);
    y = Polynomial(x,polynomialCoefficients);
    iterationValuesOrdinata(i) = y;
end

plot(...
    linePolynomialAbscisa,linePolynomialOrdinata,'b-', ...
    iterationValues,iterationValuesOrdinata,'ko' ...
    );

plotMinLimitAbscisa = minIterationValueAbscisa-abs(minIterationValueAbscisa*0.2);
plotMaxLimitAbscisa = maxIterationValueAbscisa+abs(maxIterationValueAbscisa*0.2);
plotMinLimitOrdinata =  minIterationValueOrdinata-abs(minIterationValueOrdinata*0.05);
plotMaxLimitOrdinata = maxIterationValueOrdinata+abs(maxIterationValueOrdinata*0.15);

axis([...
    plotMinLimitAbscisa ...
    plotMaxLimitAbscisa ...
    plotMinLimitOrdinata ...
    plotMaxLimitOrdinata ...
    ]);

end