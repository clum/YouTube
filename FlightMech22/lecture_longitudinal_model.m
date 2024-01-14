%Christopher Lum
%lum@uw.edu
%
%Linear Longitudinal Model

%Version History
%11/21/07: Created
%11/17/08: Updated for 2008
%12/02/11: Updated for 2011
%05/19/15: Updated for 2015
%02/28/19: Updated for 2019
%02/03/22: Updated for 2022
%01/14/24: Moved to YouTube

clear
clc
close all

%Load the linear longitudinal model
temp = load('longitudinal_linear_model.mat');
Along = temp.Along;
Blong = temp.Blong;

Clong = eye(4);
Dlong = zeros(4,5);

%Initial condition
DeltaXlong0 = [0;0;0;3*pi/180];

doublet_time = 15;
doublet_duration = 1;
doublet_magnitude = 2*pi/180;

%Simulate the model
sim('lecture_longitudinal_model_model')

t       = simDeltaU.time;
DeltaU  = simDeltaU.signals.values;
DeltaX  = simDeltaX.signals.values;

%Plot the controls
figure
subplot(5,1,1)
plot(t, DeltaU(:,1)*180/pi, 'LineWidth', 2)
grid on
legend('\Delta u_1 = \Delta_A (deg)')

subplot(5,1,2)
plot(t, DeltaU(:,2)*180/pi, 'LineWidth', 2)
grid on
legend('\Delta u_2 = \Delta_T (deg)')

subplot(5,1,3)
plot(t, DeltaU(:,3)*180/pi, 'LineWidth', 2)
grid on
legend('\Delta u_3 = \Delta_R (deg)')

subplot(5,1,4)
plot(t, DeltaU(:,4), 'LineWidth', 2)
grid on
legend('\Delta u_4 = \Delta_{th,1}')

subplot(5,1,5)
plot(t, DeltaU(:,5), 'LineWidth', 2)
grid on
legend('\Delta u_5 = \Delta_{th,2}')

%Plot the states
figure
subplot(4,1,1)
plot(t, DeltaX(:,1), 'LineWidth', 2)
legend('\Delta x_1 = \Delta u')
grid on

subplot(4,1,2)
plot(t, DeltaX(:,2), 'LineWidth', 2)
legend('\Delta x_2 = \Delta w')
grid on

subplot(4,1,3)
plot(t, DeltaX(:,3)*180/pi, 'LineWidth', 2)
legend('\Delta x_3 = \Delta q (deg/s)')
grid on

subplot(4,1,4)
plot(t, DeltaX(:,4)*180/pi, 'LineWidth', 2)
legend('\Delta x_4 = \Delta \theta (deg)')
grid on

disp('FINISHED')
