%Illustrate Routh array using custom Matlab function RouthArray.
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/17/12: Created
%05/07/19: Updated
%01/07/25: Updated documentation.

clear
clc
close all

%Example from website
P1 = [2 4 2 -1 0 2 -2];
[Routh1] = RouthArray(P1)

%Example from wikipedia
P2 = [1 4 2 5 3 6];
[Routh2] = RouthArray(P2)

%Example 1 from lecture notes
P3 = [2 4 2 -1 0 2 -2];
[Routh3] = RouthArray(P3)

%Example 2 from lecture notes
P4 = [1 2 2 4 5];
[Routh4] = RouthArray(P4)

%Use root locus
z = [];
p = [-1 -2 -3];
k = [1];

G = zpk(z,p,k)

figure
rlocus(G)