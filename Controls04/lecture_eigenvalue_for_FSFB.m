%Christopher Lum
%lum@uw.edu
%
%Show a linearized system of a 6DOF freedom model (12 states) to illustrate
%how in most systems, modes are coupled and therefore, you cannot associate
%a pole with a single state, the relationships are more complex.  This sets
%the stage for LQR which will allow us to directly penalize states.

%Version History    
%03/06/14: created
%03/08/18: Updated notes and documentation

clear
clc
close all

%% Look at the eigenvalues/eigenvectors of the DC motor system

%Define constants
R   = 0.05;         %resistance of measurement resistor (ohms)
KV  = 0.09854;      %electrical machine constant (volt sec)
KT  = 0.09854;      %mechanical machine constant (Nm/amp)
Rm  = 1.5398;       %resistance of motor (ohms)
La  = 0.0015581;    %inductance of motor (henries)
c   = 0.00039719;   %coefficient of viscous friction (Nm sec)
Jm  = 0.00137;      %moment of inertia about axis of rotation (kg*m^2)

%State space representation
A = [0 1 0;
     0 -c/Jm KT/Jm;
     0 -KV/La -(R+Rm)/La];
 
B = [0 0;
    0 -1/Jm;
    1/La 0];

disp('Eigenvalues/Eigenvectors of DC Motor')
[V,D] = eig(A)

%% Now look at eigenvalues/eigenvectors of a rigid body, 6 DOF aircraft model
load Aircraft6DOF

%Look at the eigenvalues and eigenvectors
disp('Eigenvalues/Eigenvectors of Aircraft')
[V,D] = eig(A)