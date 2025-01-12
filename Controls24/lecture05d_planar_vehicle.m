%Examine the behavior of the planar vehicle with some open loop inputs.
%
%Christopher Lum
%lum@uw.edu

%Version History
%03/28/21: Created
%04/22/21: Updated
%01/07/25: Updated

clear
clc
close all

%---------------------------------Part b-----------------------------------
simulinkModelName = 'lecture05d_planar_vehicle_model.slx';
uiopen(simulinkModelName,1)

vehicle = 'Boat';
[GEOMETRY, PROPULSION, SIMULATION, ENVIRONMENT, INPUTS] = PlanarVehicleLoadConstants(vehicle);
SIMULATION.X_0 = [200;200;0;0;0;0];

t_final = 200;
deltaTMax = 0.05;

sim(simulinkModelName)

%% Analyze output
t           = logsout.getElement('x').Values.Time;
X           = logsout.getElement('x').Values.Data;
V           = logsout.getElement('V').Values.Data(:,1);
U           = logsout.getElement('u').Values.Data;

x           = X(:,1);
y           = X(:,2);
xDot        = X(:,3);
yDot        = X(:,4);
theta       = X(:,5);
thetaDot    = X(:,6);

uAxial      = U(:,1);
uMoment     = U(:,2);

%Overall trajectory
figure
hold on
plot(x,y)
plot(x(1),y(1),'ro')
plot(x(end),y(end),'rx')
axis('equal')
title('Overall Trajectory')
xlabel('x')
ylabel('y')
grid on
legend('Trajectory','Start','End')

%Inputs and Outputs
figure
subplot(3,2,1)
hold on
plot(t,uAxial)
plot(t,ones(size(t)),'r--')
plot(t,-ones(size(t)),'r--')
legend('u_{axial}','max','min')
grid on
axis([min(t) max(t) -3 3])
title('Inputs U')

subplot(3,2,2)
hold on
plot(t,uMoment)
plot(t,ones(size(t)),'r--')
plot(t,-ones(size(t)),'r--')
legend('u_{moment}','max','min')
grid on
axis([min(t) max(t) -3 3])

%Outputs
subplot(3,2,3)
hold on
plot(t,V)
legend('V')
ylabel('V (m/s)')
grid on

subplot(3,2,4)
hold on
plot(t,rad2deg(theta))
legend('\theta')
ylabel('\theta (deg)')
grid on

subplot(3,2,5)
hold on
plot(t,rad2deg(thetaDot))
legend('d\theta/dt')
ylabel('d\theta/dt (deg/s)')
grid on

disp('DONE!')