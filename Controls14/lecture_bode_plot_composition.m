%Illustrate sketching Bode Plots of complex transfer functions
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/11/12: Created
%11/18/14: Updated
%04/27/19: Updated for AE511, added components

clear
clc
close all

%Component 1 (static gain of value 10/3)
num1 = [1/6];
den1 = [1];

G1 = tf(num1,den1)

figure
bode(G1)
grid on
title('INDIVIDUAL: Bode plot of component 1, constant gain')

figure
bode(G1)
grid on
title('COMBINED: Bode plot of component 1')

%Component 2 (real zero at s = -0.1)
num2 = [10 1];
den2 = [1];

G2 = tf(num2,den2)

figure
bode(G2)
grid on
title('INDIVIDUAL: Bode plot of component 2, real zero')

figure
bode(G1*G2)
grid on
title('COMBINED: Bode plot of component 1 and 2')

%Component 3 (pole at origin)
num3 = [1];
den3 = [1 0];

G3 = tf(num3,den3)

figure
bode(G3)
grid on
title('INDIVIDUAL: Bode plot of component 3, pole at origin')

figure
bode(G1*G2*G3)
grid on
title('COMBINED: Bode plot of component 1, 2, and 3')

%Component 4 (real pole at s = -30)
num4 = [1];
den4 = [1/30 1];

G4 = tf(num4,den4)

figure
bode(G4)
grid on
title('INDIVIDUAL: Bode plot of component 4, real pole')

figure
bode(G1*G2*G3*G4)
grid on
title('COMBINED: Bode plot of component 1, 2, 3, and 4')

%Total transfer function
num = [50 5];
den = [1 30 0];

G = tf(num,den)

figure
bode(G)
grid on
title('Check combined bode plot')

%% Illustrate basic loop shaping

%Add new component of pair of complex conjugate poles
zeta = 0.246;
wn = 106.666;

numC = [1];
denC = [1/(wn^2) 2*zeta/wn 1];

C = tf(numC,denC);

figure
bode(C)
grid on
title('Bode plot of designed complex conjugate pair of poles')

%Bode plot of the entire new system
Gtotal = G*C
figure
bode(Gtotal)
grid on
title('Bode plot of total system G_{total}(s) = G(s)*C(s)')

w = 100;
A = 2;

T = (2*pi/w);           %period of sin wave
deltaTMax = T/50;       %max time step to take
numCycles = 10;         %number of cycles to run simulation
t_final = numCycles*T;

disp('DONE')