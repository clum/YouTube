%Use the Control System Designer (formerly sisotool) to design a
%compensator for the DC motor position control
%
%Christopher Lum
%lum@uw.edu

%Version History
%03/01/17: Change scope to only include design using sisotool
%11/21/18: Updated documentation and broke into two lectures
%05/13/19: Updated to use controlSystemDesigner instead of sisotool
%01/08/25: Updated documentation

clear
clc
close all

%Define plant (see previous script/lecture for deriving position TF)
GP_num = [46163];
GP_den = [1 1021 4845 0];

GP = tf(GP_num,GP_den);

%start a controlSystemDesigner session (note that you can directly import
%GP here if desired but we will do this manually to illustrate the
%workflow).
controlSystemDesigner

disp('DONE')