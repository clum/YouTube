%Generate a graphic to use for the resonant frequency discussion
%
%Christopher Lum
%lum@uw.edu

%Version History
%04/22/19: Created

clear
clc
close all

%Create a transfer function
Z = [-1+i -1-i -1];
P = [-0.1+1*i -0.1-1*i -5+100*i -5-100*i -2.5];
K = [5];

G = zpk(Z, P, K)

figure
bode(G)
grid on