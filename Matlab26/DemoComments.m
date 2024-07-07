%Demonstrate using comments in Matlab.
%
%This script accompanies the YouTube video at https://youtu.be/x6qkmxxMKEw.
%
%Christopher Lum
%lum@uw.edu

%Version History
%06/16/24: Created

clear
clc
close all

%Simple comment

%A simple comment that is very long and needs to be broken across multiple
%lines (note the automatic wrapping of text in a commenet line).  Note that
%you can use 'Ctrl+J' (wrap comments) if you encounter a very long line
%that needs to be wrapped.

%In newer version of Matlab, deminstrate spell checking in a comment (View
%tab > Spelling).

%Show that you can comment out elements in a multi-line definition
dataArrayA = [
    1
    % 2
    3
    4
    ];

cellArrayA = {
    'dog'
    % 'tiger'
    'sheep'
    'elephant'
    };

%Use can also use ellipses to comment out lines in a multi-line array or
%cell array
dataArrayB = [
    1
    ...2
    3
    4
    ];

cellArrayB = {
    'dog'
    ...'tiger'
    'sheep'
    ...'elephant'
    };

%truthfully, ellipses are more useful for breaking a long line into
%multiple separate lines and anything after the ellipses is turned into a
%comment
t = linspace(0,4*pi,500);
y1 = sin(t);
y2 = cos(t*2) + t;

plot(t,y1,'x','LineWidth',2,'Color',[1 0 1],'DisplayName','Testing a very long set of function arguments','MarkerSize',13)
legend()

%You can also add comments after the definition if you want to annotate
cellArrayC = {
    'dog'       %lab
    'tiger'     %saber-toothed
    'sheep'
    'elephant'
    };

%Show to to comment/uncomment a block of text using right click or Ctrl+R
%or Ctrl+T
figure
subplot(2,1,1)
plot(t,y1,'DisplayName','y_1(t)','LineWidth',2)
xlabel('t (sec)')
ylabel('y_1')
grid on
legend()

subplot(2,1,2)
plot(t,y2,'DisplayName','y_2(t)')
xlabel('t (sec)')
ylabel('y_2')
grid on
legend()

%{
Comment Block
%}

%You can use the '%{' and '%}' to perform a similar operation of commenting
%out blocks of code
A = [1 2 3 4;
    5 6 7 8;
    9 10 11 12
    13 14 15 16];

A = A + 10*eye(4);

A = A + 5*rand(4,4);

eig(A)

%% Sections
%Create a section using a double '%% ' sequence.  You can also click on the
%'Section Break' button in the 'Editor' ribbon
x = 1;
y = 2;
z = x+y;

%% Another section
u = rand([500,1]);
figure
hist(u)
grid on
%Comment
%% Comments as function help
%Show how you can make your own function and the first block of comments
%will be displayed when a user asks for help on this function

%% Comment out a Simulink block
%Show how to comment out a simulink block

disp('DONE!')