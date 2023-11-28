%Christopher Lum
%christopher.w.lum@gmail.com
%
%Illustrate using randn and how to transform it to an arbitrary mean and
%std deviation.
%
%This file is designed to accompany the YouTube video at
%https://youtu.be/Xaju4l9KTE0

%Version History
%11/20/19: Created
%11/25/19: Added YouTube URL

clear
clc
close all

%Show that randn can sample from a Gaussian distribution
N = 500;
R = randn(1,N);

%We note that R is a sampled from a standard Gaussian distribution (with
%mean = 0 and sigma = 1.  We can transform to arbitrary mu and sigma
mu          = 0;        %mean of original signal (from randn)
sigma       = 1;        %std dev of original signal (from randn)
muStar      = -15.5;    %desired mean of transformed signal
sigmaStar   = 3.5;      %desired std deviation of transformed signal
a1 = -(sigmaStar/sigma)*mu + muStar;
a2 = sigmaStar/sigma;

RStar = a1+a2*R;

figure
subplot(2,1,1)
hist(R)
title('Histogram of R sampled by randn')
grid on

subplot(2,1,2)
hist(RStar)
title('Histogram of R* = a_1+a_2*R')
grid on

disp(['mean(RStar): ',num2str(mean(RStar))])
disp(['sqrt(var(RStar)): ',num2str(sqrt(var(RStar)))])

disp('DONE!')