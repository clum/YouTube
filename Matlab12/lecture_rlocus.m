%Illustrate root locus using Matlab's rlocus
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/11/12: Created
%11/18/13: Updated
%11/07/14: Updated
%05/06/19: Updated

clear
clc
close all

%% Example 1 from previous lecture
%Manual root locus
figure
hold on
for K=0.1:0.1:2
    Delta = [1 2 K];
    poles = roots(Delta);
    plot(real(poles), imag(poles), 'rx')
    title(['K = ',num2str(K)])
    axis([-2 0 -1 1])
    grid on
    pause(0.5)
end

%Verify with rlocus
G1_num = [1];
G1_den = [1 2 0];
G1 = tf(G1_num, G1_den);

figure
rlocus(G1)

%% Example 6 from previous lecture
G6_num = [1 3];
G6_den = [1 8 1 -138 -232];
roots(G6_den)         %check open loop roots
G6 = tf(G6_num, G6_den)

figure
rlocus(G6)

%% Example 7 from previous lecture
%Build system using zpk
z7 = [-2];
p7 = [0 -5-3*i -5+3*i];
k7 = 1;

G7 = zpk(z7,p7,k7)

figure
rlocus(G7)