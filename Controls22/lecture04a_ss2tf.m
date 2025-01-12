%Show how to go from a state space to transfer function representation and
%back.
%
%Christopher Lum
%lum@uw.edu

%Version History
%04/10/21: Created

clear
clc
close all

%% Define constants
R   = 0.05;         %resistance of measurement resistor (ohms)
KV  = 0.09854;      %electrical machine constant (volt sec)
KT  = 0.09854;      %mechanical machine constant (Nm/amp)
Rm  = 1.5398;       %resistance of motor (ohms)
La  = 0.0015581;    %inductance of motor (henries)
c   = 0.00039719;   %coefficient of viscous friction (Nm sec)
Jm  = 0.00137;      %moment of inertia about axis of rotation (kg*m^2)

%% State space representation
A = [0 1 0;
     0 -c/Jm KT/Jm;
     0 -KV/La -(R+Rm)/La];
 
B = [0 0;
    0 -1/Jm;
    1/La 0];

C = [0 1 0;
    1 0 0;
    0 0 KT];

D = zeros(3,2);

%Create a ss object
G_ss = ss(A,B,C,D);

%Transfer function representation (w(s)/Va(s))
GV_num = [KT];
GV_den = [Jm*La c*La+Jm*R+Jm*Rm KT*KV+c*R+c*Rm];

GV = tf(GV_num,GV_den)

%% Can we get the same TF using ss2tf?
i_u = 1;
i_y = 1;
[GV_num_alt, GV_den_alt] = ss2tf(A, B(:,i_u),C(i_y,:),D(i_y,i_u));
GV_alt = tf(GV_num_alt, GV_den_alt)

%Clean up the numerical errors
[GV_alt_clean] = CleanUpTransferFunction(GV_alt);

%Verify that both GV and GV_alt_clean are the same even though they appear
%different
[num1, den1] = tfdata(GV,'v');
[num2, den2] = tfdata(GV_alt_clean,'v');
[Z1, P1, K1] = tf2zpk(num1, den1);
[Z2, P2, K2] = tf2zpk(num2, den2);

assert(sum(abs(Z1-Z2)) < 10e-12, 'zeros do not match')
assert(sum(abs(P1-P2)) < 10e-12, 'poles do not match')
assert(sum(abs(K1-K2)) < 10e-12, 'gains do not match')

%% Go from tf to ss
b0 = KT/(Jm*La);
b1 = 0;

a0 = (KT*KV+c*R+c*Rm)/(Jm*La);
a1 = (c*La+Jm*R+Jm*Rm)/(Jm*La);

Atilde = [0 1;
    -a0 -a1];
 
Btilde = [0;
    1];

Ctilde = [b0 b1];

Dtilde = [0];

%Verify that we recover the same transfer function
[num_tilde,den_tilde] = ss2tf(Atilde,Btilde,Ctilde,Dtilde);
GV_tilde = tf(num_tilde,den_tilde);

%Try to use Matlab's tf2ss
[Atilde2,Btilde2,Ctilde2,Dtilde2] = tf2ss(num_tilde,den_tilde);