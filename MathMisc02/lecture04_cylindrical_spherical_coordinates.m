%Christopher Lum
%lum@u.washington.edu
%
%Illustrate cylindrical and spherical coordinates
%
%See also
%TEST_CylindricalToCartesianCoordinates
%TEST_SphericalToCartesianCoordinates

%Version History    10/11/13: Created
%                   10/21/13: Updated

clear
clc
close all

selection = 2;

%------------------Illustrate cylindrical coordinates----------------------
if(selection==1)
    N = 50;
    r_p = 3*ones(1, N);
    theta_p = linspace(0, 2*pi, N);
    z_p = -2*ones(1, N);
    
    %what are equivalent cartesian coordinates
    [x_c, y_c, z_c] = CylindricalToCartesianCoordinates(r_p, theta_p, z_p);
        
    %visualize the scenario
    figure
    for k=1:length(x_c)
        
        %Draw the entire curve
        clf
        hold on
        plot3(x_c, y_c, z_c)
        
        %Draw a coordinate system (x,y,z) axes
        params.x_axis_color     = [1 0 0];
        params.y_axis_color     = [0 1 0];
        params.z_axis_color     = [0 0 1];
        params.offset           = [0;0;0];
        params.axis_length      = 2*pi;
        params.line_width       = 2;
        DrawCoordinateSystem(params)
        
        %Draw the point in question
        plot3(x_c(k), y_c(k), z_c(k), 'mx', 'MarkerSize', 15, 'LineWidth', 2)
        
        %Add some legend info
        legend(...
            ['r_p = ',num2str(r_p(k)),' (cylindrical)'],...
            ['\theta_p = ',num2str(radtodeg(theta_p(k))),' deg (cylindrical)'],...
            ['z_p = ',num2str(z_p(k)),' (cylindrical)']...
            )
        
        %Plot parameters
        grid on
        xlabel('x')
        ylabel('y')
        zlabel('z')
        
        view([110 40])
        drawnow()
    end
end

%-------------------Illustrate spherical coordinates-----------------------
if(selection==2)
    N = 50;
    
%     %vary theta
%     r_s = 3*ones(1, N);
%     theta_s = linspace(0, 2*pi, N);
%     phi_s = degtorad(20)*ones(1, N);
    
    %vary phi
    r_s = 3*ones(1, N);
    theta_s = degtorad(225)*ones(1, N);
    phi_s = linspace(0, 2*pi, N);
    
    %what are equivalent cartesian coordinates
    [x_c, y_c, z_c] = SphericalToCartesianCoordinates(r_s, theta_s, phi_s);
    
    
    %visualize the scenario
    figure
    for k=1:length(x_c)
        
        %Draw the entire curve
        clf
        hold on
        plot3(x_c, y_c, z_c)
        
        %Draw a coordinate system (x,y,z) axes
        params.x_axis_color     = [1 0 0];
        params.y_axis_color     = [0 1 0];
        params.z_axis_color     = [0 0 1];
        params.offset           = [0;0;0];
        params.axis_length      = 2*pi;
        params.line_width       = 2;
        DrawCoordinateSystem(params)
        
        %Draw the point in question
        plot3(x_c(k), y_c(k), z_c(k), 'mx', 'MarkerSize', 15, 'LineWidth', 2)
        
        %Add some legend info
        legend(...
            ['r_s = ',num2str(r_s(k)),' (spherical)'],...
            ['\theta_s = ',num2str(radtodeg(theta_s(k))),' deg (spherical)'],...
            ['\phi_s = ',num2str(radtodeg(phi_s(k))),' deg (spherical)']...
            )
        
        %Plot parameters
        grid on
        xlabel('x')
        ylabel('y')
        zlabel('z')
        
        view([110 40])
        drawnow()
    end
end
