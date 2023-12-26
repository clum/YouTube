function [f] = RosenbrockSimple(x)

f = 100*(x(2) - x(1)^2)^2 + (2 - x(1))^2;