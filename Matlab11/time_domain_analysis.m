%Christopher Lum
%lum@uw.edu
%
%Illustrate time domain analysis in Matlab

%Version History
%11/11/09: Created
%11/07/12: Updated
%11/05/13: Updated
%04/15/19: Updated for YouTube
%04/16/19: Continued updating documentation

clear
clc
close all

%Constants
m = 2;
k = 50;
b = 4;

%Define transfer fuction.  Recall
%
%                   k/m
%   G(s) = ------------------------
%            s^2 + (b/m)*s + (k/m)
num = [k/m];
den = [1 b/m k/m];

G = tf(num,den)

%Get the damping ratio and natural frequency
zeta = b/(2*sqrt(k*m));
wn = sqrt(k/m);

%Compute the appropriate performance metrics
A = 1.5;
delta = 0.02;

Tp = pi/(sqrt(1-zeta^2)*wn)                 %time to first peak
Mpt = A*(1 + exp(-pi*zeta/sqrt(1-zeta^2)))  %magnitude at first peak
PO = 100*exp(-pi*zeta/sqrt(1-zeta^2))       %percent overshoot
Tstilde = -log(delta)/(zeta*wn)             %settling time

%Subject this system to a step function
step(G)

%Use lsim as it can use a custom input to represent a step with magnitude
%other than 1 or even ramps
tFinal = 6;
t = linspace(0,tFinal,200)';
uStep = A*ones(size(t));
uRamp = 5*t;

lsim(G, uStep, t)
lsim(G, uRamp, t)

%Use the linearSystemAnalyzer to do all of the above
linearSystemAnalyzer(G)

%Note that we can use this with multiple systems to see their effects
G1 = G;

b2 = 8;
den2 = [1 b2/m k/m];
G2 = tf(num,den2);

b3 = 16
den3 =[1 b3/m k/m];
G3 = tf(num,den3);

linearSystemAnalyzer(G1, G2, G3)


%Show that you can simulate the response in Simulink
simulinkModelName = 'time_domain_analysis_model.slx';
uiopen(simulinkModelName,1)
sim(simulinkModelName)

disp('DONE!')