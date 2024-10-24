%Christopher Lum
%lum@uw.edu
%
%Illustrate how to use quiver3

%Version History    
%09/06/13: Created
%10/22/18: Minor update for documentation.

clear
clc
close all

%define the points where we would like to draw the vectors
x = linspace(-2, 2, 5);
y = linspace(-2, 2, 7);
z = linspace(-2, 2, 9);

[X, Y, Z] = ndgrid(x,y,z);

%Define the function
alpha = 2;
beta = 1;
gamma = -4;

U = Z*beta - Y*gamma;
V = -Z*alpha + X*gamma;
W = Y*alpha - X*beta;


%Plot the vector field using 'quiver3'
figure
quiver3(X, Y, Z, U, V, W)
xlabel('x')
ylabel('y')
ylabel('z')
title('Using ''quiver3'' command')
grid on

disp('DONE!')