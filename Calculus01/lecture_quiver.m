%Christopher Lum
%lum@uw.edu
%
%Illustrate how to use quiver

%Version History    
%09/06/13: Created
%10/22/18: Minor update for documentation.

clear
clc
close all

%define the points where we would like to draw the vectors
x = linspace(-5, 5, 15);
y = linspace(-5, 5, 15);

%Meshgrid these coordinates
[X, Y] = meshgrid(x,y);

%Define the function
U = 50*cos(X);
V = X.*Y.^2;

%Plot the vector field using 'quiver'
figure
quiver(X, Y, U, V)
xlabel('x')
ylabel('y')
title('Using ''quiver'' command')
grid on

disp('DONE!')