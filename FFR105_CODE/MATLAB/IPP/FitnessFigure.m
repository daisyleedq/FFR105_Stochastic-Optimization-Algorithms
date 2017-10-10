function [fitnessFigHand,bestPlotHand,textHand]=FitnessFigure(nGenerations)
fitnessFigHand = figure;
hold on;
set(fitnessFigHand, 'Position', [50,50,500,200]);
set(fitnessFigHand, 'DoubleBuffer', 'on');
axis([1 nGenerations 0 3]);
bestPlotHand = plot(1:nGenerations, zeros(1, nGenerations));
textHand = text(30,2.6,sprintf('best: %4.3f', 0.0));
hold off;
drawnow;    
end
