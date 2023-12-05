function [gradF] = ComputeGradFA(x)

%COMPUTEGRADFA   Computes the gradient of the cost function
%
%   [GRADF] = COMPUTEGRADFA(X1,X2) Computes the gradient of the cost
%   function at the point X1, X2.
%
%
%INPUT:     -x:     point (2x1 vector)
%
%OUTPUT:    -GradF: gradient of the cost function at point x1, x2
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/06/21: Created
%10/10/21: Updated

x1 = x(1);
x2 = x(2);
gradF = [1+x1+x2;
    2+x1+2*x2];