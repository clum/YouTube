%Christopher Lum
%lum@uw.edu
%
%Illustrate designing a controller using the root locus technique that
%satisfies performance requirements.
%
%This accompanies the YouTube video located at https://youtu.be/rNYHww84juM

%Version History:
%11/19/20:  Created

clear
clc
close all

%% Define the plant
num = [1 0.2];
den = [1 0.01 0.0025];

G = tf(num,den);

%Evaluate the open loop response
figure
step(G)

%Use rlocus to draw the root locus of the system
figure
hold on
rlocus(G)
grid on

%Draw the pole constraints on the rlocus plot

%Settling time requirement
sigma_required = 0.23;
plot([-sigma_required -sigma_required], [-0.25 0.25], 'r-', 'LineWidth',3)

%omega_d requirement
omega_d_required = 0.1;
plot([-0.8 +0.1], [omega_d_required omega_d_required], 'g-', 'LineWidth', 3)
plot([-0.8 +0.1], [-omega_d_required -omega_d_required], 'g-', 'LineWidth', 3)

%percent overshoot requirement
theta_required = 62.9*pi/180;
plot([-0.8 0], [+tan(theta_required)*0.8 0], 'b-', 'LineWidth', 3)
plot([-0.8 0], [-tan(theta_required)*0.8 0], 'b-', 'LineWidth', 3)

%Chose/design controller to meet requirements
K = 0.74;
