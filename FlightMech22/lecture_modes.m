%Christopher Lum
%lum@uw.edu
%
%Look at pole locations

%Version History
%02/07/22: Created

clear
clc
close all

%Load the full linear model
temp = load('linear_model_straight_level.mat');
A = temp.A;
B = temp.B;

disp('A matrix')
disp(A)

disp('B matrix')
disp(B)

lambda = eig(A);

figure
plot(real(lambda),imag(lambda),'x','MarkerSize',25,'LineWidth',5)
grid on
xlabel('Real')
ylabel('Imaginary')
axis('equal')

disp('FINISHED')
