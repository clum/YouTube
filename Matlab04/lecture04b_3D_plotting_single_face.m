%Christopher Lum
%lum@u.washington.edu.edu
%
%Investigate how Matlab plots a single face

%Version History    10/20/14: Created

clear
clc
close all

%Define the mesh
x1 = [-1 1];
x2 = [-1 1];

%Create 2D matrices of the x1 and x2 vectors
[X1,X2] = meshgrid(x1,x2);

%Create function values at these locations
Z = [1 3;
     0.5 0.25];

 %Plot the surface
figure
hold on
surf(X1,X2,Z)

xlabel('x_1')
ylabel('x_2')
zlabel('z')
grid on
view([35 30])       %change the view of the plot (can also use button on plot window)
