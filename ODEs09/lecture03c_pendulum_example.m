%Christopher Lum
%lum@uw.edu
%
%Illustrate nonlinear and linear pendulum system

%Version History
%10/19/09: Created
%10/14/10: Added animation aspect
%10/15/12: Updated
%10/16/12: Updated
%10/15/13: Removed animation code for AE501
%10/16/17: Updated comments/documentation
%10/02/20: Updated for YouTube

clear
clc
close all

%Define constants and intial conditions
m           = 1;            %mass (kg)
b           = 0.1;          %damping coefficient
L           = 0.5;          %length (m)
g           = 9.81;         %gravity (m/s^2)

%Compute zeta and wn to get an idea of how this systems should behave
wn = sqrt(g/L);
zeta = b/(2*m*L^(3/2)*sqrt(g));
wd = wn*sqrt(1-zeta^2);

%Initial conditions for the model
theta0      = 190*pi/180;    %initial displacement (rad)
thetaDot0   = 0*pi/180;     %initial velocity (rad/s)

%Run the simulink model
dtMax = 0.01;
sim('lecture03c_pendulum_example_model')

%Extract data
t               = simThetaNonlinear.time;
theta_nonlinear = simThetaNonlinear.signals.values(:,1);
theta_linear    = simThetaLinear.signals.values(:,1);

%% Check that the decrement ratio can be used to estimate the damping ratio
%Find the maximums
idxStart = min(find(t>1.5));

%Find when the signal is rising
for k=idxStart:length(t)
    if(theta_nonlinear(k+1) - theta_nonlinear(k) > 0)
        %rising
        idx = k;
        break
    end
end

for k=idx:length(t)
    %Find when the signal starts falling
    if(theta_nonlinear(k+1) - theta_nonlinear(k) < 0)
        idxPeak1 = k;
        break
    end
end

%Find the next peak
for k=idxPeak1:length(t)
    if(theta_nonlinear(k+1) - theta_nonlinear(k) > 0)
        %rising
        idx = k;
        break
    end
end

for k=idx:length(t)
    %Find when the signal starts falling
    if(theta_nonlinear(k+1) - theta_nonlinear(k) < 0)
        idxPeak2 = k;
        break
    end
end

%What is the decrement ratio
% eta = theta_linear(idxPeak2)/theta_linear(idxPeak1);
eta = theta_nonlinear(idxPeak2)/theta_nonlinear(idxPeak1);
zetaMeasured = -log(eta)/sqrt(4*pi^2+log(eta)^2);
bMeasured = 2*zetaMeasured*m*L^(3/2)*sqrt(g);

disp(['zeta (actual)  zeta (measured)'])
disp([zeta zetaMeasured])
disp(' ')

disp(['b (actual)  b (measured)'])
disp([b bMeasured])
disp(' ')

%% Plot the data
figure
hold on
plot(t, theta_nonlinear*180/pi, 'LineWidth', 2)
plot(t, theta_linear*180/pi, 'LineWidth', 2)
plot(t(idxPeak1),theta_nonlinear(idxPeak1)*180/pi, '^', 'MarkerSize', 15, 'LineWidth', 2)
plot(t(idxPeak2),theta_nonlinear(idxPeak2)*180/pi, '+', 'MarkerSize', 15, 'LineWidth', 2)
xlabel('Time (sec)')
ylabel('\theta (deg)')
legend('Nonlinear','Linear','Peak 1','Peak 2')
grid on

disp('DONE')