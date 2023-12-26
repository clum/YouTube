%Illustrate optimization penalty method to solve multiple simultaneous
%equations with equality constraints.
%
%Investigte over constrained situation
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/05/20: Created
%12/25/23: Moved to YouTube GitHub

clear
clc
close all

tic

x_guess = [1 1 -1]';         %GOOD: converges to desired solution

beta_data = linspace(0,1,20);

xstar_data = [];
f0_data = [];
for k=1:length(beta_data)
    beta = beta_data(k);
    [xstar,f0,exitFlag,output] = fminsearch(@(x) cost_function_over_constrained(x,beta),x_guess,...
        optimset('TolX',1e-10,'MaxFunEvals',10000,'MaxIter',10000));
   
    assert(exitFlag==1,'Did not converge')
    
    xstar_data(:,end+1) = xstar;
    f0_data(:,end+1) = f0;
end

%% Plot progression
figure
hold on
plot3(xstar_data(1,1),xstar_data(2,1),xstar_data(3,1),'ro','MarkerSize',15,'LineWidth',2)
plot3(xstar_data(1,end),xstar_data(2,end),xstar_data(3,end),'rx','MarkerSize',15,'LineWidth',2)
plot3(xstar_data(1,:),xstar_data(2,:),xstar_data(3,:),'LineWidth',2)
grid on
xlabel('x_1')
ylabel('x_2')
zlabel('x_3')
view([30 22])
legend(['\beta = ',num2str(beta_data(1))],['\beta = ',num2str(beta_data(end))])

figure
plot(beta_data,f0_data,'LineWidth',2)
grid on
xlabel('\beta')
ylabel('f_0')

toc
disp('DONE!')