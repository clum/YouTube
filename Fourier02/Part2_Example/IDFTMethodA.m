function [f] = IDFTMethodA(fhat)

%Manually compute the IDFT
N = length(fhat);

wN = exp(2*pi*i/N);

for n=0:N-1
    fn = 0;
    for k=0:N-1
        fn = fn + fhat(k+1)*wN^(n*k);
    end
    
    f(n+1,1) = fn/N;
end
