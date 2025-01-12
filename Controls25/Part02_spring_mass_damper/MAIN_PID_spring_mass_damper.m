%Control a simple spring mass damper with a PID controller to illustrate
%behavior of integrator windup.
%
%Christopher Lum
%lum@uw.edu

%Version History:   
%05/12/21: Created

clear
clc
close all

m = 2;
k = 0.1;
c = 0.05;

A = [0 1;-k/m -c/m];
B = [0;1/m];
C = [1 0];
D = [0];

x0 = [0;0];

%Gains that lead to oscillations
KP = 1.2;
KI = 0.15;
KD = 0.6;

% %Gains that lead no oscillations (control stays below the necessary steady
% %state value)
% KP = 1.2/10;
% KI = 0.15/15;
% KD = 0.6;

%Prefilter constants
p = 1;      %very minor improvement
p = 0.5;    %moderate improvement
p = 0.1;    %major improvement (but still minor oscillations)
p = 0.01;   %no oscillations but major bandwidth limitations

%Integrator anti-wind up
xILimit = 1000;
% xILimit = 0.7;      %some limiting but still has oscillations
% xILimit = 0.1;      %reduce overshoot in a minor fashion but this limits the itegrator so much that we have steady state error

deltaTMax = 0.05;
sim('PID_spring_mass_damper_model')

disp('DONE!')