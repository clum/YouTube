%Christopher Lum
%lum@u.washington.edu.edu
%
%This is skeleton code to show how to plot 3D functions using surf
%
%We assume that we have a function of two variables of the form
%
%   z = f(x1,x2)
%
%   where f(x1,x2) = cos(x1)*x2

%Version History    11/11/09: Created
%                   11/17/11: Updated for 2011
%                   10/12/13: Updated for 2013

clear
clc
close all

%Define the range of x1 values
x1_start    = -pi;      %starting value of the x1 vector
x1_end      = pi;       %ending value of the x1 vector
Nx1         = 50;       %number of points in the x1 vector
x1          = linspace(x1_start, x1_end, Nx1);

%Define the range of x2 values
x2_start    = -10;      %starting value of the x2 vector
x2_end      = 16;       %ending value of the x2 vector
Nx2         = 85;       %number of points in the x2 vector
x2          = linspace(x2_start, x2_end, Nx2);

%Create 2D matrices of the x1 and x2 vectors
[X1,X2] = meshgrid(x1,x2);

%Evaluate the function at these points
Z = cos(X1).*X2;

%Define a point we are interested in plotting
x1o = 0;
x2o = 3;
zo  = cos(x1o)*x2o;

%Plot the surface
figure
hold on
surf(X1,X2,Z)

%Plot the point
plot3(x1o, x2o, zo, 'ro', 'MarkerSize', 15, 'LineWidth', 2)

%Make the plot nice
xlabel('x_1')
ylabel('x_2')
zlabel('z=f(x_1,x_2)')
title('z=f(x_1,x_2)')
legend('f(x_1,x_2)','f(x_{1o},x_{2o})')
grid on
shading interp      %make the 3D surface smooth
view([35 30])       %change the view of the plot (can also use button on plot window)