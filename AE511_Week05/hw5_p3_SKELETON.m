%Simulation of Bang/bang with hysteresis deadband for temperature control.
%
%Christopher Lum
%lum@uw.edu

%Version History
%02/04/25: Created

clear
clc
close all

%% User settings
simulinkModel               = 'hw5_p3_open_loop_model_SKELETON.slx';

deltaT_s                    = 0.01;
tFinal_s                    = 420;

%Plant parameters
K                           = 49;
zeta                        = 1.5;
wn                          = 0.03;
Tdelay_s                    = 1.2;
Tambient_C                  = 24.1875;
noisePower                  = .00001;

%% Simulate
simout = sim(simulinkModel);

%% Analyze results
logsout = simout.logsout;

u               = simout.logsout.getElement('u');
temperatureTC_C = simout.logsout.getElement('temperatureTC_C');

t_s             = u.Values.Time;
u               = u.Values.Data;
tempTC_C        = temperatureTC_C.Values.Data;

%Plot
figure
subplot(2,1,1);
hold on
plot(t_s,tempTC_C,'DisplayName','tempTC\_C','LineWidth',2)
legend('Location','best')
grid on
ylabel('Temp (C)')

subplot(2,1,2);
hold on
plot(t_s,u,'DisplayName','u','LineWidth',2)
legend('Location','best')
grid on
ylabel('u')
