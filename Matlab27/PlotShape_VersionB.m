function [A] = PlotShape_VersionB(SHAPE,X,Y,SIZE,COLOR,LINEWIDTH)

%PLOTSHAPE_VERSIONB Plots a specified shape
%
%   [A] = PlotShape_VersionB(SHAPE,X,Y,SIZE,COLOR,LINEWIDTH) plots the
%   specified SHAPE at the specified (X,Y) location and at the specified
%   SIZE. This draws using the specified COLOR and LINEWIDTH.
%
%INPUT:     -SHAPE: char array denoting the shape
%           -X:     x location
%           -Y:     y location
%           -SIZE:  size of the shape
%           -COLOR: 1x3 vector denoting color
%           -LINEWIDTH: desired line width
%
%OUTPUT:    -A:     areas of shape
%
%Christopher Lum
%lum@uw.edu

%Define x and y coordinates of the shape
switch SHAPE
    case 'circle'
        R = SIZE;
        theta = linspace(0,2*pi,25);
        x = R*cos(theta) + X;
        y = R*sin(theta) + Y;

        A = pi*R^2;

    case 'square'
        L = SIZE;
        xMin = X - L/2;
        xMax = X + L/2;
        yMin = Y - L/2;
        yMax = Y + L/2;

        x = [xMin xMax xMax xMin xMin];
        y = [yMin yMin yMax yMax yMin];

        A = L^2;

    case 'triangle'
        L = SIZE;
        a = L/2;
        b = sqrt(L^2 - a^2);
        
        xMin = X - a;
        xMax = X + a;
        yMin = Y - b/2;
        yMax = Y + b/2;

        x = [xMin xMax X xMin];
        y = [yMin yMin yMax yMin];

        A = (1/2)*(2*a)*b;

    otherwise
        error('Unsupported SHAPE')
end

%Plot the shape
plot(x,y,'Color',COLOR,'LineWidth',LINEWIDTH)
