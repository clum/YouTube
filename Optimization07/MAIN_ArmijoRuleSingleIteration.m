%Christopher Lum
%lum@uw.edu
%
%Generate plots and example of Armijo rule algorithm

%Version History
%11/21/13: Created
%10/19/21: Updated for 2021
%10/23/21: Continued updating
%10/24/21: Continued updating
%10/30/21: Adding axes labels
%12/04/23: Moved to YouTube

clear
clc
close all

tic

%% Add paths
costFunctionPath = [ReturnPathStringNLevelsUp(1),'\Optimization05'];
addpath(costFunctionPath);
disp(['Added path: ',costFunctionPath])

%% User selections
plotOnlyCriticalFigures = false;     %set to true to only generate plots relevant to lecture

% scenario = 'scenario_armijo01';
% scenario = 'scenario_armijo02';
% scenario = 'scenario_armijo03';
% scenario = 'scenario_armijo04';
scenario = 'scenario_armijo05';

switch scenario
    case 'scenario_armijo01'
        %Similar scenario as previous line minimization example
        x_k     = [-4;3];
        s       = 15;
        sigma   = 0.15;
        beta    = 0.98;
        
    case 'scenario_armijo02'
        %similar to scenario01 but with smaller beta to show larger changes
        %in step size
        x_k     = [-4;3];        
        s       = 15;
        sigma   = 0.15;
        beta    = 0.85;
        
    case 'scenario_armijo03'
        %Move to a location where it looks more like the Bertsekas figure
        %(multiple regions of successful and unsuccessful stepsize trials)
        x_k     = [-2.9;0.8];
        s       = 7;
        sigma   = 0.15;
        beta    = 0.95;
        
    case 'scenario_armijo04'
        %similar to scenario02 but show that with smaller s we can fall
        %into first minima
        x_k     = [-2.9;0.8];
        s       = 3.5;
        sigma   = 0.15;
        beta    = 0.95;

    case 'scenario_armijo05'
        %show that armijo rule will eventually terminate even with sigma
        %and beta close to 1
        x_k     = [-2.9;0.8];
        s       = 7;
        sigma   = 0.9999;
        beta    = 0.99;
        
    otherwise
        error('Unsupported scenario')
end

%% Analysis
%Visualize the cost function
x1min = -5;
x1max = 5;
Nx1 = 50;

x2min = -5;
x2max = 5;
Nx2 = 50;

x1 = linspace(x1min,x1max,Nx1);
x2 = linspace(x2min,x2max,Nx2);

[X1,X2] = meshgrid(x1,x2);

FC = ComputeFC(X1,X2);

figh_total = figure;
set(figh_total,'defaultLegendAutoUpdate','off');
hold on
surf(X1,X2,FC)
shading interp

figh_totalContour = figure;
set(figh_totalContour,'defaultLegendAutoUpdate','off');
hold on
contour(X1,X2,FC,15)

%Define the point that we are interested in
fC_x_k = ComputeFC(x_k(1), x_k(2));

figure(figh_total)
plot3(x_k(1), x_k(2), 0, 'go', 'LineWidth', 2, 'MarkerSize', 14)
plot3(x_k(1), x_k(2), fC_x_k, 'mo', 'LineWidth', 2, 'MarkerSize', 14)
plot3([x_k(1) x_k(1)], [x_k(2) x_k(2)], [0 fC_x_k], 'b--', 'LineWidth', 2, 'MarkerSize', 14)

figure(figh_totalContour)
plot3(x_k(1), x_k(2), 0, 'go', 'LineWidth', 2, 'MarkerSize', 14)

%Compute the gradient at this point and take the negative gradient to be
%the descent direction
gradFC_x_k = ComputeGradFC(x_k);
d_k = -gradFC_x_k*(1/norm(gradFC_x_k));

%Show the descent direction
ArrowParams(1,1) = 1;
ArrowParams(2,1) = 1;
ArrowParams(3,1) = 0;
ArrowParams(4,1) = 0;
ArrowParams(5,1) = 0.25;
ArrowParams(6,1) = 2;

figure(figh_total)
DrawArrow(x_k(1), x_k(2), d_k(1), d_k(2), ArrowParams)

figure(figh_totalContour)
DrawArrow(x_k(1), x_k(2), d_k(1), d_k(2), ArrowParams)

%Decorate the plots
figure(figh_total)
grid on
xlabel('x_1')
ylabel('x_2')
zlabel('f_C(x_1,x_2)')
legend('f_C(x_1,x_2)',...
    'x_k',...
    'f_C(x_k)',....
    '-',...
    'd_k')

figure(figh_totalContour)
grid on
xlabel('x_1')
ylabel('x_2')
legend('f_C(x_1,x_2)',...
    'x_k',...
    'd_k')

%% Armijo Rule calculation
figh_betsekas = figure;
hold on
alpha = linspace(0, s, 2500);

ralpha1 = x_k(1) + alpha*d_k(1);
ralpha2 = x_k(2) + alpha*d_k(2);

%Compute fralpha
fC_r_alpha = ComputeFC(ralpha1, ralpha2);

legendString = {};
fx_k = ComputeFC(x_k(1), x_k(2));
plot(alpha,fC_r_alpha - fx_k,'b-','LineWidth',2)
legendString{end+1} = 'f(x^k+\alpha d^k) - f(x^k)';

plot(alpha,sigma*(gradFC_x_k'*d_k)*alpha,'g-','LineWidth',2);
legendString{end+1} = ['(\sigma \nabla f(x^k)^T d^k )\alpha with \sigma = ',num2str(sigma)];

plot(alpha,(gradFC_x_k'*d_k)*alpha,'m-','LineWidth',2);
legendString{end+1} = '(\nabla f(x^k)^T d^k )\alpha';

%Execute algorithm
m = 0;
while(1)
    %What is the current value of alpha?
    alpha_candidate = beta^m * s;
    
    %Obtain the new objective function value if this alpha was chosen
    x_k_plus_1 = x_k + alpha_candidate*d_k;
    
    fx_k_plus_1 = ComputeFC(x_k_plus_1(1), x_k_plus_1(2));
    
    %Check this this satisfies Eq.1.11
    if ((fx_k - fx_k_plus_1) >= -sigma*alpha_candidate*(gradFC_x_k'*d_k))
        %This alpha value works
        alpha_k = alpha_candidate;
        color = [0 1 0];
        break
    else
        %This alpha doesn't work, increment m
        m = m + 1;
        color = [1 0 0];
    end
    
    %Recreate picture from Bertsekas text
    plot(alpha_candidate,0,'x','Color',color,'LineWidth',2,'MarkerSize',15)
    legendString{end+1} = ['\alpha candidate = ',num2str(alpha_candidate)];
end

legend(legendString)
xlabel('\alpha')
grid on

%Plot f vs. alpha
figh_alpha = figure;
hold on
plot(alpha, fC_r_alpha, 'LineWidth', 2)
plot(alpha_k, fx_k_plus_1, 'ro', 'LineWidth', 2, 'MarkerSize', 13)
xlabel('\alpha')
ylabel('f_C(r(\alpha))')
legend('f_C(r(\alpha))',...
    ['\alpha_k = ',num2str(alpha_k)])
grid on

%How does this look on the figures
figure(figh_total)
plot3(ralpha1, ralpha2, fC_r_alpha, 'm-', 'LineWidth', 2)  %draw on cost function
plot3(ralpha1, ralpha2, zeros(size(ralpha1)), 'g--', 'LineWidth', 2)
plot3(x_k_plus_1(1), x_k_plus_1(2), 0, 'ro', 'LineWidth', 2, 'MarkerSize', 13)
plot3(x_k_plus_1(1), x_k_plus_1(2), ComputeFC(x_k_plus_1(1), x_k_plus_1(2)), 'ro', 'LineWidth', 2, 'MarkerSize', 13)
plot3([x_k_plus_1(1) x_k_plus_1(1)], [x_k_plus_1(2) x_k_plus_1(2)], [0 ComputeFC(x_k_plus_1(1), x_k_plus_1(2))], 'r--', 'LineWidth', 2)

figure(figh_totalContour)
plot(ralpha1, ralpha2, 'g--', 'LineWidth', 2)
plot(x_k_plus_1(1), x_k_plus_1(2), 'ro', 'LineWidth', 2, 'MarkerSize', 13)

if(plotOnlyCriticalFigures)
    close(figh_total)
    close(figh_alpha)
end

%Close figures that 
%% Cleanup
%Remove the path
rmpath(costFunctionPath);
disp(['Removed path: ',costFunctionPath])

toc
disp('DONE!')