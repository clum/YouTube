function [p] = AnalyticalSolution(t,x)

p = (1/((2*pi*t)^0.5)).*exp(-x.^2./(2*t));