function [f0_hat] = cost_function_augmented_equality_only(x, alpha)

H = [1 1; 1 2];
g = [1;2];
r = 75;

f0 = 0.5*x'*H*x + g'*x + r;
f1 = x(2) - x(1) + 8;

f0_hat = f0 + alpha*f1^2;