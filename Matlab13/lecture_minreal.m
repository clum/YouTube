%Explore how to using 'minreal' to perform transfer function pole/zero
%cancellation.
%
%Note that we do not show how minreal operations on state space systems.
%The scope of this lecture is for transfer functions only.
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/10/19: Created

clear
clc
close all

%% Example 1: Exact pole/zero cancellation
num1 = [1 3 2];
den1 = [1 2 -11 -12];

G1 = tf(num1,den1)

roots(num1)
roots(den1)

figure
pzmap(G1)

%Perform pole/zero cancellation
G1minimal = minreal(G1)

figure
pzmap(G1minimal)

%% Example 2: Show how this can occur even when using zpk
z2 = [-2 -1];
p2 = [-4 -1 3];
k2 = [1];

G2 = zpk(z2,p2,k2)

G2minimal = minreal(G2)

%% Example 3: Show how this can occur when composing transfer functions
z3 = [-1];
p3 = [-2 -3];
k3 = [1];
G3 = zpk(z3,p3,k3);

z4 = [-2];
p4 = [-1 -3];
k4 = [1];
G4 = zpk(z4,p4,k4)

T1 = G4*G3
T1minimal = minreal(T1)

%% Example 4: Simple feedback system
T2 = G3/(1+G3)
T2minimal = minreal(T2)

%% Example 5: Small numerical inaccuracies
num5 = [1 3.003 2.006];
den5 = [1 8.001 19.007 12.012];

G5 = tf(num5,den5)

roots(num5);
roots(den5);

figure
pzmap(G5)

%Perform pole/zero cancellation
tol = 0.001;
G5minimal = minreal(G5,tol)

figure
pzmap(G5minimal)