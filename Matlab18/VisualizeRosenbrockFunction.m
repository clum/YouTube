%Visualize the Rosenbrock function
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/02/20: Created
%12/25/23: Moved to YouTube GitHub

clear
clc
close all

tic

a = 2;

%We know where the optimal location is
x1Star = a;
x2Star = a^2;

%Visualize the function around this optimal
buffer = 0.5;

x1Min = x1Star - buffer;
x1Max = x1Star + buffer;
Nx1 = 100;

x2Min = x2Star - buffer;
x2Max = x2Star + buffer;
Nx2 = 75;

x1 = linspace(x1Min,x1Max,Nx1);
x2 = linspace(x2Min,x2Max,Nx2);

[X1,X2] = meshgrid(x1,x2);

F = 100*(X2 - X1.^2).^2 + (a - X1).^2;

fxStar = 100*(x2Star - x1Star^2)^2 + (a - x1Star)^2;

%Plot the function and minimum
figure
hold on
surf(X1,X2,F)
plot3(x1Star,x2Star,fxStar,'gx','MarkerSize', 12, 'LineWidth', 2)
shading interp
grid on
xlabel('x_1')
ylabel('x_2')
zlabel('f(x_1,x_2)')
view([140 40])

toc
disp('DONE!')