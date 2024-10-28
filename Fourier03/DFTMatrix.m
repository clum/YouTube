function [F] = DFTMatrix(N)

wN = exp(2*pi*i/N);
F = zeros(N,N);
for k=0:N-1
    for n=0:N-1
        F(k+1,n+1) = wN^(-n*k);
    end
end