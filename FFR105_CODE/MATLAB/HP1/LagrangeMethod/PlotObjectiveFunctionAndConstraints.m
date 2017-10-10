clc;
close all;

x = linspace(-10,10,100);

[x1,x2]=meshgrid(x,x);

fx = 15 + 2*x1 + 3*x2;
fxMax = max(max(fx));
hx = x1.^2 + x1.*x2 + x2.^2 - 21;
lambda = [0 0.1 1/3 1 5 10 100 1000];

figure;
hold on;
alpha(0.5);
xlabel('x1');
ylabel('x2');
zlabel('f(x1,x2) and h(x1,x2)');
surf(x1,x2,fx,'EdgeColor','white','FaceLighting','phong'); %plot surface of objective function
surf(x1,x2,hx,'EdgeColor','none','FaceLighting','phong'); %plot surface of valid domain
view(90,90);

%x10 = [-1 1];
%x20 = [-4 4];
%fx0 = 15 + 2*x10 + 3*x20;
%hx0 = x10.^2 + x10.*x20 + x20.^2 - 21;
%plot3(x10,x20,fx0,'or','markers',12); %plot surface of objective function
%plot3(x10,x20,hx0,'*g','markers',15); %plot surface of objective function
sHx=ezplot('x10.^2 + x10.*x20 + x20.^2 - 21',[-10,10]);
%sFx=ezplot('15 + 2*x10 + 3*x20');
%set(sFx,'LineWidth',5);  %# Sets the line width to 2
set(sHx,'LineWidth',5);  %# Sets the line width to 2
set(sHx,'color','black');
title('function f(x1,x2) = 15 + 2*x1 + 3*x2 (dark grid surface) subject to h(x1,x2) = x1^2 + x1*x2 + x2^2 - 21 (yellow-blue surface) with boundary h(x1,x2)=0 (dark line)');
hold off;

[x1I,x2I,zI] = intersections(fx,hx);

return;
for l=lambda
Lx = fx + l*hx;

x10 = [-1 1];
x20 = [-4 4];
fx0 = 15 + 2*x10 + 3*x20;
hx0 = x10.^2 + x10.*x20 + x20.^2 - 21;
Lx0 = fx0 + l*hx0;

figure;
hold on;
xlabel('x1');
ylabel('x2');
zlabel('L(x1,x2)');
surf(x1,x2,Lx,'EdgeColor','none','FaceLighting','phong'); %plot surface of valid domain
plot3(x10,x20,Lx0,'or'); %plot surface of objective function
sHx=ezplot('x10.^2 + x10.*x20 + x20.^2 - 21');
%sFx=ezplot('15 + 2*x10 + 3*x20');
%set(sFx,'LineWidth',5);  %# Sets the line width to 2
set(sHx,'LineWidth',5);  %# Sets the line width to 2
set(sHx,'color','black');
title(sprintf('Lagrange function L(x1,x2) = 15 + 2*x1 + 3*x2 + %.3f*(x1^2 + x1*x2 + x2^2 - 21)',l));
hold off;
end