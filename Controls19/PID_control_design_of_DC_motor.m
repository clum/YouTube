%Use sisotool to design a compensator for the DC motor position control
%
%Christopher Lum
%lum@uw.edu

%Version History
%03/01/17: Change scope to only include design using sisotool
%11/21/18: Updated documentation, broken up into two lectures
%05/15/19: Updated to use position control instead of velocity control
%05/20/19: Updated to have gains consistent with YouTube video
%02/22/25: Minor update before moving to GitHub

clear
clc
close all

controllerSelection = 1;        %1 = PI, 2 = PIPseudoD

%Define plant (see previous script/lecture for deriving velocity TF)
GP_num = [46163];
GP_den = [1 1021 4845 0];

GP = tf(GP_num,GP_den);

%Note: A PI controller that satisfies the performance requirements is
if(controllerSelection==1)
    KP = 0.416;
    KI = 0.36;
    
    C_num = [KP KI];
    C_den = [1 0];
    C = tf(C_num, C_den);
    
elseif(controllerSelection==2)
    %Note: A PIPseudoD controller that is used in the YouTube video and
    %experimental data is
    KP = 0.7044;
    KI = 1.4006;
    KD = 0.0895;
    a = 100;
    
    C_num = [(a*KD+KP) (a*KP+KI) (a*KI)];
    C_den = [1 a 0];
    C = tf(C_num, C_den);
    
else
    error('Unknown selection')
    
end

%Import plant into Control System Designer
controlSystemDesigner(GP, C)

disp('DONE')