function [T] = TMatrix(N)

T = zeros(N,N);
for k=0:N-1
    row = k+1;
    if(row<=N/2)
        %even indices (top half of matrix)
        idx = row*2-1;
    else
        %odd indices (bottom half of matrix)
        idx = (row-N/2)*2;
    end

    T(row,idx) = 1;
end