%Christopher Lum
%lum@uw.edu
%
%Illustrate how to use surf and surfc.

%Version History    
%09/06/13: Created
%10/22/18: Minor update for documentation.

clear
clc
close all

%define x and y vectors
x = linspace(1, 3, 100);
y = linspace(3, 6, 100);

%Meshgrid these coordinates
[X, Y] = meshgrid(x,y);

%Define the function
P = 3*X.^2 + Y.^2;

%Plot the surface using 'surf'
figure
surf(X, Y, P)
shading interp
xlabel('x')
ylabel('y')
zlabel('p(x,y)')
title('Using ''surf'' command')
grid on

%We can also use the 'surfc' command
figure
surfc(X, Y, P)
shading interp
xlabel('x')
ylabel('y')
zlabel('p(x,y)')
title('Using ''surf'' command')
grid on

disp('DONE!')