%Demonstrate using varargin in Matlab.
%
%This script accompanies the YouTube video at TBD.
%
%Christopher Lum
%lum@uw.edu

%Version History
%06/16/24: Created

clear
clc
close all

%% PlotShape_VersionA
figure;
hold on

%circle
shape_circle    = 'circle';
x_circle        = 10;
y_circle        = 5;
size_circle     = 3;
[A_circle] = PlotShape_VersionA(shape_circle,x_circle,y_circle,size_circle);

%square
shape_square = 'square';
x_square        = -1;
y_square        = -2;
size_square     = 5;
[A_square] = PlotShape_VersionA(shape_square,x_square,y_square,size_square);

%triangle
shape_triangle = 'triangle';
x_triangle        = 1;
y_triangle        = 2;
size_triangle     = 6;
[A_triangle] = PlotShape_VersionA(shape_triangle,x_triangle,y_triangle,size_triangle);

axis equal

%% PlotShape_VersionB
figure
hold on

color_circle = [1 0 0];
lineWidth_circle = 3;
[A_circle] = PlotShape_VersionB(shape_circle,x_circle,y_circle,size_circle,color_circle,lineWidth_circle);

color_square = [0 1 0];
lineWidth_circle = 5;
[A_square] = PlotShape_VersionB(shape_square,x_square,y_square,size_square,color_square,lineWidth_circle);

color_triangle = [0.5 0.2 0.1];
lineWidth_triangle = 8;
[A_triangle] = PlotShape_VersionB(shape_triangle,x_triangle,y_triangle,size_triangle,color_triangle,lineWidth_triangle);

%% PlotShape_VersionC
figure
hold on

[A_circle] = PlotShape_VersionC(shape_circle,x_circle,y_circle);

[A_square] = PlotShape_VersionC(shape_square,x_square,y_square,size_square);

[A_triangle] = PlotShape_VersionB(shape_triangle,x_triangle,y_triangle,size_triangle,color_triangle,lineWidth_triangle);

disp('DONE!')