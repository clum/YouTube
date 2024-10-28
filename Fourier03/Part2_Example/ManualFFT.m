%Manually compute the FFT
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/06/23: Created
%11/09/23: Continued working

clear
clc
close all

%% User selections
% N = 2^3;    %8
% N = 2^6;    %64
% N = 2^10;    %1024
% N = 2^11;    %2048
N = 2^12;    %4096

sampleSelection = 2;    %1 = sampled analytical function, 2 = PianoA.wav

%% Generate some samples
assert(mod(N,2)==0,'Code below is only for even number of samples')

%Generate data by sampling a function
switch sampleSelection
    case 1
        DeltaX  = 1/20;
        x       = [0:DeltaX:(N-1)*DeltaX]';
        
        figh = figure;
        hold on
        
        %Sampled function
        f = fcnA(x);
        
    case 2
        %load sound file
        fileName = 'PianoA.wav';
        [fStereo,fs] = audioread(fileName);
        
        idxStart = 1.82*10^5;
        idxEnd = idxStart + N;
        
        %just take 1 channel
        f = fStereo(idxStart:idxEnd-1,1);
        
        DeltaX = 1/fs;
        x = [0:DeltaX:(N-1)*DeltaX]';        
        
    otherwise
        error('Unsupported sampleSelection')
end

%Plot
plot(x,f,'LineWidth',3,'DisplayName','sampled function')
legend('Location','Best')
xlabel('x')
grid on

%% Compute DFT
disp('DFTMethodA')
tic
[fhatA] = DFTMethodA(f);
tA = toc

disp('DFTMethodB')
tic
[fhatB] = DFTMethodB(f);
tB = toc

disp('fft')
tic
[fhatC] = fft(f);
tC = toc

%Compare differences in method
fhat = fhatC;

diffA = norm(fhatA-fhat)
diffB = norm(fhatB-fhat)

%Compare time savings
disp(['fft is ',num2str(tB/tC),' times faster than full matrix DFT'])

%% Spectral analysis
w = (2*pi)/(N*DeltaX)*[0:1:N-1];                %frequency (rad/s)
w_hz = w./(2*pi);                               %frequency (hz)

%Compute 2 and 1-sided spectrums (see https://www.mathworks.com/help/matlab/ref/fft.html)
P2 = abs(fhat/N);   %2 sided spectrum
P1 = P2(1:N/2);     %1-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);

figure
subplot(2,1,1)
plot(w_hz,P2,'rx','MarkerSize',15,'LineWidth',2)
xlabel('\omega (hz)')
title('2 Sided Power Spectrum')
grid on

subplot(2,1,2)
plot(w_hz(1:N/2),P1,'rx','MarkerSize',15,'LineWidth',2)
xlabel('\omega (hz)')
title('1 Sided Power Spectrum')
grid on

disp('DONE!')