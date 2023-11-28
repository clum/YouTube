%Christopher Lum
%christopher.w.lum@gmail.com
%
%Load real sensor data and see if it can be modeled as a Gaussian
%distribution.
%
%This file is designed to accompany the YouTube video at
%https://youtu.be/Xaju4l9KTE0

%Version History
%11/18/19: Modified AE501 lecture19 script for YouTube demonstration
%11/20/19: Continued working
%11/25/10: Added YouTube URL

clear
clc
close all

%Load the real sensor data
load('HeadingData.mat')

%Plot the raw signal
figure
plot(t, psi, 'LineWidth', 2)
xlabel('Time (sec)')
ylabel('\psi (radians)')
title('\psi vs. Time')
grid on

%Compute mean and variance of signal
mu      = mean(psi);
sigma   = sqrt(var(psi));

%Calculate Gaussian
x   = linspace(min(psi), max(psi), 100);
fx  = 1/(sigma*sqrt(2*pi))*exp(-0.5*((x - mu)/sigma).^2);

%verify that this sums to approximately 1
trapz(x,fx)

%Plot the gaussian distribution
figure
plot(x, fx, 'LineWidth', 2);
title('Calculated Gaussian Distribution of \psi')
xlabel('\psi')
ylabel('p(\psi)')
grid on

%Normalizing coefficient to make fx distribution fit over histogram
bins = linspace(min(psi), max(psi), 20);

[N, X] = hist(psi, bins);
alpha = max(N)/max(fx);

%Plot a histogram
figure;
hist(psi, bins);
hold on
plot(x, alpha*fx, 'r--', 'LineWidth', 3)

xlabel('\psi')
ylabel('# samples')
legend('\psi histogram','\psi Gaussian')
grid on

disp('DONE!')