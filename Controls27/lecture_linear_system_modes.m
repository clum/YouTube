%Christopher Lum
%lum@uw.edu
%
%Illustrate how to excite specific modes of a system.

%Version History
%01/22/22: Created

clear
clc
close all

tic

% scenario = 'arbitraryIC';
scenario = 'mode_1';
% scenario = 'mode_2_3';

A = [-7 4 5;
    -3 3 3;
    -7 3 5];

switch scenario
    case 'arbitraryIC'
        x0 = [1;
            0.01;
            1];
        
        tFinal = 5;
        
    case 'mode_1'
        x0 = [1;
            0;
            1];
        
        tFinal = 100;
        
    case 'mode_2_3'
        x0 = [1;
            0;
            2];
        
        tFinal = 5;
        
    otherwise
        error('Unsupported scenario')
end

simout = sim('linear_system_modes_model');

simout_x = simout.simout_x;

t = simout_x.Time;
x1 = simout_x.Data(:,1);
x2 = simout_x.Data(:,2);
x3 = simout_x.Data(:,3);

figure
subplot(3,1,1)
plot(t,x1)
grid on

subplot(3,1,2)
plot(t,x2)
grid on

subplot(3,1,3)
plot(t,x3)
grid on

toc
disp('DONE!')