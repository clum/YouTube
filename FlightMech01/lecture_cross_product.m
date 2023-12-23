%Christopher Lum
%lum@uw.edu
%
%Illustrate cross product

%Version History
%09/25/08: Created
%03/30/15: Updated
%12/30/20: Output as a movie so I can use it in a YouTube video
%12/23/23: Minor bug fix regarding movie file name

clear
clc
close all

disp('Cross Product')

%Setup plotting parameters
u_arrow_params = [1; 1; 0; 0; 0.15; 4];
v_arrow_params = [1; 0; 1; 0; 0.15; 4];
n_arrow_params = [1; 0; 0; 1; 0.15; 4];

%Define vector u
u = [1;0;0];
u = (1/norm(u))*u;

N = 200;
theta = linspace(0,4*pi,N);

figure
for k=1:length(theta)
    clf
    theta_curr = theta(k);
    v = [cos(theta_curr) sin(theta_curr) 0]';
    
    n = cross(u,v);
    DrawArrow(0, 0, 0, u(1), u(2), u(3), u_arrow_params);
    DrawArrow(0, 0, 0, v(1), v(2), v(3), v_arrow_params);
    DrawArrow(0, 0, 0, n(1), n(2), n(3), n_arrow_params);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
    title('Cross Product')
    axis equal
    view([30 30])
    axis([-1.1 1.1 -1.1 1.1 -1.1 1.1])
    title('u \times v.  u = red, v = green, u \times v = blue')
    movieVector(k) = getframe;
end

%% Create a VideoWriter object and set properties
movieFileName = 'lecture_cross_product';
myWriter = VideoWriter(movieFileName, 'MPEG-4');
myWriter.FrameRate = 30;

%Open the VideoWriter object, write the movie, and close the file
open(myWriter);
writeVideo(myWriter, movieVector);
close(myWriter);

disp('DONE!')