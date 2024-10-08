%Christopher Lum
%lum@u.washington.edu
%Sept. 15, 2009
%
%Simulink Tutorial
%This m-file follows along with the simulink_tutorial.doc document.

clear
clc
close all

%-------------------------Part 24-------------------------------
%Define the constants
k = 2;
m = 1;
c = 0.5;

%Enter the A, B, C, and D matrices  
A = [0 1;
    -k/m -c/m];

B = [0;
     1/m];
 
C = [1 0];

D = [0];


%-------------------------Part 29-------------------------------
%Let's run the model from the m-file using the "sim" command
sim('mass_spring_damper_model');

%Now extract the data
t = sim_u.time;
u = sim_u.signals.values;
y = sim_y.signals.values;



%-------------------------Part 30-------------------------------
%Let's find the maximum response of the system
max_y = max(y);

%Now that we know max(y), we want to find out where in the vector this
%occurs.  This means that we want to find the index.
max_index = find(y==max_y);



%-------------------------Part 31-------------------------------
%Now let's plot the data to verify that we have it correct
figure
hold on
plot(t,u,'b-','LineWidth',3)
plot(t,y,'r-','LineWidth',3)
plot(t(max_index),y(max_index),'kx','MarkerSize',15,'LineWidth',3)
grid
title('Response of System with c = 0.5')
xlabel('t (sec)')
ylabel('y (m)')
legend('u','y',['max(y) = ',num2str(max_y)])
hold off



%-------------------------Part 32-------------------------------
%Now let's repeat this process for three different values of c.  We would
%like to use a for loop to make this easier.  First, we define a vector
%which contains the values of c which we would like to use
c_range = [0.5 1 1.5];

%Start a new figure to plot all the results in (we do this outside the for
%loop because we only want 1 figure, not 3).  Also turn the hold on
figure
hold on

%Define a color map which basically defines what different colors we use to
%plot the different responses
color_map = jet(length(c_range));

for n = 1:length(c_range)
    %Obtain the current value of c
    c = c_range(n);
    
    %Redefine the A, B, C, and D matrices with the new value of c
    A = [0 1;
        -k/m -c/m];

    B = [0;
         1/m];
 
    C = [1 0];

    D = [0];
    
    %Run the Simulink model with the new values of A, B, C, and D
    sim('mass_spring_damper_model');
    
    %Extract the data 
    t = sim_u.time;
    u = sim_u.signals.values;
    y = sim_y.signals.values;
    
    %Find the max of y and the index where this occurs
    max_y = max(y);
    max_index = find(y==max_y);
    
    %Also we want to store this data so we can use it in the legend later
    max_y_data(n) = max_y;
    
    %Plot the new data
    plot(t,y,'LineWidth',2,'color',color_map(n,:))
    plot(t(max_index),y(max_index),'x','color',color_map(n,:),...
        'MarkerSize',15,'LineWidth',2)
end

%Plot the input only once
plot(t,u,'r-','LineWidth',2)

%Label the figure
title('Response of System with Different Damping Coefficients')
xlabel('t (sec)')
ylabel('y (m)')
legend(...
    ['y (c = ',num2str(c_range(1)),')'],['max(y) = ',num2str(max_y_data(1))],...
    ['y (c = ',num2str(c_range(2)),')'],['max(y) = ',num2str(max_y_data(2))],...
    ['y (c = ',num2str(c_range(3)),')'],['max(y) = ',num2str(max_y_data(3))],...
    'u')
grid
hold off