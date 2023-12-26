%Show how to call fminsearch 
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/02/20: Created
%12/25/23: Moved to YouTube GitHub

clear
clc
close all

tic

%Chose how to call fminsearch
%
%   1.  Rosenbrock function specified by a file 
%   2.  Rosenbrock function using an anonymous function
%   3.  Rosenbrock function with extra parameters using an anonymous function
%   4.  Rosenbrock function specified by a file with extra parameters
selection = 4;

%% Call fminsearch
switch selection
    case 1
        x0 = [-1.2;1];
        xStar = fminsearch('RosenbrockSimple',x0)
        
    case 2
        anonymousFunction1 = @(x) 100*(x(2) - x(1)^2)^2 + (2 - x(1))^2;
        x0 = [-1.2;1];
        xStar = fminsearch(anonymousFunction1,x0)
                
    case 3
        a_values = [2 4 8];
        
        for k=1:length(a_values)
            k
            a = a_values(k);
            
            %Capture current value of a in an anonymous function
            anonymousFunction2 = @(x) 100*(x(2) - x(1)^2)^2 + (a - x(1))^2;
            
            %Verify that the value of parameter a has been captured in the
            %anonymousFunction2 function_handle
            anonymousFunction2([-1/2,1/3])
            
            x0 = [-1.2;1];
            xStar = fminsearch(anonymousFunction2,x0)
        end
        
    case 4
        a_values = [2 4 8];
        
        for k=1:length(a_values)
            k
            a = a_values(k);
            x0 = [-1.2;1];
            
            %Capture current value of a in an anonymous function
            anonymousFunction3 = @(x) RosenbrockExtraParams(x,a);
            
            %Verify that the value of parameter a has been captured in the
            %anonymousFunction3 function_handle
            anonymousFunction3([-1/2,1/3])
            
            xStar = fminsearch(anonymousFunction3,x0)
        end
        
    otherwise
        error('Unsupported selection')
end

toc
disp('DONE!')