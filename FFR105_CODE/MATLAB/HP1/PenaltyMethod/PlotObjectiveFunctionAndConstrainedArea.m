function PlotObjectiveFunctionAndConstrainedArea()
    
    x1 = linspace(-5,5,1000); %1000 steps of absicsa 1 in range <-5, 5>
    x2 = linspace(-5,5,1000); %1000 steps of abscisa 2 in rande <-5, 5>
    [x1, x2] = meshgrid(x1,x2); %wireframe of abscisas 1 and 2
    fx = (x1 - 1).^2 + 2*(x2 - 2).^2; % objective function for values of x1 and x2
    fxMax = max(max(fx)); % maximum value of objective function for values of x1 and x2
    gx = fxMax*double(x1.^2 + x2.^2 -1 <= 0); %domain of constrained area
    
    surf(x1,x2,fx,'EdgeColor','none','LineStyle','none','FaceLighting','phong'); %plot surface of objective function
    surf(x1,x2,gx,'EdgeColor','none','LineStyle','none','FaceLighting','phong'); %plot surface of valid domain
    
end