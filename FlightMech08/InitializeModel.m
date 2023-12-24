%Demonstrate Poisson's Kinematical Equations by implementing in a Simulink
%model.  This script initializes parameters and prepares the model to run.
%
%This script is designed to accompany the YouTube video entitled 'Computing
%Euler Angles: The Euler Kinematical Equations and Poisson’s Kinematical
%Equations' at https://youtu.be/9GZjtfYOXao
%
%Christopher Lum
%lum@uw.edu

%Version History
%03/30/20: Created
%12/23/23: Moved to YouTube GitHub, minor updates

clear
clc
close all

%Load gyro data
load('GyroData.mat')

%Define initial conditions for Euler angles
phi0   = 0;
theta0 = 0.0059;
psi0   = 0;

%Define initial DCM for Poisson's Kinematical Equations
C1v = [cos(psi0) sin(psi0) 0;
    -sin(psi0) cos(psi0) 0;
    0 0 1];
C21 = [cos(theta0) 0 -sin(theta0);
    0 1 0;
    sin(theta0) 0 cos(theta0)];
Cb2 = [1 0 0;
    0 cos(phi0) sin(phi0);
    0 -sin(phi0) cos(phi0)];

Cbv0 = Cb2*C21*C1v;

%Open Simulink model
open('EulerKinematicalEquations')