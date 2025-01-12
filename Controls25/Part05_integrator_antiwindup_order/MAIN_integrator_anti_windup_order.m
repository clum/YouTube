%Show that order of limited integrator and KI gain matter.
%
%Christopher Lum
%lum@uw.edu

%Version History:   
%05/15/21: Created

clear
clc
close all

step_time       = 5;
step_duration   = 2;
step_magnitude  = 5;

integrator_upper_limit = 4;
integrator_lower_limit = -4;

KI = 2;

sim('integrator_anti_windup_order_model')

disp('DONE!')