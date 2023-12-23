%Christopher Lum
%lum@uw.edu
%
%Illustrate rotating to the new coordinate frame by rotating about a single
%axis.

%Version History    
%03/27/20: Created
%12/23/23: Switched to use MatlabLum.  Moved to YouTube GitHub.

clear
clc
close all

tic

disp('Euler Rotation Sequence')

%Setup plotting parameters
Fv_params.x_axis_color = [255 0 0]/255;
Fv_params.y_axis_color = [226 93 93]/255;
Fv_params.z_axis_color = [226 154 154]/255;
Fv_params.scale_factor = 1;
Fv_params.line_width = 4;
Fv_params.plot_type = 1;

Fb_params.x_axis_color = [0 0 255]/255;
Fb_params.y_axis_color = [108 108 255]/255;
Fb_params.z_axis_color = [179 179 255]/255;
Fb_params.scale_factor = 1;
Fb_params.line_width = 4;
Fb_params.plot_type = 1;

translation = [0;0;0];

%Define rotation angles
psi = 70*pi/180;
theta = 130*pi/180;
phi = 25*pi/180;

%Compute Cbv
C1v = [cos(psi) sin(psi) 0;
    -sin(psi) cos(psi) 0;
    0 0 1];

C21 = [cos(theta) 0 -sin(theta);
    0 1 0;
    sin(theta) 0 cos(theta)];

Cb2 = [1 0 0;
    0 cos(phi) sin(phi);
    0 -sin(phi) cos(phi)];

Cbv = Cb2*C21*C1v;

%Get eigenvalues and eigenvectors
[V,D] = eig(Cbv)

idxUnityEigenvalue = 3;
lambda = D(idxUnityEigenvalue,idxUnityEigenvalue);
v = V(:,idxUnityEigenvalue);

tol = 10e-6;
assert(LumFunctionsMisc.AreValuesApproximatelyEqual(lambda,1,tol))
assert(max(abs(Cbv*v - lambda*v))<tol)

%Draw Fv and Fb
figure

%Rotate the x-axis about v using Rodriges
mu = linspace(0,233.5*pi/180,50);

euler_angle = [phi; theta; psi];
for k=1:length(mu)
    clf
    
    %Draw Fb
    DrawFrame(euler_angle, translation, Fb_params);
    
    %Draw Fv
    DrawFrame([0; 0; 0], translation, Fv_params);
    
    grid on
    xlabel('x_{v}')
    ylabel('y_{v}')
    zlabel('z_{v}')
    axis([-1 1 -1 1 -1 1])
    
    %Draw the axis of rotation
    n = v;      %axis of rotation
    hold on
    plot3([0 n(1)],[0 n(2)],[0 n(3)],'m-','LineWidth', 8)

    %x-axis
    u = [0.75;0;0];    
    vp = (1-cos(mu(k)))*dot(u,n)*n + cos(mu(k))*u - sin(mu(k))*cross(n,u);    
    plot3([0 vp(1)],[0 vp(2)],[0 vp(3)],'g-','LineWidth', 8)
    
    %y-axis
    u = [0;0.75;0];    
    vp = (1-cos(mu(k)))*dot(u,n)*n + cos(mu(k))*u - sin(mu(k))*cross(n,u);    
    plot3([0 vp(1)],[0 vp(2)],[0 vp(3)],'g-','LineWidth', 8)
    
    %z-axis
    u = [0;0;0.75];    
    vp = (1-cos(mu(k)))*dot(u,n)*n + cos(mu(k))*u - sin(mu(k))*cross(n,u);    
    plot3([0 vp(1)],[0 vp(2)],[0 vp(3)],'g-','LineWidth', 8)
        
    title(['\mu = ',num2str(mu(k)*180/pi),' deg'])
    pause(0.05);
end

toc
disp('DONE!')
