%Christopher Lum
%lum@uw.edu
%
%Illustrate Rodrigues' Rotation Formula.
%This is also known as Goldstein's Rotation of a Vector Formula.
%
%This file is designed to accompany the YouTube video at
%https://youtu.be/Fh3nMi87cB8

%Version History
%12/17/18: Created from lecture notes to accompany YouTube
%12/23/18: Updated documentation
%01/04/19: Added YouTube URL

clear
clc
close all

%Define normal vector n
n = [1;1;0.5];
n = (1/norm(n))*n;  %n needs to be a unit vector

%Define vector u
u = [2;2;-1];       %does not need to be a unit vector

%Define range of angles to rotate through
mu_range = linspace(0,2*pi,50);

%Rotate u around vector n
figure
for i=1:length(mu_range)
    clf;
    hold on
       
    %Get the current rotation angle
    mu = mu_range(i);
    
    %Apply Goldstein's rotation of a vector formula (Equation 1.2-6 in
    %Stevens and Lewis) (AKA Rodrigues' Rotation Formula)
    v = (1 - cos(mu))*dot(n, u)*n + cos(mu)*u - sin(mu)*cross(n, u);
    
    %Draw u
    plot3([0 u(1)],[0 u(2)], [0 u(3)], 'r-', 'LineWidth', 2);
    
    %Draw n
    plot3([0 n(1)],[0 n(2)], [0 n(3)], 'g-', 'LineWidth', 2);
    
    %Draw v
    plot3([0 v(1)],[0 v(2)], [0 v(3)], 'b-', 'LineWidth', 2);
    
    legend('u','n','v')
    
    xlabel('x')
    ylabel('y')
    zlabel('z')
    grid on
    title('Rotation of u around n')
    axis equal

    view([35 15])
    axis([-norm(u) norm(u) -norm(u) norm(u) -norm(u) norm(u)])
    
    drawnow
end
