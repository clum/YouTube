%Christopher Lum
%lum@uw.edu
%
%Use sisotool to design a compensator for the DC motor velocity control

%Version History
%03/01/17: Change scope to only include design using sisotool
%11/21/18: Updated documentation, broken up into two lectures

clear
clc
close all

%Define plant (see previous script/lecture for deriving velocity TF)
num = [46163];
den = [1 1021 4845];

GV = tf(num,den);

%Import plant into sisotool
sisotool(GV)

%What are the gains we obtain from sisotool?
KP = 0.28041;
KI = 0.28041*6.036;
KD = 0;

C_num = [KP KI];
C_den = [1 0];

C = tf(C_num, C_den);

%Let's simulate to verify that we have the desired response
sim('sisotool_model')

t = simY.time;
y = simY.signals.values(:,1);
u = simU.signals.values(:,1);
r = simR.signals.values(:,1);

figure
subplot(2,1,1)
plot(t,r,t,y)
legend('r','y')
grid on

subplot(2,1,2)
plot(t,u)
grid on


disp('DONE')