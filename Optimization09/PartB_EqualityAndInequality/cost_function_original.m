function [f0] = cost_function_original(x)

H = [1 1; 1 2];
g = [1;2];
r = 75;

f0 = 0.5*x'*H*x + g'*x + r;