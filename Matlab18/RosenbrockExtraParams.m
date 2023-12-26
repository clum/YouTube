function [f] = RosenbrockExtraParams(x,a)

f = 100*(x(2) - x(1)^2)^2 + (a - x(1))^2;