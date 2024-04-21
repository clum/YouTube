%Inscribed circle in a triangle (this triangle is a right triangle)
%
%Christopher Lum
%lum@uw.edu

%Version History
%04/19/24: Created
%04/21/24: Prep for YouTube

clear
clc
close all

tic

%% User selections
N = 30;
a_range = [linspace(1,5,N/2) linspace(5,1,N/2)];

t = linspace(0,pi,N);
b_range = 5*abs(cos(t)) + 2;

% %values from example
% a_range = 3;
% b_range = 4;

%% Animate scenario
majorDimension = max([max(a_range) max(b_range)]);

for k=1:length(a_range)
    a = a_range(k);
    b = b_range(k);

    c = sqrt(a^2 + b^2);

    r = a*b/(a+b+c);

    %% Plot
    triangle_x = [0 a 0 0];
    triangle_y = [0 0 b 0];

    N = 50;
    [circle_x,circle_y] = DrawCircle(r,r,r,N);

    clf
    plot(triangle_x,triangle_y,'Color',[0 0 1],'LineWidth',2,'DisplayName','Triangle')
    hold on
    plot(circle_x,circle_y,'Color',[1 0 0],'LineWidth',2,'DisplayName','Circle')

    xlabel('x')
    ylabel('y')
    grid on
    axis([0 majorDimension 0 majorDimension])
    legend()

    movieVector(k) = getframe;
end

%% Write to file
myWriter = VideoWriter('RightTriangle','MPEG-4');
myWriter.FrameRate = 30;

open(myWriter);
writeVideo(myWriter,movieVector);
close(myWriter)

toc
disp('DONE!')