%Explore computing partial derivatives numerically
%
%Christopher Lum
%lum@uw.edu

%Version History:
%05/15/20: Created
%01/07/24: Moved to YouTube repo

clear
clc
close all

tic

x1 = linspace(0,2*pi,100);
x2 = linspace(0,2*pi,100);

[X1,X2] = meshgrid(x1,x2);

f1 = X1 + sin(2*X2);
f2 = X2 + sin(2*X1);

figure
subplot(1,2,1)
surf(X1,X2,f1)
shading interp
xlabel('x_1')
ylabel('x_2')
zlabel('f_1')
grid on

subplot(1,2,2)
surf(X1,X2,f2)
shading interp
xlabel('x_1')
ylabel('x_2')
zlabel('f_2')
grid on

toc
disp('DONE!')