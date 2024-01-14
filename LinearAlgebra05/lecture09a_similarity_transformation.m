%Demonstrate properties of similar matrices
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/27/21: Created
%11/28/21: Minor update
%01/13/24: Moved to YouTube

clear
clc
close all

tic

%% User selections
matrixSelection = 'non-defective';
% matrixSelection = 'defective';

%% Analysis
switch matrixSelection
    case 'non-defective'
        %Non-defective matrix
        A = [3 4 2 1;
            0 1 -1 -1;
            -1 -1 3 0;
            1 1 -1 2];
        
    case 'defective'        
        %Defective matrix
        A = [5 4 2 1;
            0 1 -1 -1;
            -1 -1 3 0;
            1 1 -1 2];
        
    otherwise
        error('Unsupported matrixSelection')
end

%Chose a similarity transformation matrix
T = [1 2/7 4 -3;
    2 1 2 3/4;
    -2 2/3 3/4 2;
    -5/6 -5 8 6];

%Ensure that T is invertible
det(T)

%Perform similarity transformation
Atilde = inv(T)*A*T

disp('Property 1:  Same determinant')
det(A)
det(Atilde)

disp('Property 2:  Same eigenvalues')
[V,D]           = eig(A);
[Vtilde,Dtilde] = eig(Atilde);

lambda      = diag(D)
lambdaTilde = diag(Dtilde)   %note that order may be different

disp('Property 3:  Similar eigenvectors')
%Compute eigenvectors of Atilde using inv(T)*eigenvectors(A)
eigVecTilde = inv(T)*V;

tol = 10e-10;
AreMatricesSame(Atilde*eigVecTilde(:,1), lambda(1)*eigVecTilde(:,1),tol)
AreMatricesSame(Atilde*eigVecTilde(:,2), lambda(2)*eigVecTilde(:,2),tol)
AreMatricesSame(Atilde*eigVecTilde(:,3), lambda(3)*eigVecTilde(:,3),tol)
AreMatricesSame(Atilde*eigVecTilde(:,4), lambda(4)*eigVecTilde(:,4),tol)

disp('Property 4: Same trace')
trace(A)
trace(Atilde)

disp('Property 5: Same rank')
rank(A)
rank(Atilde)

disp('Diagonalization')
M = V;
diagonal = inv(M)*A*M

AreMatricesSame(diagonal,D,tol)

toc
disp('DONE!')