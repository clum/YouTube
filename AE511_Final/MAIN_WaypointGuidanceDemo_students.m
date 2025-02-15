%Simple demo of PlanarVehicle following a FlightRoute.
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/20/21: Stripped down model to isolate dependencies
%02/15/25: Updated to output dummy states so model runs

clear
clc
close all

%% Add dependencies
addpath([pwd,'\PlanarVehicleResources'])
addpath([pwd,'\PlanarVehicleResources\Simulink3D'])
addpath([pwd,'\PlanarVehicleResources\Simulink3D\texture'])

%% User selections
simulinkModelName = 'WaypointGuidanceDemo_students_model.slx';
uiopen(simulinkModelName,1)

%Define model parameters
m = 10;
Ib = 5;
Fmax = 10;
Mmax = 0.5;
cT = 0.025;
cR = 0.75;

sample_time = 0.05;

x0 = [200;200;0;0;0;0];

t_final = 400;
deltaTMax = 0.05;

%Setup a flight route
L = 800;

% %CCW box
% wp1 = [L; 0; 0];
% wp2 = [L; L; 0];
% wp3 = [0; L; 0];
% wp4 = [0; 0; 0];
% waypoints_ENU = [wp1 wp2 wp3 wp4];

% %CW box
% wp1 = [L; 0; 0];
% wp2 = [0; 0; 0];
% wp3 = [0; L; 0];
% wp4 = [L; L; 0];
% waypoints_ENU = [wp1 wp2 wp3 wp4];

%Figure 8
wp1 = [L - 2*L; 0; 0];
wp2 = [3*L - 2*L; 2*L; 0];
wp3 = [4*L - 2*L; L; 0];
wp4 = [3*L - 2*L; 0; 0];
wp5 = [L - 2*L; 2*L; 0];
wp6 = [0 - 2*L; L; 0];
waypoints_ENU = [wp1 wp2 wp3 wp4 wp5 wp6];

isClosed = true;
flightRoute = FlightRoute(waypoints_ENU, isClosed);
flightRouteVisualizer = FlightRouteVisualizer(flightRoute);
flightRouteVisualizer.MarkerSize = 15;
flightRouteVisualizer.Color = [1 0 0];

figure
flightRouteVisualizer.PlotFlightRoute();

waypointRadius = 100;

%% Run simulation
sim(simulinkModelName)

%% Analyze output
t                       = logsout.getElement('x').Values.Time;
X                       = logsout.getElement('x').Values.Data;
V                       = logsout.getElement('V').Values.Data(:,1);
U                       = logsout.getElement('u').Values.Data;
V_d                     = logsout.getElement('V_d').Values.Data(:,1);
theta_d                 = logsout.getElement('theta_d').Values.Data(:,1);
e_V                     = logsout.getElement('e_V').Values.Data(:,1);
e_theta                 = logsout.getElement('e_theta').Values.Data(:,1);
activeWaypointIndex     = logsout.getElement('activeWaypointIndex').Values.Data(:,1);

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

disp('DONE!')