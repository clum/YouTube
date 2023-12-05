%Examine various techniques for computing the step size.  This includes
%
%   Lecture 10E: constant and diminishing step size
%   Lecture 10F: line minimization
%   Lecture 10G: Armijo rule
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/06/21: Created
%10/07/21: Continued working
%10/08/21: Minor update
%10/10/21: Adding line minimization
%10/16/21: Consolidating into single script
%10/24/21: Adding Armijo Rule
%12/04/23: Moved to YouTube repo

clear
clc
close all

tic

%% User selections
plotSurf            = false;
saveFigures         = true;

%Constant step size
% scenarioSelection   = 'scenario01';
% scenarioSelection   = 'scenario02';
% scenarioSelection   = 'scenario03';

%Diminishing step size
% scenarioSelection   = 'scenario04';
% scenarioSelection   = 'scenario05';
% scenarioSelection   = 'scenario06';
% scenarioSelection   = 'scenario07';
% scenarioSelection   = 'scenario08';

%Line minimization
scenarioSelection   = 'scenario09';

%Armijo rule
% scenarioSelection   = 'scenario10';
% scenarioSelection   = 'scenario11';
% scenarioSelection   = 'scenario12';
% scenarioSelection   = 'scenario13';
% scenarioSelection   = 'scenario14';

switch scenarioSelection
    case 'scenario01'
        scenarioDescription = 'Scenario01: fA, constant step size w/ beta = 0.5';
        functionSelection   = 'fA';
        stepSizeSelection   = 'constant';
        beta                = 0.5;
        numSteps            = 55;
        x0                  = [-5;12];
        
    case 'scenario02'
        scenarioDescription = 'Scenario02: fA, constant step size w/ beta = 2.5 (oscillates about stationary point)';
        functionSelection   = 'fA';
        stepSizeSelection   = 'constant';
        beta                = 2.5;
        numSteps            = 25;
        x0                  = [-5;12];
        
    case 'scenario03'
        scenarioDescription = 'Scenario03: fB, constant step size w/ beta = 2.5 (slow convergence)';
        functionSelection   = 'fB';
        stepSizeSelection   = 'constant';
        beta                = 2.5;
        numSteps            = 65;
        x0                  = [-5;12];
        
    case 'scenario04'
        scenarioDescription = 'Scenario04: fA, diminishing step size with gamma = 0.5 (good convergence)';
        functionSelection   = 'fA';
        stepSizeSelection   = 'diminishing';
        gamma               = 0.5;
        numSteps            = 25;
        x0                  = [-5;12];
        
    case 'scenario05'
        scenarioDescription = 'Scenario05: fA, diminishing step size with gamma = 0.75 (interesting behavior)';
        functionSelection   = 'fA';
        stepSizeSelection   = 'diminishing';
        gamma               = 0.75;
        numSteps            = 25;
        x0                  = [-5;12];
        
    case 'scenario06'
        scenarioDescription = 'Scenario06: fA, diminishing step size gamma = 0.8 (diverges)';
        functionSelection   = 'fA';
        stepSizeSelection   = 'diminishing';
        gamma               = 0.8;
        numSteps            = 15;
        x0                  = [-5;12];
        
    case 'scenario07'
        scenarioDescription = 'Scenario07: fB, diminishing step size with gamma = 0.001 (slow converge)';
        functionSelection   = 'fB';
        stepSizeSelection   = 'diminishing';
        gamma               = 0.009;
        numSteps            = 25;
        x0                  = [-5;12];
        
    case 'scenario08'
        scenarioDescription = 'Scenario08: fC, diminishing step size with gamma = 0.1';
        functionSelection   = 'fC';
        stepSizeSelection   = 'diminishing';
        gamma               = 0.1;
        numSteps            = 75;
        x0                  = [-4;3];
        
    case 'scenario09'
        scenarioDescription = 'Scenario09: fC, line minimization';
        functionSelection   = 'fC';
        stepSizeSelection   = 'lineMinimization';
        s                   = 20;
        N_alphas            = 1500;
        numSteps            = 5;
        x0                  = [-4;3];
        
    case 'scenario10'
        %Jumps to upper minima
        scenarioDescription = 'Scenario10: fC, Armijo Rule with s = 15, sigma = 0.15, beta = 0.98';
        functionSelection   = 'fC';
        stepSizeSelection   = 'armijoRule';
        s                   = 15;
        sigma               = 0.15;
        beta                = 0.98;
        numSteps            = 10;
        x0                  = [-4;3];
        
    case 'scenario11'
        %Jumps to upper minima but requires less function evaluations
        scenarioDescription = 'Scenario11: fC, Armijo Rule with s = 15, sigma = 0.15, beta = 0.85';
        functionSelection   = 'fC';
        stepSizeSelection   = 'armijoRule';
        s                   = 15;
        sigma               = 0.15;
        beta                = 0.85;
        numSteps            = 10;
        x0                  = [-4;3];
        
    case 'scenario12'
        %Stays in lower minima due to smaller s
        scenarioDescription = 'Scenario12: fC, Armijo Rule with s = 10, sigma = 0.15, beta = 0.85';
        functionSelection   = 'fC';
        stepSizeSelection   = 'armijoRule';
        s                   = 10;
        sigma               = 0.15;
        beta                = 0.85;
        numSteps            = 10;
        x0                  = [-4;3];
        
    case 'scenario13'
        %Different IC finds bottom min
        scenarioDescription = 'Scenario13: fC, Armijo Rule with s = 10, sigma = 0.15, beta = 0.85';
        functionSelection   = 'fC';
        stepSizeSelection   = 'armijoRule';
        s                   = 7;
        sigma               = 0.15;
        beta                = 0.95;
        numSteps            = 10;
        x0                  = [-2.9;0.8];
        
    case 'scenario14'
        %Different IC gets stuck in left min
        scenarioDescription = 'Scenario14: fC, Armijo Rule with s = 3.5, sigma = 0.15, beta = 0.85';
        functionSelection   = 'fC';
        stepSizeSelection   = 'armijoRule';
        s                   = 3.5;
        sigma               = 0.15;
        beta                = 0.95;
        numSteps            = 10;
        x0                  = [-2.9;0.8];
        
    otherwise
        error('Unsupported scenarioSelection')
end

%% Stationary point computed analytically
switch functionSelection
    case {'fA','fB'}
        xStar = [0;-1];
        fStar = 1;
        
    case 'fC'
        xStar = [0;-2.59163044880036];
        fStar = [36.3822112449922];
        
    otherwise
        error('Unsupported functionSelection')
end

%% Execute numerical optimization algorithm
x = x0;
for k=1:numSteps
    x_k = x(:,k);
    
    %optional analysis: compute the cost function value
    switch functionSelection
        case 'fA'
            f(k) = ComputeFA(x_k(1),x_k(2));
            
        case 'fB'
            f(k) = ComputeFB(x_k(1),x_k(2));
            
        case 'fC'
            f(k) = ComputeFC(x_k(1),x_k(2));
            
        otherwise
            error('Unsupported functionSelection')
    end
    
    %compute d_k using gradient descent
    switch functionSelection
        case 'fA'
            grad_k = ComputeGradFA(x_k);
            
        case 'fB'
            grad_k = ComputeGradFB(x_k);
            
        case 'fC'
            grad_k = ComputeGradFC(x_k);
            
        otherwise
            error('Unsupported functionSelection')
    end
    
    d_k = -grad_k/norm(grad_k);
    
    %Chose alpha_k
    switch stepSizeSelection
        case 'constant'
            alpha_k = beta;  %Constant step size
            
        case 'diminishing'
            alpha_k = gamma*norm(grad_k);
            
        case 'lineMinimization'
            switch functionSelection
                case 'fC'
                    
                otherwise
                    error('This function is not currently supported')
            end
            
            alpha_vec       = linspace(0,s,N_alphas);
            fC_r_alpha      = ComputeFC_r_alpha(x_k,d_k,alpha_vec);
            fC_r_alpha_min  = min(fC_r_alpha);
            min_index       = min(find(fC_r_alpha==fC_r_alpha_min));
            alpha_k         = alpha_vec(min_index);
            
        case 'armijoRule'
            fx_k = ComputeFC(x_k(1), x_k(2));
            m = 0;
            while(1)
                %What is the current value of alpha?
                alpha_candidate = beta^m * s;
                
                %Obtain the new objective function value if this alpha was chosen
                x_k_plus_1 = x_k + alpha_candidate*d_k;
                
                switch functionSelection
                    case 'fC'
                        
                    otherwise
                        error('This function is not currently supported')
                end
                
                fx_k_plus_1 = ComputeFC(x_k_plus_1(1), x_k_plus_1(2));
                
                %Check this this satisfies Eq.1.11
                if ((fx_k - fx_k_plus_1) >= -sigma*alpha_candidate*(grad_k'*d_k))
                    %This alpha value works
                    alpha_k = alpha_candidate;
                    break
                else
                    %This alpha doesn't work, increment m
                    m = m + 1;
                end
            end
            
            mData(k) = m;
            
        otherwise
            error('Unsupported stepSizeSelection')
    end
    
    alpha(k) = alpha_k;
    
    %compute the next point
    x(:,k+1) = x_k + alpha_k*d_k;
end

%% Plot the results
switch functionSelection
    case {'fA','fB'}
        x1Min = -15;
        x1Max = 15;
        
        x2Min = -15;
        x2Max = 15;
        
    case 'fC'
        x1Min = -5;
        x1Max = 5;
        
        x2Min = -5;
        x2Max = 5;
        
    otherwise
        error('Unsupported functionSelection')
end

Nx1 = 50;
Nx2 = 50;

x1 = linspace(x1Min,x1Max,Nx1);
x2 = linspace(x2Min,x2Max,Nx2);

%Plot surf
[X1,X2] = meshgrid(x1,x2);

switch functionSelection
    case 'fA'
        F = ComputeFA(X1,X2);
        
    case 'fB'
        F = ComputeFB(X1,X2);
        
    case 'fC'
        F = ComputeFC(X1,X2);
        
        
    otherwise
        error('Unsupported functionSelection')
end

figh_surf = figure;
hold on
surf(X1,X2,F)
shading interp
xlabel('x_1')
ylabel('x_2')
grid on
title(scenarioDescription)

figh_contour = figure;
hold on
contour(X1,X2,F,15);
xlabel('x_1')
ylabel('x_2')
grid on
title(scenarioDescription)

%Plot the stationary point
switch functionSelection
    case 'fA'
        fStar = ComputeFA(xStar(1),xStar(2));
        
    case 'fB'
        fStar = ComputeFB(xStar(1),xStar(2));
        
    case 'fC'
        fStar = ComputeFC(xStar(1),xStar(2));
        
    otherwise
        error('Unsupported functionSelection')
end

figure(figh_surf)
plot3(xStar(1),xStar(2),fStar,'gx','LineWidth',2,'MarkerSize',13)

figure(figh_contour)
plot(xStar(1),xStar(2),'gx','LineWidth',2,'MarkerSize',13)

%Plot the sequence
for k=1:numSteps
    x1_k = x(1,k);
    x2_k = x(2,k);
    
    if(plotSurf)
        figure(figh_surf)
        plot3(x1_k,x2_k,f(k),'ro')
    end
    
    figure(figh_contour)
    plot(x1_k,x2_k,'ro')
    
    pause(0.1)
end

%Plot the cost function vs. iteration
figh_f = figure;
stepIndices = [1:1:numSteps];

subplot(2,1,1)
hold on
plot(stepIndices,f,'ro')
plot(stepIndices,fStar*ones(size(stepIndices)),'g--')
grid on
xlabel('Iteration number')
ylabel('Cost function value, f')
title(scenarioDescription)
legend('f(x^k)','f(x^*)')

subplot(2,1,2)
hold on
plot(stepIndices,alpha,'ro')
grid on
xlabel('Iteration number')
ylabel('alpha')
legend('\alpha^k')

%save figures
if(saveFigures)
    disp('Saving figures')
    MaximizeFigureAll()
    SaveAllFigures(scenarioSelection,'png')
end

toc
disp('DONE!')