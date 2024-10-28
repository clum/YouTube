function [fhat] = DFTMethodA(f)

%Manually compute the DFT
N = length(f);

wN = exp(2*pi*i/N);

for k=0:N-1
    fhatk = 0;
    for n=0:N-1
        fhatk = fhatk + f(n+1)*wN^(-n*k);
    end
    
    fhat(k+1,1) = fhatk;
end