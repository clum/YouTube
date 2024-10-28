function [] = visualize_gradient(xo,yo,viewPoint)

%Visualize the gradient at the point (xo,yo);
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/20/23: Created
%10/21/23: Changed to scale vector rather than normalize it

lim = 5;
N = 50;
x = linspace(-lim,lim,N);
y = linspace(-lim,lim,N);
[X,Y] = meshgrid(x,y);

Z = 3*X.^2 + Y.^3 + 150;
zo = 3*xo^2 + yo^3 + 150;

%Compute gradient (and its scaled version) at this point
gradF = [
    6*xo;
    3*yo^2
    ];

c = gradF/10;

%% Visualize
hold on
surfc(X,Y,Z,'FaceAlpha',0.3)
shading interp

%Plot point of interest in x,y plane
plot(xo,yo,'rx','LineWidth',2,'MarkerSize',15)

%Plot point of interest on surface
plot3(xo,yo,zo,'ro','LineWidth',2,'MarkerSize',15)

%Plot scaled version of the gradient vector
plot([xo xo+c(1)],[yo yo+c(2)],'LineWidth',2)

%Draw line connecting base to point on surface
plot3([xo xo],[yo yo],[0 zo],'m--','LineWidth',2)
grid on
xlabel('x')
ylabel('y');
zlabel('h = f(x,y)');
view(viewPoint);
