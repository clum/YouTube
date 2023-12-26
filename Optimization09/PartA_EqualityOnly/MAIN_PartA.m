%Illustrate optimization penalty method with equality constraints only
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/14/07: Created
%11/17/11: Updated for 2011
%05/05/15: Updated for 2015
%05/01/17: Updated for 2017
%02/21/19: Updated for 2019
%05/02/20: Updated for 2020, major revisions
%12/25/23: Moved to YouTube GitHub

clear
clc
close all

%% Plot the solution to the constrained problem that we obtained analytically
%Plot cost function
Nx1 = 50;
Nx2 = 50;
x1 = linspace(-10, 10, Nx1);
x2 = linspace(-10, 10, Nx2);
[X1, X2] = meshgrid(x1, x2);

for m=1:Nx1
    for n=1:Nx2
        x = [X1(m,n);X2(m,n)];
        F0(m,n) = cost_function_original(x);
    end
end

figure
hold on
surf(X1,X2,F0)
shading interp
xlabel('x_1')
ylabel('x_2')
zlabel('f_0(x)')
grid on

%Plot the constraint
x1_constraint = linspace(-2,10,Nx1);
x2_constraint = x1_constraint - 8;

for counter=1:length(x1)
    x = [x1_constraint(counter);x2_constraint(counter)];
    f0_constraint(counter) = cost_function_original(x);
end

plot3(x1_constraint,x2_constraint,f0_constraint,'r--','LineWidth',2)
plot3(x1_constraint,x2_constraint,zeros(size(x1)),'r--','LineWidth',2)

%Plot the analytically obtained solution
x1star = 21/5;
x2star = -19/5;

f0_xstar = cost_function_original([x1star;x2star]);
plot3(x1star, x2star, f0_xstar, 'gx', 'LineWidth', 2, 'MarkerSize', 15)
plot3(x1star, x2star, 0, 'gx', 'LineWidth', 2, 'MarkerSize', 15)

%% Apply Penalty Method (equality constraints only)
alpha_range = [[0:0.1:0.5] 1 3 5];

for counter=1:length(alpha_range)
    alpha = alpha_range(counter);
    
    %Capture the current value of alpha in an anonymous function
    anonymousFunctionHandle = ...
        @(x) cost_function_augmented_equality_only(x,alpha);
    
    %Solve unconstrained optimization problem using fminsearch
    x0 = zeros(2,1);
    [xhatstar,f0] = fminsearch(anonymousFunctionHandle,x0,...
        optimset('TolX',1e-10,'MaxFunEvals',10000,'MaxIter',10000));
    
    %Plot optimal solution for the current value of alpha
    plot3(xhatstar(1), xhatstar(2), 0, 'm+', 'LineWidth', 2, 'MarkerSize', 15)
    title(['\alpha = ',num2str(alpha)])
    view([-10 14])
    pause(1)
end
