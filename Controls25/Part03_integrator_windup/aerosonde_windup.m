%Recreate an example of the aerosonde crash.
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/02/21: Created based on final project p2

clear
clc
close all

%---------------------------------Part b-----------------------------------
simulinkModelName = 'aerosonde_windup_model.slx';
uiopen(simulinkModelName,1)

vehicle = 'Boat';
[GEOMETRY, PROPULSION, SIMULATION, ENVIRONMENT, INPUTS] = PlanarVehicleLoadConstants(vehicle);

t_final = 1400;
deltaTMax = 0.05;
switchTime = 600;

% xILimitMoment = +Inf;
xILimitMoment = 0.05;

KP_thrust = 1;
% KI_thrust = 0.1;
KI_thrust = 0;      %just focus on the theta integrator so set thrust integrator to 0
KD_thrust = .2;
a_thrust = 10;

KP_moment = .402002;
KI_moment = .40202*.01848;
KD_moment = 0;
a_moment = 10;

%Setup a flight route
L = 800;

%CCW box
wp1 = [-2*L; L/4; 0];
wp2 = [-1*L; -L/4; 0];
wp3 = [0*L; L/4; 0];
wp4 = [1*L; -L/4; 0];
wp5 = [2*L; L/4; 0];
wp6 = [3*L; -L/4; 0];

waypoints_ENU = [wp1 wp2 wp3 wp4 wp5 wp6];

isClosed = false;
flightRoute = FlightRoute(waypoints_ENU, isClosed);
flightRouteVisualizer = FlightRouteVisualizer(flightRoute);
flightRouteVisualizer.MarkerSize = 15;
flightRouteVisualizer.Color = [1 0 0];

waypointRadius = 100;

SIMULATION.X_0 = [-3*L;-1000;5;0;0;0];


sim(simulinkModelName)

%% Analyze output
t                               = logsout.getElement('V_d').Values.Time;
X                               = logsout.getElement('x').Values.Data;
V                               = logsout.getElement('V').Values.Data(:,1);
U                               = logsout.getElement('u').Values.Data;
V_d                             = logsout.getElement('V_d').Values.Data(:,1);
theta_d                         = logsout.getElement('theta_d').Values.Data(:,1);
e_V                             = logsout.getElement('e_V').Values.Data(:,1);
e_theta                         = logsout.getElement('e_theta').Values.Data(:,1);
activeWaypointIndex             = logsout.getElement('activeWaypointIndex').Values.Data(:,1);
ThrustControllerIntegratorState = logsout.getElement('ThrustControllerIntegratorState').Values.Data(:,1);
MomentControllerIntegratorState = logsout.getElement('MomentControllerIntegratorState').Values.Data(:,1);

x           = X(:,1);
y           = X(:,2);
xDot        = X(:,3);
yDot        = X(:,4);
theta       = X(:,5);
thetaDot    = X(:,6);

uAxial      = U(:,1);
uMoment     = U(:,2);

%Compute distance to waypoint
waypoint_PN = logsout.getElement('waypoint_PN').Values.Data(:,1);
waypoint_PE = logsout.getElement('waypoint_PE').Values.Data(:,1);

distanceToWP = ((waypoint_PN - y).^2 + (waypoint_PE - x).^2).^0.5;

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
flightRouteVisualizer.PlotFlightRoute();
legend('Trajectory','Start','End')

%Inputs and Outputs
figure
subplot(2,2,1)
hold on
plot(t,uAxial)
plot(t,ones(size(t)),'r--')
plot(t,-ones(size(t)),'r--')
legend('u_{axial}','max','min')
grid on
axis([min(t) max(t) -3 3])
title('Inputs U')

subplot(2,2,2)
hold on
plot(t,uMoment)
plot(t,ones(size(t)),'r--')
plot(t,-ones(size(t)),'r--')
legend('u_{moment}','max','min')
grid on
axis([min(t) max(t) -3 3])

%Outputs
subplot(2,2,3)
hold on
plot(t,V)
plot(t,V_d,'g-')
legend('V','V_d')
grid on

subplot(2,2,4)
hold on
plot(t,rad2deg(theta))
plot(t,rad2deg(theta_d),'g-')
legend('\theta','\theta_d')
ylabel('\theta (deg)')
grid on

figure
subplot(4,1,1)
plot(t, e_V)
legend('e_V')
grid on

subplot(4,1,2)
plot(t, e_theta)
legend('e_\theta')
grid on

subplot(4,1,3)
plot(t, activeWaypointIndex)
legend('activeWaypointIndex')
grid on

subplot(4,1,4)
plot(t, distanceToWP)
legend('distanceToWP')
grid on

figure
subplot(4,1,1)
plot(t, e_V)
legend('e_V')
grid on

subplot(4,1,2)
plot(t, ThrustControllerIntegratorState)
legend('ThrustControllerIntegratorState')
grid on

subplot(4,1,3)
plot(t, e_theta)
legend('e_\theta')
grid on

subplot(4,1,4)
plot(t, MomentControllerIntegratorState)
legend('MomentControllerIntegratorState')
grid on


disp('DONE!')