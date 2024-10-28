function [fhat] = DFTMethodB(f)

%Manually compute the DFT
N = length(f);

F = DFTMatrix(N);

fhat = F*f;