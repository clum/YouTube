%Christopher Lum
%lum@uw.edu
%
%Introduce Gaussian elimination

%Version History:   10/03/16: Created

clear
clc
close all

%Define the matrix A and b
A = [10 100 1000;
    15 225 3375
    20 400 8000];

b = [840;
    2985;
    7280];

%Create augmented matrix
Atilde = [A b]

%Row reduce this
rref(Atilde)