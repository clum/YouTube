%Christopher Lum
%lum@uw.edu
%
%Illustrate matrix operations in Matlab

%Version History:   10/03/16

clear
clc
close all

%Define the matrix A and B
A = [1 2; 3 4];
B = [5 6; 7 8];

%Perform matrix multiplication (note that we use the '*' operator)
disp('Matrix multiplication')
A*B
B*A

%Perform matrix power (note that we use the '^' operator)
disp('Matrix powers')
A^2
A^3

%Perform elementwise multiplication and powers (note that we use the '.*'
%and '.^' operators
%operator)
disp('Elementwise operations')
A.*A
A.^2

%Demonstrate transpose
disp('Transpose')
A'

%Create a diagonal matrix
disp('Diagonal matrix')
C = diag([1 2 3 4])