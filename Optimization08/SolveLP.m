%Solve the linear programming example using linprog
%
%Christopher Lum
%lum@uw.edu

%Version History
%12/03/13: Created
%12/07/15: Updated with another cost function to illustrate how this
%          changes solution.
%11/06/21: Updated cost function
%11/07/21: More updates for YouTube

clear
clc
close all

%Cost function
f0 = [-200;-400];       %cost function that yields [0;50] as solution
% f0 = [-320;-280];       %cost function that yields [20;30] as solution

%inequality constraints
A = [1/40 1/60;
     1/50 1/50];        
b = [1;
     1];
 
%equality constraints
Aeq = [];
beq = [];

lb = [0;0];             %lower bound for defining X
ub = [];                %upper bound for defining X

%Optimize using linprog
options = optimset('Display','iter','Diagnostic','on');
% options = optimoptions('linprog','Algorithm','interior-point');

x0 = [];
[xstar,fval,exitflag,output] = linprog(f0,A,b,Aeq,beq,lb,ub,x0,options);

disp('optimal solution')
xstar
output