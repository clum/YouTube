%Generate graphics for lecture06f_fast_fourier_transform
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/06/23: Created

clear
clc
close all

%% Pathing
cwd = pwd;
cd('..')
addpath(pwd)
disp(['Added path ',pwd])
cd(cwd)

%% User selections
% N = 2^3;    %8
% N = 2^6;    %64
N = 2^9;   %512
% N = 2^10;   %1024

%% F matrix
F = DFTMatrix(N);

%Visualize the real and imaginary part of F
figure
subplot(1,2,1)
imagesc(real(F))
title('real(F)')

subplot(1,2,2)
imagesc(imag(F))
title('image(F)')

%Compute the transformation matrix
T = TMatrix(N);

%verify transformation
f = [0:1:N-1]';
T*f

%Similarity transformation
FR = F*T;

figure
subplot(1,2,1)
imagesc(real(FR))
title('real(FR)')

subplot(1,2,2)
imagesc(imag(FR))
title('image(FR)')

%% Plot relationship between n^2 and n*log(n)
%Usually computer scientists mean log = log base 2
n = linspace(2^1,2^12,500);

figure
subplot(2,1,1)
hold on
plot(n,n.^2,'DisplayName','n^2','LineWidth',2)
plot(n,n.*log2(n),'DisplayName','n log2(n)','LineWidth',2)
grid on
xlabel('n')
legend('Location','Best')

subplot(2,1,2)
hold on
plot(n,(n.^2)./(n.*log2(n)),'DisplayName','n^2/(n log2(n))','LineWidth',2)
grid on
xlabel('n')
legend('Location','Best')

disp('DONE!')