%Christopher Lum
%lum@uw.edu
%
%Visualize a dataset
%
%To activate X-Plane visualization
%
%   1. Start X-Plane 10 (32-bit version) with plugins placed in the
%      Resources\plugins folder
%   2. In X-Plane, F9 to disable physics engine, F5 to start listening for
%      UDP.
%   3. Start Simulink model

%Version History
%02/06/22: Created

clear
clc
close all

simulinkModelName = 'RCAMVisualization_Model.slx';

%Load and extract data
% temp = load('LongitudinalResponse_ShortPeriod.mat');
% temp = load('LongitudinalResponse_Phugoid.mat');
temp = load('LateralDirectionalResponse_DutchRoll.mat');
simX = temp.simX_initialConditions;

%Plot the altitude response
figure
plot(simX.time,simX.signals.values(:,12))

%Package for a 'From Workspace' block
simX_ts = timeseries(simX.signals.values,simX.time);

lat0 = deg2rad(ConvertLatLonDegMinSecToDecimal(47,31,04.37));    %Museum of Flight
lon0 = deg2rad(ConvertLatLonDegMinSecToDecimal(-122,17,46.86));  %Museum of Flight
h0 = 270;

Xgeodetic0 = [lat0;lon0;h0];            %Initial position and altitude
Xned0 = [0;0;-h0];

simulation.x_plane.state_visualization.IP_address                       = '127.0.0.1';
simulation.x_plane.state_visualization.plugin_listening_port_number     = 49003;
simulation.x_plane.state_visualization.numDigitsOfPrecision             = 10;

simulation.t_final      = max(simX.time);
simulation.sample_time  = 0.05;

open_system(simulinkModelName)

disp('FINISHED')


