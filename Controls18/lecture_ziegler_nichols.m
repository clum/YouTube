%Use Ziegler-Nichols to tune PID controller.
%
%Use position control of the DC motor as an example system.
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/14/19: Created
%05/16/19: Continued working.  Used to successfully acquire data in lab
%05/17/19: Added example
%01/08/25: Updated documentation

clear
clc
close all

%% Example 1: Transfer Function
G_num = [1];
G_den = [1 6 11 6];

G = tf(G_num, G_den);

%Check the root locus
figure
rlocus(G)

%What are the KU and TU values?
KU = 60;
TU = 1.9;

tFinal = 15;
%Compute and sim for various Ziegler Nichols techniques
TYPE = 'ClassicPID'
[KP, KI, KD] = ZieglerNichols(KU, TU, TYPE)
sim('ziegler_nichols_model.slx')
t1 = simY.Time;
y1 = simY.Data;

TYPE = 'PI'
[KP, KI, KD] = ZieglerNichols(KU, TU, TYPE)
sim('ziegler_nichols_model.slx')
t2 = simY.Time;
y2 = simY.Data;

TYPE = 'PessenIntegrationRule'
[KP, KI, KD] = ZieglerNichols(KU, TU, TYPE)
sim('ziegler_nichols_model.slx')
t3 = simY.Time;
y3 = simY.Data;

TYPE = 'SomeOvershoot'
[KP, KI, KD] = ZieglerNichols(KU, TU, TYPE)
sim('ziegler_nichols_model.slx')
t4 = simY.Time;
y4 = simY.Data;

TYPE = 'NoOvershoot'
[KP, KI, KD] = ZieglerNichols(KU, TU, TYPE)
sim('ziegler_nichols_model.slx')
t5 = simY.Time;
y5 = simY.Data;

figure
plot(t1,y1,...
    t2,y2,...
    t3,y3,...
    t4,y4,...
    t5,y5,...
    'LineWidth', 2)
grid on
title('Ziegler Nichols')
legend('Classic PID','PI','Pessen Integration Rule','Some Overshoot','No Overshoot')

%% Example 2: Experimental DC Motor w/ Modified Flywheel
%Determine KU and TU experimentally from the real system
KU = 45;
TU = 0.96;

[KP, KI, KD] = ZieglerNichols(KU,TU)

%Load real data for this run

disp('DONE')