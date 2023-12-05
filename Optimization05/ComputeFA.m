function [F] = ComputeFA(X1,X2)

%COMPUTEFA   Computes the cost function, f
%
%   [F] = COMPUTEFA(X1,X2) Evaluates the cost function at the point X1, X2.
%
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

F = 2 + X1 + X1.^2./2 + 2*X2 + X1.*X2 + X2.^2;