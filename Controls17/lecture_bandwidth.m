%Explore system bandwidth with velocity control of a DC motor using a
%simple proportional control.
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/09/19: Created
%05/10/19: Continued working
%05/14/19: Updated documentation
%01/07/25: Updated documentation

clear
clc
close all

%Define plant (see previous script/lecture for deriving velocity TF)
GV_num = [46163];
GV_den = [1 1021 4845];

GV = tf(GV_num,GV_den);

%Define controller (use K = 0.5 and 5.5)
K = 0.5;
CV_num = [K];
CV_den = [1];
CV = tf(CV_num,CV_den);

%Get the closed loop transfer function (note the use of minreal, otherwise
%there are poles/zeros that are not canceled.  See YouTube video at
%https://youtu.be/LQf2Vd-frsA)
TV = minreal(CV*GV/(1+CV*GV))

figure
bode(TV)
grid on
title(['Bode Plot of T_V(s) with K = ',num2str(K)])

%Simulate with Simulink to illustrate behavior
uiopen('bandwidth_model.slx', 1)