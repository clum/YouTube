%Christopher Lum
%lum@uw.edu
%
%Illustrate cross product

%Version History
%12/28/20: Created
%12/21/23: Updated for YouTube (removed call to SaveAllFigures)

clear
clc
close all

disp('Scalar Projection')

u = [1 3]';
v = [5 2]';

comp_v_u = u'*v/norm(v)

disp('Vector Projection')
proj_v_u = comp_v_u*v/norm(v);

disp('norm(proj_v_u)')
norm(proj_v_u)

%Plots
figure
hold on
plot([0 u(1)],[0 u(2)],'r-','LineWidth',2)
plot([0 v(1)],[0 v(2)],'g-','LineWidth',2)
plot([0 proj_v_u(1)],[0 proj_v_u(2)],'b-','LineWidth',4)
legend('u','v','proj_v u')
grid on
xlabel('x')
ylabel('y')
axis equal

disp('DONE!')