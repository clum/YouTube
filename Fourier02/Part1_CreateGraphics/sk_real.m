function [y] = sk_real(x,N,DeltaX,k)

y = cos(2*pi*k*x./(N*DeltaX));