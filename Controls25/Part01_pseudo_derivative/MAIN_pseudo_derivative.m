%Christopher Lum
%lum@uw.edu
%
%Investigate issues with PID controller implementation (specifically
%numerical differentiation and pseudo-derivatives)

%Version History:   
%02/18/11: Created
%12/28/11: Updated for 2012
%02/15/13: Updated for 2013
%02/06/14: Updated for 2014
%02/03/15: Updated for 2015
%02/04/16: Updated for 2016
%03/06/17: Updated for 2017
%05/21/19: Updated for 2019
%05/09/21: 

clear
clc
close all

%Pseudo derivative parameters
a = 100;

%Simulation parameters
T = 0.001;

noise_amplitude = 0.05;

%First choose a frequency which is below the pseudo derivative corner
%frequency
w_e = 1;            %start at w_e = 1 and then increase to w_e = 50 to illustrate phase lag
numRevolutions = 4;
f_e = w_e/(2*pi);
T_e = 1/f_e;
t_final = T_e*numRevolutions;

sim('pseudo_derivative_model')

t       = sim_e.time;
e       = sim_e.signals.values(:,1);
eDot    = sim_eDot.signals.values(:,1);
eDot1   = sim_eDot1.signals.values(:,1);
eDot2   = sim_eDot2.signals.values(:,1);
eDot3   = sim_eDot3.signals.values(:,1);

figure
plot(t, e)
grid on
legend('e(t)')

figure

subplot(3,1,1)
hold on
plot(t, eDot1)
plot(t, eDot, 'r', 'LineWidth', 2)
grid on 
legend('de(t)/dt (simple numerical derivative)', 'de(t)/dt (true)')

subplot(3,1,2)
hold on
plot(t, eDot2)
plot(t, eDot, 'r', 'LineWidth', 2)
grid on 
legend('de(t)/dt (pseudo derivative)', 'de(t)/dt (true)')

subplot(3,1,3)
hold on
plot(t, eDot3)
plot(t, eDot, 'r', 'LineWidth', 2)
grid on 
legend('de(t)/dt (pseudo derivative with additional filtering)', 'de(t)/dt (true)')

%Investigate the frequency response of a pure differentiator
G = tf([1 0],[1]);
wMin = 10^0;
wMax = 10^3;
figure
bode(G,{wMin,wMax})
title('Bode Plot of Pure Differentiator')
grid on

%Investigate the frequency response of a pseudo derivative with filtering
filter = tf([a],[1 a])
pseudo_derivative = tf([a 0],[1 a])

G = filter*filter*filter*pseudo_derivative

figure
bode(G,{wMin,wMax})
title('Bode Plot of Pseudo Derivative and 3 First Order Filters in Series')
grid on

SaveAllFigures('pseudo_derivative','png')

disp('DONE!')