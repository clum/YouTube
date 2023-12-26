function [f0] = cost_function(x, alpha)

x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);
x5 = x(5);
x6 = x(6);

alpha1 = alpha(1);
alpha2 = alpha(2);
alpha3 = alpha(3);
alpha4 = alpha(4);
alpha5 = alpha(5);

%Equality constraints
f1 = x1*x5 - 3;
f2 = x1 + x2 + 3*x4;
f3 = x2^2/x6 + 4;

%Inequality constraints
f4 = x1 + cos(x2)*x5;
f5 = x5 + x1 + x3 + 7*x6;

f0 = alpha1*f1^2 + alpha2*f2^2 + alpha3*f3^2 +...
    alpha4*max(0,f4)^2 + alpha5*max(0,f5)^2;