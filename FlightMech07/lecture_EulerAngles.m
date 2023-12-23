%Christopher Lum
%lum@uw.edu
%
%Illustrate Euler rotation sequence.

%Version History    
%06/20/07: Created
%12/14/07: Updated to be consistent with rest of class
%10/06/08: Updated for 2008
%10/11/11: Updated for 2011
%03/31/15: Updated for AE512
%03/27/20: Updated for AE512
%03/28/20: More updates to prepare for YouTube recording
%12/23/23: Moved to YouTube GitHub

clear
clc
close all

disp('Euler Rotation Sequence')

%Setup plotting parameters
Fv_params.x_axis_color = [255 0 0]/255;
Fv_params.y_axis_color = [226 93 93]/255;
Fv_params.z_axis_color = [226 154 154]/255;
Fv_params.scale_factor = 1;
Fv_params.line_width = 4;
Fv_params.plot_type = 1;

F1_params.x_axis_color = [0 255 0]/255;
F1_params.y_axis_color = [131 255 131]/255;
F1_params.z_axis_color = [189 255 189]/255;
F1_params.scale_factor = 1;
F1_params.line_width = 4;
F1_params.plot_type = 1;

F2_params.x_axis_color = [255 110 0]/255;
F2_params.y_axis_color = [255 163 92]/255;
F2_params.z_axis_color = [255 200 158]/255;
F2_params.scale_factor = 1;
F2_params.line_width = 4;
F2_params.plot_type = 1;

Fb_params.x_axis_color = [0 0 255]/255;
Fb_params.y_axis_color = [108 108 255]/255;
Fb_params.z_axis_color = [179 179 255]/255;
Fb_params.scale_factor = 1;
Fb_params.line_width = 4;
Fb_params.plot_type = 1;

euler_angles = [0;0;0];
translation = [0;0;0];

%Define rotation angles
psi_end = 70*pi/180;
N_psi = 60;

theta_end = 130*pi/180;
N_theta = 60; 

phi_end = 25*pi/180;
N_phi = 50;

psi_range   = linspace(0, psi_end,N_psi);
theta_range = linspace(0, theta_end, N_theta);
phi_range     = linspace(0, phi_end, N_phi);

%Draw Fv
figure
DrawFrame([0; 0; 0], translation, Fv_params);
grid on
xlabel('x_{v}')
ylabel('y_{v}')
zlabel('z_{v}')
axis([-1 1 -1 1 -1 1])
title('F_v')

%Rotation from Fv to F1
figure
for psi_k=1:N_psi  
    clf
       
    %Draw Fv
    DrawFrame([0; 0; 0], translation, Fv_params);
    
    %Draw F1
    euler_angle = [0; 0; psi_range(psi_k)];
    DrawFrame(euler_angle, translation, F1_params);
    
    grid on
    xlabel('x_{v}')
    ylabel('y_{v}')
    zlabel('z_{v}')
    axis([-1 1 -1 1 -1 1])
    title(['Rotation from F_v to F_1.  \psi = ',num2str(rad2deg(psi_range(psi_k)))])
    drawnow
end

%Rotation from F1 to F2
figure
for theta_k=1:N_theta  
    clf
       
    %Draw F1
    DrawFrame([0; 0; psi_end], translation, F1_params);
    
    %Draw F2
    euler_angle = [0; theta_range(theta_k); psi_end];
    DrawFrame(euler_angle, translation, F2_params);
    
    grid on
    xlabel('x_{v}')
    ylabel('y_{v}')
    zlabel('z_{v}')
    axis([-1 1 -1 1 -1 1])
    title(['Rotation from F_1 to F_2.  \theta = ',num2str(rad2deg(theta_range(theta_k)))])
    drawnow
end

%Rotation from F2 to Fb
figure
for phi_k=1:N_phi
    clf
       
    %Draw F2
    DrawFrame([0; theta_end; psi_end], translation, F2_params);
    
    %Draw Fb
    euler_angle = [phi_range(phi_k); theta_end; psi_end];
    DrawFrame(euler_angle, translation, Fb_params);
    
    grid on
    xlabel('x_{v}')
    ylabel('y_{v}')
    zlabel('z_{v}')
    axis([-1 1 -1 1 -1 1])
    title(['Rotation from F_2 to F_b.  \phi = ',num2str(rad2deg(phi_range(phi_k)))])
    drawnow
end

%Draw Fv and Fb
figure

%Draw Fb
euler_angle = [phi_end; theta_end; psi_end];
DrawFrame(euler_angle, translation, Fb_params);

%Draw Fv
DrawFrame([0; 0; 0], translation, Fv_params);

grid on
xlabel('x_{v}')
ylabel('y_{v}')
zlabel('z_{v}')
axis([-1 1 -1 1 -1 1])
title(['F_b and F_v with \psi = ',num2str(psi_end*180/pi),' deg, \theta = ',num2str(theta_end*180/pi),' deg, and \phi = ',num2str(phi_end*180/pi),' deg.'])

disp('DONE!')
