%Demonstrate using the MatlabLum SDK.
%
%This accompanies the YouTube video entitled 'Obtaining and Using the
%MatlabLum Repository' at TBD
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/24/23: Created

clear
clc
close all

tic

%% Step 1: Clone the MatlabLum repo from https://github.com/clum/MatlabLum

%% Step 2: Add paths associated with MatlabLum
cwd = pwd;
cd('..\..\MatlabLum')
disp(['Changed directory to ',pwd])

AddPathsMatlabLum();

%Change directory back
cd(cwd);
disp(['Changed directory to ',pwd])

%% Step 3: Use functionality from MatlabLum
W = [3 1 2 1 5];
N = 1000;
indices = RouletteWheel(W,N);

figure
hist(indices,[1:length(W)])

toc
disp('DONE!')