function [f0_hat] = cost_function_augmented_equality_and_inequality(x, alpha1, alpha2)

H = [1 1; 1 2];
g = [1;2];
r = 75;

f0 = 0.5*x'*H*x + g'*x + r;
f1 = x(2) - x(1) + 8;
f2 = 2*x(1) + x(2) + 4;

f0_hat = f0 + alpha1*f1^2 + alpha2*max(0,f2)^2;