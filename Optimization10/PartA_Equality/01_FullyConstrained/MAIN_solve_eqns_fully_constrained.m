%Illustrate optimization penalty method to solve multiple simultaneous
%equations with equality constraints.
%
%Investigte fully constrained situation
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/02/20: Created
%05/05/20: Updated
%12/25/23: Moved to YouTube GitHub.  Fixed script.

clear
clc
close all

tic

initialization = 0;     %0 = start from scratch, 1 = load previous value

if(initialization==0)
%     x_guess = zeros(3,1);       %BAD: leads to local minimum that is wrong
    x_guess = [1 1 -1]';         %GOOD: leads to correct minimum
    
else
    %load previous soluation
    temp = load('xstar.mat');
    x_guess = temp.xstar;
end

disp('Starting guess')
x_guess

alpha1 = 10;
alpha2 = 10;
alpha3 = 10;

[xstar,f0,exitFlag,output] = fminsearch(@(x) cost_function_fully_constrained(x,alpha1, alpha2, alpha3),x_guess,...
    optimset('TolX',1e-10,'MaxFunEvals',10000,'MaxIter',10000));

xstar
f0

save('xstar.mat','xstar')

toc
disp('DONE!')