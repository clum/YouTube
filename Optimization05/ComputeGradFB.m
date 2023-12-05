function [gradX] = ComputeGradFB(x)

x1 = x(1);
x2 = x(2);
gradX = [1+x1+x2;
    x1+200*(1+x2)];