function [F] = ComputeFB(X1,X2)

%COMPUTEFB   Computes the cost function, f
%
%   [F] = COMPUTEFB(X1,X2) Evaluates the cost function at the point X1, X2.
%
%INPUT:     -X1:    x1 point (this can be a matrix)
%           -X2:    x2 point (this can be a matrix)
%
%OUTPUT:    -F:     cost function at point X1, X2
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/06/21: Created
%10/07/21: Updated

F = 101 + X1 + X1.^2./2 + 200*X2 + X1.*X2 + 100*X2.^2;