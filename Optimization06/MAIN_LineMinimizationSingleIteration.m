%Christopher Lum
%lum@uw.edu
%
%Generate plots and example of line search algorithm

%Version History    
%11/15/13: Created
%12/03/18: Updated for 2018
%10/09/21: Updated for 2021
%10/16/21: Adding contour
%12/04/23: Moved to YouTube repo

clear
clc
close all

%% Add paths
costFunctionPath = [ReturnPathStringNLevelsUp(1),'\Optimization05'];
addpath(costFunctionPath);
disp(['Added path: ',costFunctionPath])

%% Analysis
%Visualize the cost function
x1min = -5;
x1max = 5;
Nx1 = 50;

x2min = -5;
x2max = 5;
Nx2 = 50;

x1 = linspace(x1min,x1max,Nx1);
x2 = linspace(x2min,x2max,Nx2);

[X1,X2] = meshgrid(x1,x2);

FC = ComputeFC(X1,X2);

figh_total = figure;
set(figh_total,'defaultLegendAutoUpdate','off');
hold on
surf(X1,X2,FC)
shading interp

figh_totalContour = figure;
set(figh_totalContour,'defaultLegendAutoUpdate','off');
hold on
contour(X1,X2,FC,15)

%Define the point that we are interested in
x_k = [-4;3];
fC_x_k = ComputeFC(x_k(1), x_k(2));

figure(figh_total)
plot3(x_k(1), x_k(2), 0, 'go', 'LineWidth', 2, 'MarkerSize', 14)
plot3(x_k(1), x_k(2), fC_x_k, 'mo', 'LineWidth', 2, 'MarkerSize', 14)
plot3([x_k(1) x_k(1)], [x_k(2) x_k(2)], [0 fC_x_k], 'b--', 'LineWidth', 2, 'MarkerSize', 14)

figure(figh_totalContour)
plot3(x_k(1), x_k(2), 0, 'go', 'LineWidth', 2, 'MarkerSize', 14)

%Compute the gradient at this point and take the negative gradient to be
%the descent direction
gradFC_x_k = ComputeGradFC(x_k);
d_k = -gradFC_x_k*(1/norm(gradFC_x_k));

%Show the descent direction
ArrowParams(1,1) = 1;
ArrowParams(2,1) = 1;
ArrowParams(3,1) = 0;
ArrowParams(4,1) = 0;
ArrowParams(5,1) = 0.25;
ArrowParams(6,1) = 2;

figure(figh_total)
DrawArrow(x_k(1), x_k(2), d_k(1), d_k(2), ArrowParams)

figure(figh_totalContour)
DrawArrow(x_k(1), x_k(2), d_k(1), d_k(2), ArrowParams)

%Decorate the plots
figure(figh_total)
grid on
xlabel('x_1')
ylabel('x_2')
zlabel('f_C(x_1,x_2)')
legend('f_C(x_1,x_2)',...
    'x_k',...
    'f_C(x_k)',....
    '-',...
    'd_k')

figure(figh_totalContour)
grid on
xlabel('x_1')
ylabel('x_2')
legend('f_C(x_1,x_2)',...
    'x_k',...
    'd_k')

%% Line minimization sub-problem
%Compute r(alpha)
alpha = linspace(0, 10, 250);

ralpha1 = x_k(1) + alpha*d_k(1);
ralpha2 = x_k(2) + alpha*d_k(2);

%Compute fralpha
fC_r_alpha = ComputeFC(ralpha1, ralpha2);

%Find the minimum
fralpha_min = min(fC_r_alpha);
min_index = find(fC_r_alpha==fralpha_min);
alpha_k = alpha(min_index);

figh_alpha = figure;
hold on
plot(alpha, fC_r_alpha, 'LineWidth', 2)
plot(alpha_k, fralpha_min, 'ro', 'LineWidth', 2, 'MarkerSize', 13)
xlabel('\alpha')
ylabel('f_C(r(\alpha))')
legend('f_C(r(\alpha))',...
    ['\alpha_k = ',num2str(alpha_k)])
grid on

%Compute xk_plus_1
x_k_plus_1  = x_k + alpha_k*d_k;

%How does this look on the figure
figure(figh_total)
plot3(ralpha1, ralpha2, fC_r_alpha, 'm-', 'LineWidth', 2)  %draw on cost function
plot3(ralpha1, ralpha2, zeros(size(ralpha1)), 'g--', 'LineWidth', 2)
plot3(x_k_plus_1(1), x_k_plus_1(2), 0, 'ro', 'LineWidth', 2, 'MarkerSize', 13)
plot3(x_k_plus_1(1), x_k_plus_1(2), ComputeFC(x_k_plus_1(1), x_k_plus_1(2)), 'ro', 'LineWidth', 2, 'MarkerSize', 13)
plot3([x_k_plus_1(1) x_k_plus_1(1)], [x_k_plus_1(2) x_k_plus_1(2)], [0 ComputeFC(x_k_plus_1(1), x_k_plus_1(2))], 'r--', 'LineWidth', 2)

figure(figh_totalContour)
plot(ralpha1, ralpha2, 'g--', 'LineWidth', 2)
plot(x_k_plus_1(1), x_k_plus_1(2), 'ro', 'LineWidth', 2, 'MarkerSize', 13)

%% Cleanup
%Remove the path
rmpath(costFunctionPath);
disp(['Removed path: ',costFunctionPath])
disp('DONE!')