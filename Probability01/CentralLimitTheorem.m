%Christopher Lum
%christopher.w.lum@gmail.com
%
%Illustrate the central limit theorem
%
%This file is designed to accompany the YouTube video at
%https://youtu.be/Xaju4l9KTE0

%Version History
%11/20/19: Created
%11/25/19: Added YouTube URL

clear
clc
close all

%Setup random number generator to act deterministically
rng('default')

%Chose distribution
distributionSelection = 'uniform';

switch distributionSelection
    case 'uniform'
        a = 2;
        b = 5;
        
        mu = (a+b)/2
        sigma = sqrt((1/12)*(a-b)^2)
        
    case 'triangle'
        a = 0;      %lower limit
        b = 1;      %peak location
        c = 10;     %upper limit
        
        mu = (a+b+c)/3
        sigma = sqrt((a^2+b^2+c^2-a*b-a*c-b*c)/18)
        
    otherwise
        error('Unsupported selection')
end

%% Study A
N = 4;
M = 3;

for m=1:M
    
    switch distributionSelection
        case 'uniform'
            X = rand2(a,b,N)
            
        case 'triangle'
            pd = makedist('Triangular','a',a,'b',b,'c',c);
            X = random(pd,1,N);
            
        otherwise
            error('Unsupported selection')
    end
    
    if(m==1)
        figure
        hist(X,20)
    end
    
    %Compute SN
    SN = sum(X)/length(X);
    
    %Store this sample
    SN_data(m) = SN;
end

%Compute the sample average and variance
mu_X = sum(SN_data)/length(SN_data)
var_X = var(SN_data)

var_X_predicted = (sigma/sqrt(N))^2

%Histogram
numBins = 20;
figure
hist(SN_data, numBins)



return
%Sample 1
N = 20000;
X1 = rand2(a,b,N);
X2 = rand2(a,b,N);
X3 = rand2(a,b,N);
X4 = rand2(a,b,N);
X5 = rand2(a,b,N);
X6 = rand2(a,b,N);
X7 = rand2(a,b,N);
X8 = rand2(a,b,N);
X9 = rand2(a,b,N);

S1 = X1;
S2 = (X1+X2)/2;
S3 = (X1+X2+X3)/3;
S9 = (X1+X2+X3+X4+X5+X6+X7+X8+X9)/9;

mu9 = mean(S9)
sigma9 = sqrt(var(S9))

%Draw histograms
numBins = 20;
figure;
subplot(4,1,1)
hist(S1, numBins)

subplot(4,1,2)
hist(S2, numBins)

subplot(4,1,3)
hist(S3, numBins)

subplot(4,1,4)
hist(S9, numBins)

disp('DONE!')