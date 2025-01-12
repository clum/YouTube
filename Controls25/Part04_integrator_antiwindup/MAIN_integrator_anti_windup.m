%Show that the term 'limit output' is misleading.
%
%Christopher Lum
%lum@uw.edu

%Version History:   
%02/18/11: Created
%12/28/11: Updated for 2012
%02/06/14: Updated for 2014
%02/03/14: Updated for 2015
%03/06/17: Updated for 2017
%05/21/19: Updated for 2019
%05/15/21: Updated for 2021 and YouTube

clear
clc
close all

step_time       = 5;
step_duration   = 2;
step_magnitude  = 5;

integrator_upper_limit = 4;
integrator_lower_limit = -4;

sim('integrator_anti_windup_model')

disp('DONE!')