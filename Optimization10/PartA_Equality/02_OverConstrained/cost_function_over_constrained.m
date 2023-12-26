function [f0] = cost_function_over_constrained(x, beta)

x1 = x(1);
x2 = x(2);
x3 = x(3);

f1 = x1*x2 - 3;
f2 = x1 + x2 + 3*x3;
f3 = x1^2/x3 + 4;
f4 = x1 - x2;

f0 = (1-beta)*f1^2 + f2^2 + f3^2 + beta*f4^2;