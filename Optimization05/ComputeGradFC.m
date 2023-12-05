function [gradF] = ComputeGradFC(x)

%COMPUTEGRADFC   Computes the gradient of the cost function
%
%   [GRADF] = COMPUTEGRADFC(X1,X2) Computes the gradient of the cost
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
%11/15/13: Created
%10/10/21: Updated

x1 = x(1);
x2 = x(2);
gradF = [6*x1 - 20*cos(x2)*sin(x1);
    4*x2 - 20*cos(x1)*sin(x2)];