%Christopher Lum
%lum@uw.edu
%
%Illustrate numerical solutions of PDEs using Matlab

%Version History    
%09/26/17: Created
%11/04/17: Implementing example
%11/05/17: Changed indexing order to make algorithm easier
%11/12/17: Finalized code
%12/15/23: Moved to GitHub in preparation for YouTube release

clear
clc
close all

%% User selection
animation.Active = true;    %true = animate, false = no animation
animation.DTFrames = 10;    %how many frames to skip between rending a frame of animation
animation.FrameRate = 10;   %FPS for final movie

compositeImage.Times = [0.1 0.2 10];        %times when to draw the composite image

%% Generate spatial and temporal grid
%Known combinations to work are
% Nt = 1000, Nx = 100, tMin = 0.1, tMax = 10, xMin = -5, xMax = 5 (stable, illustrates discrepancy b/w boundary condition)
% Nt = 1000, Nx = 100, tMin = 0.1, tMax = 10, xMin = -8, xMax = 8
% Nt = 1000, Nx = 100, tMin = 0.1, tMax = 10, xMin = -10, xMax = 10

%Unstable combinations
% Nt = 950, Nx = 100, tMin = 0.1, tMax = 10, xMin = -5, xMax = 5 (unstable, diverges near end of simulation)

Nt = 1000;      %number of temporal steps
Nx = 100;       %number of spatial steps

tMin = 0.1;
tMax = 10;

xMin = -5;
xMax = 5;

t = linspace(tMin, tMax, Nt);
x = linspace(xMin, xMax, Nx);

%Compute secondary parameters
DeltaT = t(2) - t(1);
DeltaX = x(2) - x(1);

%% Numerically Solve PDE
%Initialize a container for all the p values.
p = zeros(Nt, Nx);

%Set initial condition
p(1,:) = AnalyticalSolution(t(1), x);

%iterate through time values
for i = 2:Nt
    
    %iterate through spatial values
    for j = 1:Nx
        if(j==1 || j==Nx)
            %Hold boundary condition of zero
            p(i,j) = 0;
        else
            %Compute function value
            p_im1_jp1   = p(i-1,j+1);   %previous time point and forward spatial point
            p_im1_j     = p(i-1,j);     %previous time point and current spatial point
            p_im1_jm1   = p(i-1,j-1);   %previous time point and backwards spatial point
            
            p(i,j) = 0.5*(DeltaT/(DeltaX^2))*(p_im1_jp1 - 2*p_im1_j + p_im1_jm1) + p_im1_j;
        end
    end
end
    
%% Analyze the results
for i=1:Nt
    pNumerical = p(i,:);
    %Ensure the result is still a valid PDF
    temp = Integrate(x, pNumerical);
    intP(i) = temp(end);
    
    %Compute the error from the analytical solution
    pAnalytical = AnalyticalSolution(t(i), x);
    
    cumulativeError(i) = sum((pNumerical - pAnalytical).^2)/(length(pAnalytical));    
end

figure
subplot(2,1,1)
plot(t, intP, 'LineWidth', 2)
grid on
xlabel('t')
ylabel('\int p(t,x) dx')

subplot(2,1,2)
plot(t, cumulativeError, 'LineWidth', 2)
grid on
xlabel('t')
ylabel('Cumulative squared average error')

if(animation.Active)
    %Plot the progression
    figure
    movieCounter = 1;
    for i=1:animation.DTFrames:Nt
        pAnalytical = AnalyticalSolution(t(i), x);
        
        plot(x, p(i,:), x, pAnalytical, 'LineWidth', 2)
        legend('Numerical', 'Analytical')
        xlabel('x')
        ylabel('p(t,x)')
        title(['p(t,x) @ t = ',num2str(t(i))])
        axis([xMin, xMax, 0, max(p(1,:))])
        grid on
        movieVector(movieCounter) = getframe;        
        movieCounter = movieCounter + 1;
    end   
    
    %Create a VideoWriter object and set properties
    fileName = 'numericalPDE.avi';
    myWriter = VideoWriter(fileName);
    myWriter.FrameRate = animation.FrameRate;
    
    %Open the VideoWriter object, write the movie, and close the file
    open(myWriter);
    writeVideo(myWriter, movieVector);
    disp(['Write file: ', fileName])
    close(myWriter);
end

%Generate a composite plot showing the values at different times
figure
hold on
for k=1:length(compositeImage.Times)
    times = compositeImage.Times;
    [min_t, index] = min(abs(t - times(k)));
    t_actual = t(index);
    
    pAnalytical = AnalyticalSolution(t_actual, x);
        
    plot(x, p(index,:), 'b-', 'LineWidth', 2)
    plot(x, pAnalytical, 'r-', 'LineWidth', 2)
    
    legend('Numerical', 'Analytical')
    xlabel('x')
    ylabel('p(t,x)')
    title('p(t,x) at Various Times')
    axis([xMin, xMax, 0, max(p(1,:))])
    grid on    
end

disp('DONE!')