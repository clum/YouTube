%Christopher Lum
%lum@uw.edu
%
%Illustrate Bode plots in Matlab

%Version History
%12/03/13: Created
%11/18/14: Updated
%04/21/19: Updated
%01/04/24: Showing how to use bodeplot

clear
clc
close all

%% Manually create a bode plot

%Step 1: Generate list of desired frequencies
w = logspace(-1,2,300);

%Step 2: Compute amplification and phase shift at each frequency
alpha = (12-3*w.^2)./(16-(31/4)*w.^2+w.^4);
beta = ((-3/2)*w)./(16-(31/4)*w.^2+w.^4);

%Step 3: Convert amplification to dB
magGjw = (alpha.^2 + beta.^2).^(1/2);
magGjw_dB = 20*log10(magGjw);

angleGjw = atan2(beta,alpha);
angleGjw_deg = rad2deg(angleGjw);

%Step 4: Plot on a log10 x-axis
figure
subplot(2,1,1)
semilogx(w,magGjw_dB,'r-','LineWidth',3)
grid on
ylabel('Magnitude (dB)')
title('Manually Creating a Bode Plot')

subplot(2,1,2)
semilogx(w,angleGjw_deg,'r-','LineWidth',3)
grid on
ylabel('Phase (deg)')
xlabel('\omega (rad/s)')

%% Use Matlab's 'bode' 
%define constants
m = 1/3;
c = 1/6;
k = 4/3;

%obtain the transfer function representation of the system
% num = [1/m];
% den = [1 c/m k/m];

num = [3];
den = [1 1/2 4];
G = tf(num,den);

%Obtain the bode plot of this system
figure
bode(G)
grid on

%Use 'bodeplot' for additional options
plotoptions = bodeoptions;  
plotoptions.PhaseUnits = 'rad';
plotoptions.Grid = 'on';

figure
bodeplot(G,plotoptions,'--')
grid on