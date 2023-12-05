%Visualize the linear programming example.
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/06/21: Created

clear
clc
close all

%% Visualize problem
constraintHeight = -4*10^4;
x1 = linspace(-10,50,20);
x2 = linspace(-10,70,20);

[X1,X2] = meshgrid(x1,x2);

f = -200*X1 - 400*X2;
% f = -320*X1 - 280*X2;

figure
hold on

surfc(X1,X2,f)

%plot the constraints
f1_x1 = x1;
f1_x2 = -(3/2)*(-40 + x1);

f2_x1 = x1;
f2_x2 = 50 - x1;

plot3(f1_x1,f1_x2,constraintHeight*ones(size(x1)),'r','LineWidth',4)
plot3(f2_x1,f2_x2,constraintHeight*ones(size(x1)),'b','LineWidth',4)
plot3(zeros(size(x2)),x2,constraintHeight*ones(size(x2)),'g','LineWidth',4)
plot3(x1,zeros(size(x1)),constraintHeight*ones(size(x1)),'k','LineWidth',4)

xlabel('x_1')
ylabel('x_2')
zlabel('f')
shading interp
grid on

disp('DONE!')