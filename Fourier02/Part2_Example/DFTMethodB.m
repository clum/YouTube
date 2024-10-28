function [fhat] = DFTMethodB(f)

%Manually compute the DFT
N = length(f);

wN = exp(2*pi*i/N);

A = zeros(N,N);
for k=0:N-1
    for n=0:N-1
        A(k+1,n+1) = wN^(-n*k);
    end    
end

fhat = A*f;