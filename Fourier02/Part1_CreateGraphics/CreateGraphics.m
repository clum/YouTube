%Generate graphics for lecture06e_discrete_fourier_transform
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/04/23: Created

clear
clc
close all

N = 6;
DeltaX = 0.3;

%Create sinusoids
xHigh   = linspace(0,N*DeltaX,300);
x       = [0:DeltaX:(N-1)*DeltaX];

figh = figure;
for k=0:N-1
    subplot(N,1,k+1)
    hold on
    
    %Continuous sinusoid
    plot(xHigh,sk_real(xHigh,N,DeltaX,k),'LineWidth',2,'DisplayName',['Re(s_k(x)), k = ',num2str(k)])
    
    %Sampled sinusoid
    plot(x,sk_real(x,N,DeltaX,k),'rx','MarkerSize',15,'LineWidth',2,'DisplayName','sampled sinusoid')
    legend()
    xlabel('x')
    grid on
end

%Draw the Nth roots of unity
figure

for k=0:5
    subplot(3,2,k+1)
    hold on
    
    %draw the unit circle
    thetaHigh = linspace(0,2*pi,200);
    plot(cos(thetaHigh),sin(thetaHigh),'LineWidth',2)
    
    for n=0:N-1
        theta = (2*pi*n*k)/N;
        plot(cos(theta),sin(theta),'rx','MarkerSize',15,'LineWidth',2)
        text(cos(theta),sin(theta),['n=',num2str(n)],'FontSize',15)
        d =1;
    end
    
    axis('equal')
    xlabel('Real')
    ylabel('Imaginary')
    grid on
    title(['k=',num2str(k)])
end

disp('DONE!')