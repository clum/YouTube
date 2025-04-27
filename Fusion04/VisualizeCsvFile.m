%Visualize a list of points in a .csv file
%
%Christopher Lum
%lum@uw.edu

%Version History
%04/25/25: Created

clear
clc
close all

tic

%% User selections
csvFile = './csvExamples/simple2D.csv';                     %2D only
% csvFile = './csvExamples/simple3D.csv';                     %3 simple lines
% csvFile = './csvExamples/sketcher_vr_BoxVaseFlowers.csv';   %table with flowers
% csvFile = './csvExamples/sketcher_vr_Simple.csv';           %random curve

%% Import data
data = readmatrix(csvFile);

[M,N] = size(data);

if(N==2)
    %Augment z dimension
    data = [data zeros(M,1)];
end

%% Visualize
figure
plot3(data(:,1),data(:,2),data(:,3),'bo')
grid on
xlabel('x')
ylabel('y')
zlabel('z')
axis('equal')

toc
disp('DONE!')