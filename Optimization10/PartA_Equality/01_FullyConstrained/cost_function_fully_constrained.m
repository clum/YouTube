function [f0] = cost_function_fully_constrained(x, alpha1, alpha2, alpha3)

x1 = x(1);
x2 = x(2);
x3 = x(3);

f1 = x1*x2 - 3;
f2 = x1 + x2 + 3*x3;
f3 = x1^2/x3 + 4;

f0 = alpha1*f1^2 + alpha2*f2^2 + alpha3*f3^2;