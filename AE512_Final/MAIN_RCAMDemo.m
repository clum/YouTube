%Christopher Lum
%lum@uw.edu
%
%Demonstrate the RCAM model with joystick and visualization
%
%To activate X-Plane visualization
%
%   1. Start X-Plane 10 (32-bit version) with plugins placed in the
%      Resources\plugins folder
%   2. In X-Plane, F9 to disable physics engine, F5 to start listening for
%      UDP.
%   3. Start Simulink model

%Version History
%03/28/20: Created based on C:\GitHub\LumMatlab\UnitTests\Simulink\UWAerospaceBlockset\AircraftModels\RCAM\TEST_RCAM
%04/09/20: Added missing dependencies
%06/02/20: Removed dependency on UDP toolbox
%01/02/21: Verified that this still works in preparation for AA516.
%03/08/21: Moved to isolated folder
%03/08/22: Added initialization script
%02/15/25: Updated for 2025.  Added dummy state outputs

clear
clc
close all

simulinkModelName = 'RCAMDemo_Interface.slx';

%FILL ME IN
lat0 = deg2rad(ConvertLatLonDegMinSecToDecimal(47,31,04.37));    %Museum of Flight
lon0 = deg2rad(ConvertLatLonDegMinSecToDecimal(-122,17,46.86));  %Museum of Flight
h0 = 500;

Xgeodetic0 = [lat0;lon0;h0];            %Initial position and altitude
Xned0 = [0;0;-h0];

simulation.t_final                                                      = 60;           %final time of sim
simulation.sample_time                                                  = 0.05;
simulation.x_plane.state_visualization.IP_address                       = '127.0.0.1';
simulation.x_plane.state_visualization.plugin_listening_port_number     = 49003;
simulation.x_plane.state_visualization.numDigitsOfPrecision             = 10;

disp(['Now manually run ',simulinkModelName,' (ensure Joystick is plugged in)'])
open_system(simulinkModelName)

disp('FINISHED')


