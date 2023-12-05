function [F] = ComputeFC_r_alpha(X_K,D_K,alpha)

%COMPUTEFC_R_ALPHA   Computes the 1D cost function, f(r(alpha))
%
%   [F] = COMPUTEFC_R_ALPHA(X_K,D_K,ALPHA) Evaluates the 1D cost function
%   at the value of ALPHA
%
%
%INPUT:     -
%
%OUTPUT:    -F:     cost function at point X1, X2
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/10/21: Created

x1k = X_K(1);
x2k = X_K(2);

d1k = D_K(1);
d2k = D_K(2);

F = 40 + 3*(x1k + d1k*alpha).^2 + ...
    2*(x2k + d2k*alpha).^2 + ...
    20*cos(x1k + d1k*alpha).*cos(x2k + d2k*alpha);