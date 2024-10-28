%Manually compute the DFT
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/04/23: Created

clear
clc
close all

N = 6;
DeltaX = 1/5;

% N = 6*10;
% DeltaX = 1/5;

%plot the overall function
xHigh   = linspace(0,N*DeltaX,300)';
x       = [0:DeltaX:(N-1)*DeltaX]';

figh = figure;
hold on

%Continuous function
plot(xHigh,fcnA(xHigh),'LineWidth',2,'DisplayName','f(x)')

%Sampled function
plot(x,fcnA(x),'rx','MarkerSize',15,'LineWidth',2,'DisplayName','sampled function')
legend('Location','Best')
xlabel('x')
grid on

%Manually compute DFT
f = fcnA(x);
[fhatA] = DFTMethodA(f);
[fhatB] = DFTMethodB(f);
[fhatC] = fft(f);

fhat = fhatA;

%% Spectral analysis
w = (2*pi)/(N*DeltaX)*[0:1:N-1];                %frequency (rad/s)
w_hz = w./(2*pi);                               %frequency (hz)

figure
plot(w,abs(fhat)/N,'rx','MarkerSize',15,'LineWidth',2)
xlabel('\omega (rad/s)')
grid on

%% IDFT
%Verify we recover f
[fA] = IDFTMethodA(fhat);
[fC] = ifft(fhat);

disp('DONE!')