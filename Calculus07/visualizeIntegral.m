%Visualization for double integrals
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/07/22: Created

clear
clc
close all
tic

x = linspace(-2,2,10);
y = linspace(-1,3,10);

[X,Y] = meshgrid(x,y);

F = X+2*Y;

figure
hold on
surf(X,Y,F)
shading interp

%draw the domain
domain_x = [-1 1 1 -1 -1];
domain_y = [0 0 2 2 0];
plot3(domain_x,domain_y,zeros(size(domain_x)),'r--','LineWidth',2)


xlabel('x')
ylabel('y')
zlabel('f(x,y)=x+2y')
grid on

toc
disp('DONE!')