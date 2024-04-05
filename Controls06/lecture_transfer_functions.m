%Christopher Lum
%lum@uw.edu
%
%Transfer Functions and Simulink

%Version History
%01/xx/12: Created
%01/14/12: Updated
%01/09/14: Updated
%04/07/19: Updated

clear
clc
close all

%Create a transfer function in Matlab
m = 1;
c = 3;
k = 5;

G_num = [1];
G_den = [m c k];

G = tf(G_num,G_den)

figure
step(G)

%Implement this in Simulink
xdot0 = -2;
x0 = 1;

sim('lecture_transfer_functions_model.slx')

t = simX.time;
x_tf = simX.signals.values(:,1);
x_blocks = simX.signals.values(:,2);

figure
plot(t, x_tf,...
    t, x_blocks,...
    'LineWidth', 2)
grid on
legend('tf','blocks')