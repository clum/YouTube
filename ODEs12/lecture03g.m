%Numerically verify the analytical solution
%
%Christopher Lum
%lum@uw.edu

%Version History
%09/01/22: Created
%09/18/22: Updating analytical expressions for alternate format.

clear
clc
close all

tic

A = [-2 1;
    -1 2];

B = [3 -2;
    1 1];

C = eye(2);

D = zeros(2,2);

x0 = [3;
    -2];

simulinkModel = 'lecture03g_model';

%Simulate system
tFinal_s    = 0.5;
alpha       = 2;
w           = 10;
m           = 20;
results = sim(simulinkModel);

simU = results.simU;
simX = results.simX;

t   = simX.Time;

u1 = simU.Data(:,1);
u2 = simU.Data(:,2);

x1  = simX.Data(:,1);
x2  = simX.Data(:,2);

%Compare with analytical solution
x1_analytical = 40/3 - (3013/618)*exp(-sqrt(3)*t) - (3764*exp(-sqrt(3)*t))/(309*sqrt(3)) - (3013*exp(sqrt(3)*t))/618 + (3764*exp(sqrt(3)*t))/(309*sqrt(3)) - (100*t)/3 - (60/103)*cos(10*t) + (10/103)*sin(10*t);
x2_analytical = -(20/3) + (751/309)*exp(-sqrt(3)*t) - (6017*exp(-sqrt(3)*t))/(618*sqrt(3)) + (751*exp(sqrt(3)*t))/309 + (6017*exp(sqrt(3)*t))/(618*sqrt(3)) - (80*t)/3 - (20/103)*cos(10*t) + (2/103)*sin(10*t);

%Visualize results
figure
subplot(2,1,1)
plot(t,u1)
legend('u_1')
grid on

subplot(2,1,2)
plot(t,u2)
legend('u_2')
grid on

figure
subplot(2,1,1)
hold on
plot(t,x1)
plot(t,x1_analytical)
legend('x_1 (numerical)','x_1 (analytical)')
grid on

subplot(2,1,2)
hold on
plot(t,x2)
plot(t,x2_analytical)
legend('x_2 (numerical)','x_2 (analytical)')
grid on

figure
subplot(2,1,1)
plot(t,x1-x1_analytical)
legend('x_1 difference')
grid on

subplot(2,1,2)
plot(t,x2-x2_analytical)
legend('x_2 difference')
grid on

toc