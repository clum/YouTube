%Christopher Lum
%lum@uw.edu
%
%Investigate LQR control on mass/damper system.
%
%This file is designed to accompany the YouTube video at
%https://youtu.be/wEevt2a4SKI

%Version History
%02/28/11: created
%02/17/12: updated for 2012
%03/11/13: updated for 2013
%03/06/14: updated for 2014
%11/29/18: updated for 2018 and YouTube

clear
clc
close all

%Define system
m = 1;
c = 0.2;

A = [0 1;
    0 -c/m];

B = [0;
    1/m];

%Choose Q and R
scenario = 1;   %1 = cheap control
                %2 = expensive control
                %3 = ignore position

switch scenario
    case 1
        %Cheap control
        Q = diag([1 1]);
        R = [0.01];
        
    case 2
        %Expensive control
        Q = diag([1 1]);
        R = [1000];
        
    case 3
        %Only penalize the velocity state
        Q = diag([0.001 10]);
        R = [1];
        
    otherwise
        error('Unknown method')
end

[K, S, E] = lqr(A, B, Q, R);

disp('K computed via LQR:')
K

%Initial condition
t_final = 30;
x0 = [pi;
    -2];

sim('LQR_mass_damper_model')

%extract data
t = sim_X.time;
x1 = sim_X.signals.values(:,1);
x2 = sim_X.signals.values(:,2);
u1 = sim_U.signals.values(:,1);

%plot
figure
subplot(3,1,1)
plot(t, x1, 'LineWidth', 3)
title(['Scenario ',num2str(scenario)])
grid on
legend('x_1')

subplot(3,1,2)
plot(t, x2, 'LineWidth', 3)
grid on
legend('x_2')

subplot(3,1,3)
plot(t, u1, 'LineWidth', 3)
grid on
legend('u_1')

