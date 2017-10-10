clc;
x = linspace(-.5,1.5,100);

[x1,x2]=meshgrid(x,x);

fx = 4*x1.^2 - x1.*x2 + 4*x2.^2 - 6*x2;
fxMax = max(max(fx));
corners = [0,0;0,1;1,1;0,0];
x1Corners = corners(:,1);
x2Corners = corners(:,2);
fxCorners = 4*x1Corners.^2 - x1Corners.*x2Corners + 4*x2Corners.^2 - 6*x2Corners;

x1m = 2/21;
x2m = 16/21;
fxm = 4*x1m.^2 - x1m.*x2m + 4*x2m.^2 - 6*x2m;

figure(1);
hold on;
surf(x1,x2,fx,'EdgeColor','none','FaceLighting','phong'); %plot surface of objective function
plot3(x1Corners,x2Corners,fxCorners,'o-r'); %plot surface of valid domain
plot3(x1m,x2m,fxm,'o-g'); %plot surface of valid domain

