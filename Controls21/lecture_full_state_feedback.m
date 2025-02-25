%Christopher Lum
%lum@uw.edu
%
%Illustrate full state feedback.

%Version History
%05/23/19: Created
%05/25/19: Updated

clear
clc
close all

%% Example 1: Controllable System
A = [0 3;
    2 4];

B = [-2;
    1];

%Check controllability
rank(ctrb(A,B))

pDesired = [-5+2*i -5-2*i];

[K] = place(A, B, pDesired)
[K] = acker(A, B, pDesired)

%% Example 2: Uncontrollable System
B = [0.5*(-2+sqrt(10));1];

rank(ctrb(A,B))

% [K] = place(A, B, pDesired)

%% Example 3: Controllable System with Multiple Inputs
B = [-2 1;1 1];

rank(ctrb(A,B))

[K] = place(A, B, pDesired)

%Does our desired K also place the poles at the desired loaction?
K = [1/10 1/10;
    -1033/240 4417/240]

eig(A-B*K)
