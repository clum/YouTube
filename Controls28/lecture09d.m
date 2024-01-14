%Christopher Lum
%lum@uw.edu
%
%Illustrate inputs/output and ICs for linear and nonlinear models.

%Version History
%02/19/22: Created
%01/14/24: Moved to YouTube

clear
clc
close all

%% Load model parameters
temp = load('linear_model_straight_level.mat');
A = temp.A;
B = temp.B;
C = temp.C;
D = temp.D;

temp = load('trim_values_straight_level.mat');
xo = temp.XStar;
uo = temp.UStar;

yo = xo;

%% Simulate system
% selection = 'SteadyState';
% selection = 'u2_doublet';
selection = 'InitialCondition01';
% selection = 'InitialCondition02';

switch selection
    case 'SteadyState'
        doublet_mag         = 0*pi/180;
        doublet_duration    = 5;
        
        t_sample            = 0.05;
        t_final             = 60;
        
        Delta_x0 = [
            0   %Delta_u
            0   %Delta_v
            0   %Delta_w
            0   %Delta_p
            0   %Delta_q
            0   %Delta_r
            0   %Delta_phi
            0   %Delta_theta
            0   %Delta_psi
            ];
        
    case 'u2_doublet'
        doublet_mag         = 10*pi/180;
        doublet_duration    = 5;
        
        t_sample            = 0.05;
        t_final             = 60;
        
        Delta_x0 = [
            0   %Delta_u
            0   %Delta_v
            0   %Delta_w
            0   %Delta_p
            0   %Delta_q
            0   %Delta_r
            0   %Delta_phi
            0   %Delta_theta
            0   %Delta_psi
            ];
        
    case 'InitialCondition01'
        doublet_mag         = 0*pi/180;
        doublet_duration    = 5;
        
        t_sample            = 0.05;
        t_final             = 60;
        
        Delta_x0 = [
            5               %Delta_u
            3               %Delta_v
            -2              %Delta_w
            degtorad(2)     %Delta_p
            degtorad(-3)    %Delta_q
            degtorad(2)     %Delta_r
            degtorad(-5)    %Delta_phi
            degtorad(15)    %Delta_theta
            degtorad(0)     %Delta_psi
            ];
        
    case 'InitialCondition02'
        doublet_mag         = 0*pi/180;
        doublet_duration    = 5;
        
        t_sample            = 0.05;
        t_final             = 60;
        
        Delta_x0 = [
            12              %Delta_u
            10              %Delta_v
            -9              %Delta_w
            degtorad(9)     %Delta_p
            degtorad(10)    %Delta_q
            degtorad(-18)   %Delta_r
            degtorad(-18)   %Delta_phi
            degtorad(20)    %Delta_theta
            degtorad(0)     %Delta_psi
            ];
        
    otherwise
        error('Unknown selection')
end

sim('lecture09d_model')

t       = sim_Delta_y.time;
Delta_u = sim_Delta_u.signals.values;
Delta_y = sim_Delta_y.signals.values;
u       = sim_u.signals.values;
y       = sim_y.signals.values;

%% Plots
%Plot
figure
uLabels = {
    'u1 = aileron'
    'u2 = elevator'
    'u3 = rudder'
    'u4 = throttle 1'
    'u5 = throttle 2'
    };

for k=1:5
    subplot(5,1,k)
    hold on
    plot(t,u(:,k))
    plot(t,Delta_u(:,k) + uo(k))
    grid on
    xlabel('Time (sec)')
    ylabel(uLabels{k})
    
    if(k==1)
        legend('Nonlinear','Linear')
    end
end

figure
yLabels = {
    'u'
    'v'
    'w'
    'p'
    'q'
    'r'
    'phi'
    'theta'
    'psi'
    };

for k=1:9
    subplot(3,3,k)
    hold on
    plot(t,y(:,k))
    plot(t,Delta_y(:,k) + yo(k))
    grid on
    xlabel('Time (sec)')
    ylabel(yLabels{k})
    
    if(k==1)
        legend('Nonlinear','Linear')
    end
end

disp('DONE!')