%Illustrate 2D plotting in Matlab
%
%Christopher Lum
%lum@uw.edu

%Version History:
%10/02/18: Created
%10/04/18: Updated

clear
clc
close all

%% plot
%Define a function
x = linspace(0, 4*pi, 15);
y = x.^2.*sin(x);

%Do a simple plot
figure
hold on
plot(x, y, 'm-', 'LineWidth', 4)
plot(x, y, 'mo', 'MarkerSize', 12)

%Now decorate the plot
grid on
xlabel('t (sec)')
ylabel('y = \theta (rad)')
title('An example title of y vs. t.')
legend('y', 'y (data points)', 'Location', 'best')
axis([min(x) max(x) min(y) max(y)])
text(2, 40, 'Text goes here', 'Color', 'red', 'FontSize', 16)

%% histogram
%Illustrate subplot
N = 2000;
numBins = 20;

samplesUniform = rand(1,N);
samplesNormal = randn(1,N);

figure
subplot(2,1,1)
histogram(samplesUniform, numBins)
grid on
title('Uniform Distribution')

subplot(2,1,2)
histogram(samplesNormal, numBins)
grid on
title('Normal (Gaussian) Distribution')

%note that older code may use hist instead of histogram.  hist is
%discourgaed

%% plotyy
%Create a second dataset
x2 = linspace(0, 5*pi, 20);
y2 = x2.^3.*sin(x2);

figure
hold on
plot(x, y)
plot(x2, y2)

%% semilogx
figure
semilogx(x2, y2)
grid on

%% pie
sales = [15 50 30 30 20];

figure
pie(sales)

%% scatter
figure
subplot(2,1,1)
scatter(x, y)

subplot(2,1,2)
plot(x, y ,'bo')