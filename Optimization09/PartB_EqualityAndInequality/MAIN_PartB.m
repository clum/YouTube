%Illustrate optimization penalty method with equality and inequality
%constraints
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/02/20: Created
%12/25/23: Moved to YouTube GitHub

clear
clc
close all

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

%Plot the constraints
x1_constraint1 = linspace(-2,10,Nx1);
x2_constraint1 = x1_constraint1 - 8;

x1_constraint2 = linspace(-6,3,Nx1);
x2_constraint2 = -2*x1_constraint2 - 4;

for counter=1:length(x1)
    x = [x1_constraint1(counter);x2_constraint1(counter)];
    f0_constraint1(counter) = cost_function_original(x);
end

for counter=1:length(x1)
    x = [x1_constraint2(counter);x2_constraint2(counter)];
    f0_constraint2(counter) = cost_function_original(x);
end

plot3(x1_constraint1,x2_constraint1,f0_constraint1,'r--','LineWidth',2)
plot3(x1_constraint1,x2_constraint1,zeros(size(x1)),'r--','LineWidth',2)

plot3(x1_constraint2,x2_constraint2,f0_constraint2,'c--','LineWidth',2)
plot3(x1_constraint2,x2_constraint2,zeros(size(x1)),'c--','LineWidth',2)

%Plot the analytically obtained solution (valid only for the equality
%constraint only problem)
x1star = 21/5;
x2star = -19/5;

f0_xstar = cost_function_original([x1star;x2star]);
plot3(x1star, x2star, f0_xstar, 'gx', 'LineWidth', 2, 'MarkerSize', 15)
plot3(x1star, x2star, 0, 'gx', 'LineWidth', 2, 'MarkerSize', 15)

%% Apply Penalty Method (equality constraints only)
x_guess = zeros(2,1);

% alpha_range = linspace(0, 5, 15);
alpha_range = [[0:0.1:0.5] 1 3 5];

%% Apply Penalty Method (equality and inequality constraints)
alpha_range = [[0:0.1:0.5] 1 3 5];

for counter=1:length(alpha_range)
    alpha1 = alpha_range(counter);
    alpha2 = alpha_range(counter);
    
    %Capture the current value of alpha1 and alpha1 in an anonymous function
    anonymousFunctionHandle = ...
        @(x) cost_function_augmented_equality_and_inequality(x,alpha1,alpha2);
    
    %Solve unconstrained optimization problem using fminsearch
    x0 = zeros(2,1);
    [xhatstar,f0] = fminsearch(anonymousFunctionHandle,x0,...
        optimset('TolX',1e-10,'MaxFunEvals',10000,'MaxIter',10000));
    
    %Plot optimal solution for the current value of alpha
    plot3(xhatstar(1), xhatstar(2), 0, 'm+', 'LineWidth', 2, 'MarkerSize', 15)
    title(['\alpha1 = ',num2str(alpha1), ' \alpha2 = ',num2str(alpha2)])
    view([-10 14])
    pause(1)
end
