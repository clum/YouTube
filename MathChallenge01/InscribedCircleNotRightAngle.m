%Inscribed circle in a triangle (this triangle is not a right triangle)
%
%Christopher Lum
%lum@uw.edu

%Version History
%04/20/24: Created
%04/21/24: Prep for YouTube

clear
clc
close all

tic

%% User selections
N = 30;
a = 3;
b = 4;

thetaStart_deg = 10;
thetaEnd_deg = 170;
thetaC_range = [linspace(thetaStart_deg,thetaEnd_deg,N/2) linspace(thetaEnd_deg,thetaStart_deg,N/2)]*pi/180;

% %values from example
% thetaC_range = 130*pi/180

%% Animate scenario
majorDimension = max([a b]);

for k=1:length(thetaC_range)
    thetaC = thetaC_range(k);
    
    x_A = 0;
    y_A = 0;
    
    x_B = b*cos(pi/2-thetaC);
    y_B = b*sin(pi/2-thetaC);
    
    x_C = 0;
    y_C = a;
    
    deltaX = x_B - x_C;
    deltaY = y_B - y_C;
    
    c = sqrt(deltaX^2 + deltaY^2);

    s = (a+b+c)/2;
    A_T = sqrt(s*(s-a)*(s-b)*(s-c));
    
    r = 2*sqrt(s*(s-a)*(s-b)*(s-c))/(a+b+c);

    %distance from vertex A to incenter (see
    %https://en.wikipedia.org/wiki/Incircle_and_excircles)
    x_I = (a*x_B + b*x_C + c*x_A)/(a+b+c);
    y_I = (a*y_B + b*y_C + c*y_A)/(a+b+c);
    
    assert(AreMatricesSame(x_I,r,10e-5))
    
    %% Plot
    triangle_x = [x_A x_B x_C x_A];
    triangle_y = [y_A y_B y_C y_A];

    N = 50;
    [circle_x,circle_y] = DrawCircle(r,x_I,y_I,N);

    clf
    plot(triangle_x,triangle_y,'Color',[0 0 1],'LineWidth',2,'DisplayName','Triangle')
    hold on
    plot(circle_x,circle_y,'Color',[1 0 0],'LineWidth',2,'DisplayName','Circle')

    xlabel('x')
    ylabel('y')
    grid on
    axis([-majorDimension majorDimension -majorDimension majorDimension])
    legend()
    title(['thetaC = ',num2str(rad2deg(thetaC))])

    movieVector(k) = getframe;
end

%% Write to file
myWriter = VideoWriter('NotRightTriangle','MPEG-4');
myWriter.FrameRate = 30;

open(myWriter);
writeVideo(myWriter,movieVector);
close(myWriter)

toc
disp('DONE!')