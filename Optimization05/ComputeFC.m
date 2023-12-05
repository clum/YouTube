function [F] = ComputeFC(X1,X2)

%COMPUTEFC   Computes the cost function, f
%
%   [F] = COMPUTEFC(X1,X2) Evaluates the cost function at the point X1, X2.
%
%
%INPUT:     -X1:    x1 point (this can be a matrix)
%           -X2:    x2 point (this can be a matrix)
%
%OUTPUT:    -F:     cost function at point X1, X2
%
%Created by Christopher Lum
%lum@uw.edu

%Version History
%11/15/13: Created
%10/10/21: Updated

F = 3*X1.^2 + 2*X2.^2 + 20*cos(X2).*cos(X1) + 40;