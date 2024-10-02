%Visualize row/column spaces
%
%Christopher Lum
%lum@uw.edu

%Version History
%09/17/23: Created

clear
clc
close all

%Define matrix
A = [1 2 0;
    9 18 -6
    12 24 -6];

%% Row space
r1 = [1 2 0];
r2 = [0 0 1];

r1 = r1/norm(r1);
r2 = r2/norm(r2);

v1 = [1 2 0];
v2 = [9 18 -6];

v1 = v1/norm(v1);
v2 = v2/norm(v2);

%Visualize row space by randomly computing b = x*A
figure
hold on
plot3([0 r1(1)], [0 r1(2)], [0 r1(3)], 'g-', 'LineWidth', 4)
plot3([0 r2(1)], [0 r2(2)], [0 r2(3)], 'r-', 'LineWidth', 4)

plot3([0 v1(1)], [0 v1(2)], [0 v1(3)], 'm-', 'LineWidth', 4)
plot3([0 v2(1)], [0 v2(2)], [0 v2(3)], 'c-', 'LineWidth', 4)

for k=1:100
    %Generate random x values in range [-1,1]
    x = 2*(rand(1,3) - 0.5);
    b = x*A;
    
    b = b/norm(b);
        
    plot3([0 b(1)], [0 b(2)], [0 b(3)], 'b-', 'LineWidth', 1)    
end

grid on
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')
legend('r_1','r_2','v_1','v_2','b = x*A')
view([110 20])
title('Row Space')





%% Column space
c1 = [1;9;12];
c3 = [0;-6;-6];

c1 = c1/norm(c1);
c3 = c3/norm(c3);

d1 = [1;0;3];
d2 = [0;1;1];

d1 = d1/norm(d1);
d2 = d2/norm(d2);

%Visualize column space by randomly computing b = A*x
figure
hold on
plot3([0 c1(1)], [0 c1(2)], [0 c1(3)], 'g-', 'LineWidth', 4)
plot3([0 c3(1)], [0 c3(2)], [0 c3(3)], 'r-', 'LineWidth', 4)

plot3([0 d1(1)], [0 d1(2)], [0 d1(3)], 'm-', 'LineWidth', 4)
plot3([0 d2(1)], [0 d2(2)], [0 d2(3)], 'c-', 'LineWidth', 4)

for k=1:100
    %Generate random x values in range [-1,1]
    x = 2*(rand(3,1) - 0.5);
    b = A*x;
    
    b = b/norm(b);
        
    plot3([0 b(1)], [0 b(2)], [0 b(3)], 'b-', 'LineWidth', 1)    
end

grid on
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')
legend('c_1','c_3','d_1','d_2','b = A*x')
view([110 20])
title('Column Space')

disp('DONE!')