%Verify various hand sketches of root locus plots 
%
%Created by Christopher Lum
%lum@uw.edu

clear
clc
close all

%G4
Z4 = [-1-2*i -1+2*i -3];
P4 = [-2 +2 +4];
K4 = [1];
G4 = zpk(Z4, P4, K4)

figure
rlocus(G4)
title('G_4')

%G5
Z5 = [-1];
P5 = [-1-1*i -1+1*i];
K5 = [2];
G5 = zpk(Z5, P5, K5)

figure
rlocus(G5)
title('G_5')

%G6
num6 = [1 3];
den6 = [1 8 1 -138 -232];
G6 = tf(num6,den6)

figure
rlocus(G6)
title('G_6')

%G7
num7 = [1 2];
den7 = [1 10 34 0];
G7 = tf(num7,den7)

figure
rlocus(G7)
title('G_7')

%G8
num8 = [1 2 2];
den8 = [1 9 33 51 26 0];
G8 = tf(num8,den8)

figure
pzmap(G8)
title('G_8')

figure
rlocus(G8)
title('G_8')