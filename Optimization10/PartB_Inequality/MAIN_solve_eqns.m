%Christopher Lum
%lum@uw.edu
%
%Illustrate optimization penalty method to solve multiple simultaneous
%equations with equality and inequality constraints.

%Version History
%05/02/20: Created

clear
clc
close all

tic

initialization = 1;     %0 = start from scratch, 1 = load previous value

if(initialization==0)
    x_guess = zeros(6,1);       %BAD: leads to local minimum that is wrong
%     x_guess = [1 1 -1]';         %GOOD:
    
else
    %load previous soluation
    temp = load('xstar.mat');
    x_guess = temp.xstar;
end

disp('Starting guess')
x_guess

alpha = ones(5,1);

[xstar,f0,exitFlag,output] = fminsearch(@(x) cost_function(x,alpha),x_guess,...
    optimset('TolX',1e-10,'MaxFunEvals',10000,'MaxIter',10000));

xstar
f0

save('xstar.mat','xstar')

%% Check that we satisfy constraints
x1 = xstar(1);
x2 = xstar(2);
x3 = xstar(3);
x4 = xstar(4);
x5 = xstar(5);
x6 = xstar(6);

%Equality constraints (should be 0)
f1 = x1*x5 - 3
f2 = x1 + x2 + 3*x4
f3 = x2^2/x6 + 4

%Inequality constraints (should be less than 0)
f4 = x1 + cos(x2)*x5
f5 = x5 + x1 + x3 + 7*x6

toc
disp('DONE!')