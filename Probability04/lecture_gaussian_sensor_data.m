%Christopher Lum
%lum@uw.edu
%
%Load real sensor data and see if it can be modeled as a Gaussian
%distribution.

%Version History
%12/05/07: Created
%12/01/08: Updated for 2008
%12/08/11: Updated for 2011
%11/15/19: Updated for 2019
%11/19/19: Fixed bug, added integration

clear
clc
close all

%Load the real sensor data
load('sensor_data.mat')

%Plot the raw signal
figure
subplot(2,1,1)
plot(t, psi, 'LineWidth', 2)
xlabel('Time (sec)')
ylabel('\psi (radians)')
title('\psi vs. Time')
grid on

subplot(2,1,2)
plot(t, theta, 'LineWidth', 2)
xlabel('Time (sec)')
ylabel('\theta (radians)')
title('\theta vs. Time')
grid on

%Compute mean and variance of signal
mu_psi      = mean(psi);
var_psi     = var(psi);

mu_theta    = mean(theta);
var_theta   = var(theta);

%Calculate the appropriate Gaussian
x_psi   = linspace(min(psi), max(psi)
]\, 100);
x_theta = linspace(min(theta), max(theta), 100);

px_psi_guassian = 1/((2*pi*var_psi).^(1/2))*exp(-0.5*(x_psi - mu_psi).^2./var_psi);
px_theta_guassian = 1/((2*pi*var_theta).^(1/2))*exp(-0.5*(x_theta - mu_theta).^2./var_theta);

%Verify that this integrates to approximately 1
trapz(x_psi,px_psi_guassian)
trapz(x_theta,px_theta_guassian)

figure;
subplot(2,1,1)
plot(x_psi, px_psi_guassian, 'LineWidth', 2);
title('Calculated Gaussian Distribution of \psi')
xlabel('\psi')
ylabel('p(\psi)')
grid on

subplot(2,1,2)
plot(x_theta, px_theta_guassian, 'LineWidth', 2);
title('Calculated Gaussian Distribution of \theta')
xlabel('\theta')
ylabel('p(\theta)')
grid on

%Normalizing coefficient to make distribution fit over samples
psi_bins    = linspace(min(psi), max(psi), 15);
theta_bins  = linspace(min(theta), max(theta), 15);

[N_psi, X_psi] = hist(psi, psi_bins);
alpha_psi = max(N_psi)/max(px_psi_guassian);

[N_theta, X_theta] = hist(theta, theta_bins);
alpha_theta = max(N_theta)/max(px_theta_guassian);

%Plot a histogram
figure;
subplot(2,1,1)
hist(psi, psi_bins);
hold on
plot(x_psi, alpha_psi*px_psi_guassian, 'r--', 'LineWidth', 3)
xlabel('\psi')
ylabel('# samples')
legend('\psi histogram','\psi Gaussian')
grid on

subplot(2,1,2)
hist(theta, theta_bins);
hold on
plot(x_theta, alpha_theta*px_theta_guassian, 'r--', 'LineWidth', 3)
xlabel('\theta')
ylabel('# samples')
legend('\theta histogram','\theta Gaussian')
grid on

disp('DONE!')