%Christopher Lum
%lum@uw.edu
%
%Investigate full state feedback

%Version History
%02/23/11: created
%03/04/11: updated
%02/13/12: updated
%02/20/13: updated
%03/04/14: updated
%11/28/18: Updated for YouTube
%11/30/18: Minor updates

clear
clc
close all

%% Plant Model (DC Motor)
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

C = eye(3);

D = zeros(3,2);

%Extract columns of B and D matrix which correspond to Va control
B1 = B(:,1);
D1 = D(:,1);

%Look at open loop eigenvalues of system
open_loop_poles = eig(A)

%% Design Controller
%Verify that the system is controllable
Pc = ctrb(A,B1)
rank(Pc)

%Verify that not moving poles requires no control
K = place(A,B1,open_loop_poles);

%How to choose desired closed loop pole locations
method = 3;     %1 = agressive pole placement
                %2 = less aggressive pole placement
                %3 = do not move poles associated with omega or current

%Choose closed loop pole locations
switch method
    case 1
        %aggressive placement
        desired_closed_loop_poles = [-100; -110; -120];
        
    case 2
        %less aggressive placement
        desired_closed_loop_poles = [-5; -30; -400];
        
    case 3
        %do not move poles associated with omega or current
        desired_closed_loop_poles = [-2;open_loop_poles(2); open_loop_poles(3)];

    otherwise
        error('Unknown method')
end

%Compute full state feedback gain
K = place(A,B1,desired_closed_loop_poles)

%Closed loop system
Acl = A-B1*K;

%% Simulate system
t_final = 2;
x0 = [72*pi/180;
    2*pi;
    -1];

sim('FSFB_model')

t       = sim_X.time;

%From model with full state feedback
x1      = sim_X.signals.values(:,1);
x2      = sim_X.signals.values(:,2);
x3      = sim_X.signals.values(:,3);

Va      = sim_Va.signals.values(:,1);
TL      = sim_TL.signals.values(:,1);

%From single, closed loop state space model
x1_cl   = sim_Xcl.signals.values(:,1);
x2_cl   = sim_Xcl.signals.values(:,2);
x3_cl   = sim_Xcl.signals.values(:,3);

%From model where we neglect k_1 and k_2
x1_tilde = sim_X_tilde.signals.values(:,1);
x2_tilde = sim_X_tilde.signals.values(:,2);
x3_tilde = sim_X_tilde.signals.values(:,3);

Va_tilde = sim_Va_tilde.signals.values(:,1);

%% Create plots
figure
subplot(3,1,1)
plot(t, x1, t, x1_tilde, 'LineWidth', 2)
legend('u(t) = -K*x(t)','u(t) = -k_1*x_1(t)')
ylabel('x_1(t)')
grid on
title('Response of System with Full State Feedback Controller')

subplot(3,1,2)
plot(t, x2, t, x2_tilde, 'LineWidth', 2)
legend('u(t) = -K*x(t)','u(t) = -k_1*x_1(t)')
ylabel('x_2(t)')
grid on

subplot(3,1,3)
plot(t, x3, t, x3_tilde, 'LineWidth', 2)
legend('u(t) = -K*x(t)','u(t) = -k_1*x_1(t)')
ylabel('x_3(t)')
grid on
xlabel('Time (sec)')

figure
subplot(2,1,1)
plot(t, Va, t, Va_tilde, 'LineWidth', 2)
legend('u(t) = -K*x(t)','u(t) = -k_1*x_1(t)')
ylabel('V_a(t)')
grid on
title('Control Signal and Disturbance Torque')

subplot(2,1,2)
plot(t, TL, 'LineWidth', 2)
ylabel('T_L(t)')
grid on

disp('DONE')