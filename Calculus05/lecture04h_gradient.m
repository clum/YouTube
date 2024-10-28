%Demonstrate gradient
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/20/23: Created
%10/21/23: Changed to scale vector rather than normalize it

clear
clc
close all

%% Visualize gradient at a single point
xo = -3;
yo = 2;

viewPoint_isometric = [-30 25];
figure;
visualize_gradient(xo,yo,viewPoint_isometric)

%% Animate gradient as point moves
viewPoint_top = [0 90];

t = linspace(0,2*pi,15);
xo_data = 4*cos(t);
yo_data = 4*sin(t);

figure;
for k=1:length(t)
    xo = xo_data(k);
    yo = yo_data(k);
    
    subplot(1,2,1)
    visualize_gradient(xo,yo,viewPoint_isometric);
    
    subplot(1,2,2)
    visualize_gradient(xo,yo,viewPoint_top);
    
    pause(0.5)
end

disp('DONE!')