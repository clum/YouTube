%Christopher Lum
%lum@uw.edu
%
%Illustrate rotation of a vector.  For more information, see
%Aircraft Control and Simulation 2nd Edition by Stevens and Lewis, page 8.
%
%This is an alterative version of the script (RodriguesRotationFormula.m)
%which shows the rotation as a 3-view.

%Version History
%06/11/07: Created
%06/18/07: Created 3 views
%12/14/07: Made consistent with rest of class
%09/25/08: Updated for 2008
%03/30/15: Updated for AE512
%12/23/23: Moved to YouTube GitHub

clear
clc
close all

disp('Rotation of a Vector')

%Setup plotting parameters
u_arrow_params = [1; 1; 0; 0; 0.15; 2];
v_arrow_params = [1; 0; 1; 0; 0.15; 2];
n_arrow_params = [1; 0; 0; 1; 0.15; 2];

%Define normal vector n
n = [1;0;0];
n = (1/norm(n))*n;

%Define vector u
u = [1;0.25;0.25];
u = (1/norm(u))*u;

%Define range of angles to rotate through
mu_range = linspace(0,2*pi,50);

%Rotate u around vector n
figure
for i=1:length(mu_range)
    clf;
    
    %Get the current rotation angle
    mu = mu_range(i);
    
    %Equation 1.2-6
    subplot(2,2,1)
    v = (1 - cos(mu))*n*dot(n, u) + cos(mu)*u - sin(mu)*cross(n, u);
    DrawArrow(0, 0, 0, u(1), u(2), u(3), u_arrow_params);
    hold on
    DrawArrow(0, 0, 0, v(1), v(2), v(3), v_arrow_params);
    DrawArrow(0, 0, 0, n(1), n(2), n(3), n_arrow_params);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
    title('Rotation of u around n')
    axis equal
    view([0 90])
    axis([-norm(u) norm(u) -norm(u) norm(u) -norm(u) norm(u)])
    
    subplot(2,2,2)
    v = (1 - cos(mu))*n*dot(n, u) + cos(mu)*u - sin(mu)*cross(n, u);
    DrawArrow(0, 0, 0, u(1), u(2), u(3), u_arrow_params);
    hold on
    DrawArrow(0, 0, 0, v(1), v(2), v(3), v_arrow_params);
    DrawArrow(0, 0, 0, n(1), n(2), n(3), n_arrow_params);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
    title('Rotation of u around n')
    axis equal
    view([0 0])
    axis([-norm(u) norm(u) -norm(u) norm(u) -norm(u) norm(u)])

    subplot(2,2,3)
    v = (1 - cos(mu))*n*dot(n, u) + cos(mu)*u - sin(mu)*cross(n, u);
    DrawArrow(0, 0, 0, u(1), u(2), u(3), u_arrow_params);
    hold on
    DrawArrow(0, 0, 0, v(1), v(2), v(3), v_arrow_params);
    DrawArrow(0, 0, 0, n(1), n(2), n(3), n_arrow_params);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
    title('Rotation of u around n')
    axis equal
    view([90 0])
    axis([-norm(u) norm(u) -norm(u) norm(u) -norm(u) norm(u)])
    
    subplot(2,2,4)
    v = (1 - cos(mu))*n*dot(n, u) + cos(mu)*u - sin(mu)*cross(n, u);
    DrawArrow(0, 0, 0, u(1), u(2), u(3), u_arrow_params);
    hold on
    DrawArrow(0, 0, 0, v(1), v(2), v(3), v_arrow_params);
    DrawArrow(0, 0, 0, n(1), n(2), n(3), n_arrow_params);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
    title('Rotation of u around n')
    axis equal
    view([30 45])
    axis([-norm(u) norm(u) -norm(u) norm(u) -norm(u) norm(u)])

    drawnow
end
