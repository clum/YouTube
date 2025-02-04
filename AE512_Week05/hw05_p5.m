%Christopher Lum
%lum@uw.edu
%
%Emulate UWAL data reduction.

%Version History
%08/15/11: Created
%08/16/11: Finished
%10/27/11: Removed solution code
%04/21/15: Updated for AE512
%04/27/15: Nomenclature to match problem description
%04/27/20: Updated for 2020
%05/05/24: Fixed bug in xR (3rd component was inconsistent w/ problem def)

clear
clc
close all

%Variables to be loaded by datafile
qi = 25.5;                      %indicated dynamic pressure (N/m^2);

xR = [9;0.1;1.1;-1388;5;65];    %data point of raw balance forces/moments [L;D;Y;P;N;R] (N & Nm)

alpha = 13*pi/180;
psi = -5*pi/180;

%------------------Constants defined by UWAL-------------------------------
%A. Indicated to actual q
qa_over_qi = 1.0125;

%B. Balance interactions
A1 = blkdiag(1.1, 1.2, 0.9, 1, 1.2, 1.3);

A1(2,1) = 0.2;
A1(3,4) = 0.001;
A1(3,6) = 0.1;
A1(4,1) = 0.1;
A1(5,1) = 0.05;
A1(6,2) = -0.2;

A2 = zeros(6,6);

%C. Tares

%D. Weight tares
W       = 2000;         %weight of model (N)
xm      = 0.75;         %x position of cg w.r.t. BMC (m)
ym      = 0.1;          %y position of cg w.r.t. BMC (m)
zm      = -0.2;         %z position of cg w.r.t. BMC (m)

%E. Moment transfers
s = 0.2;
t = -0.1;
u = 0;

%F. Blockage corrections
CA      = 8.6;          %actual test section cross section area
KA      = 0.7;
VA      = 0.5;
KB      = 0.2;
VB      = 0.25;

%G. Initial coefficients
S_W     = 0.25;         %reference area (m^2)
cbar    = 0.1;          %reference chord (m)
b_ref   = 0.75;         %reference span (m)

%H. Flow angularity
alpha_upflow = -0.012*pi/180;

%I. Wall corrections
del_w   = 0.4;      
C       = 8.92;     %test section cross section area not accounting for fillets (m^2)
del_As  = 0.3;
dCMdds  = -0.2;     %change in pitching moment with a change in stabilizer angle

%J. Final coefficients & corrected angle of attack

%K. Axis transfers







%----------------------------Data Reduction--------------------------------
%A. Indicated to actual q
%FILL IN HERE

%B. Balance interactions
%FILL IN HERE

%C. Tares
%FILL IN HERE

%D. Weight tares
%FILL IN HERE

%E. Moment transfers
%FILL IN HERE

%F. Blockage corrections
%FILL IN HERE

%G. Initial coefficients
%FILL IN HERE

%H. Flow angularity
%FILL IN HERE

%I. Wall corrections
%FILL IN HERE

%J. Final coefficients & corrected angle of attack
%FILL IN HERE

%K. Axis transfers
%FILL IN HERE

disp('DONE')