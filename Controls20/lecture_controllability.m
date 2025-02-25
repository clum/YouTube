%Christopher Lum
%lum@uw.edu
%
%Illustrate controllability

%Version History
%03/02/14: Created
%02/05/15: Updated
%05/23/19: Major updates.  Added PHB test
%05/24/19: Updated documentation

clear
clc
close all

%% Example 1: Controllable System
disp('Example 1')

A = [0 3;
    2 4];

B = [-2;
    1];

%Use Matlab's ctrb to compute the controllability matrix
Pc = ctrb(A, B)

%Calculate Pc by hand to check
Pc_check = [B A*B];
max(max(Pc-Pc_check))

%Compute matrix rank
rank(Pc)

%% Example 2: Uncontrollable System
disp('Example 2')

m = 1;
k1 = 1;
k2 = 4;

A = [0 1 0 0;
    -k1/m 0 0 0;
    0 0 0 1;
    0 0 -k2/m 0];

B = [0;
    1/m;
    0;
    0];

Pc = ctrb(A,B)
rank(Pc)

%% Example 3:  Make Uncontrollable System Controllable
disp('Example 3')

B = [0  0;
    1/m 0;
    0   0;
    0   1/m];

Pc = ctrb(A,B)
rank(Pc)

%% Example 4:  Make Uncontrollable System Controllable Using Single Input
disp('Example 4')

B = [0;
    1/m;
    0;
    1/m];

Pc = ctrb(A,B)
rank(Pc)

%Simulate to show it is still possible to move state to arbitrary location
x0 = [0;0;0;0];

sim('controllability_model.slx')

t = simX.time;
X = simX.Data;
u = simU.Data;

figure
subplot(5,1,1)
plot(t,u,'LineWidth',2)
legend('u')
grid on

subplot(5,1,2)
plot(t,X(:,1),'LineWidth',2)
legend('x_1')
grid on

subplot(5,1,3)
plot(t,X(:,2),'LineWidth',2)
legend('x_2')
grid on

subplot(5,1,4)
plot(t,X(:,3),'LineWidth',2)
legend('x_3')
grid on

subplot(5,1,5)
plot(t,X(:,4),'LineWidth',2)
legend('x_4')
grid on

xFinal = X(end,:)'

%% Example 5: Symmetry Makes System Uncontrollable with Single Input 
disp('Example 5')

k1 = 1/3;
k2 = 1/3;

A = [0 1 0 0;
    -k1/m 0 0 0;
    0 0 0 1;
    0 0 -k2/m 0];

Pc = ctrb(A,B)
rank(Pc)

%% Example 6: PBH Test
disp('Example 6')

A = [1 2 3;
    2 1 0;
    0 2 4]      

[V,D] = eig(A);

lambda1 = D(1,1);
lambda2 = D(2,2);
lambda3 = D(3,3);

v1 = V(:,1);
v2 = V(:,2);
v3 = V(:,3);

%Verify eigenvalue/eigenvector pairs
(A - lambda1*eye(3))*v1
(A - lambda2*eye(3))*v2
(A - lambda3*eye(3))*v3

%Compute the range of (A - lamba_i*I)
rangeAminusLambda1I = orth((A - lambda1*eye(3)))
rangeAminusLambda2I = orth((A - lambda2*eye(3)))
rangeAminusLambda3I = orth((A - lambda3*eye(3)))

%----------------Visualize range(A - lamba1*I)-----------------------------
figure
hold on
grid on
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')
view([75 30])

options1.Color = [1 0 0];
options1.DrawVectors = true;
PlotSpan(rangeAminusLambda1I(:,1), rangeAminusLambda1I(:,2), options1)

%------------Draw all range(A - lamba_i*I) without arrows------------------
figure
hold on
grid on
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')
view([75 30])

%Draw range(A - lamba1*I)
options1.Color = [1 0 0];
options1.DrawVectors = false;
PlotSpan(rangeAminusLambda1I(:,1), rangeAminusLambda1I(:,2), options1)

%Draw range(A - lamba2*I)
options2.Color = [0 1 0];
options2.DrawVectors = false;
PlotSpan(rangeAminusLambda2I(:,1), rangeAminusLambda2I(:,2), options2)

%Draw range(A - lamba3*I)
options3.Color = [0 0 1];
options3.DrawVectors = false;
PlotSpan(rangeAminusLambda3I(:,1), rangeAminusLambda3I(:,2), options3)

%Choose a B in one of the ranges, will be uncontrollable
B_uncontrollable = -0.8*rangeAminusLambda1I(:,1) + 1.2*rangeAminusLambda1I(:,2);
rank(ctrb(A, B_uncontrollable)) 
plot3([0 B_uncontrollable(1)], [0 B_uncontrollable(2)], [0 B_uncontrollable(3)], '-', 'Color', [193 0 232]./255, 'LineWidth', 10)

%Chose a B that is outside of ranges (will be controllable
B_controllable = [0.1;-0.25;1];
rank(ctrb(A, B_controllable))
plot3([0 B_controllable(1)], [0 B_controllable(2)], [0 B_controllable(3)], '-', 'Color', [232 187 41]./255, 'LineWidth', 10)

%--------------------Plot how the eigenvectors align-----------------------
figure
hold on
grid on
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')
view([75 30])

%Draw range(A - lamba1*I)
options1.Color = [1 0 0];
options1.DrawVectors = false;
PlotSpan(rangeAminusLambda1I(:,1), rangeAminusLambda1I(:,2), options1)

%Draw range(A - lamba2*I)
options2.Color = [0 1 0];
options2.DrawVectors = false;
PlotSpan(rangeAminusLambda2I(:,1), rangeAminusLambda2I(:,2), options2)

%Draw range(A - lamba3*I)
options3.Color = [0 0 1];
options3.DrawVectors = false;
PlotSpan(rangeAminusLambda3I(:,1), rangeAminusLambda3I(:,2), options3)

%Check rank-nullity theorem
rank([(A - lambda1*eye(3)) v1])
rank([(A - lambda2*eye(3)) v2])
rank([(A - lambda3*eye(3)) v3])

%Draw eigenvectors
plot3([0 v1(1)], [0 v1(2)], [0 v1(3)], '-', 'Color', options1.Color, 'LineWidth', 10)
plot3([0 v2(1)], [0 v2(2)], [0 v2(3)], '-', 'Color', options2.Color, 'LineWidth', 10)
plot3([0 v3(1)], [0 v3(2)], [0 v3(3)], '-', 'Color', options3.Color, 'LineWidth', 10)

v1v2v3 = v1 + v2 + v3;
plot3([0 v1v2v3(1)], [0 v1v2v3(2)], [0 v1v2v3(3)], '-', 'Color', [232 187 41]./255, 'LineWidth', 10)

%Show that eigenvectors by themselves are not controllable but a
%combination of them are
rank(ctrb(A, v1))
rank(ctrb(A, v2))
rank(ctrb(A, v3))

rank(ctrb(A,v1v2v3))

%% Example 7: Eigenvalue Multiplicity of Symmetric System
k1 = 1/3;
k2 = 1/3;

A = [0 1 0 0;
    -k1/m 0 0 0;
    0 0 0 1;
    0 0 -k2/m 0];

Pc = ctrb(A,B)
rank(Pc)

[V,D] = eig(A)

diag(V)

disp('DONE!')