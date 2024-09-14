function [A] = PlotShape_VersionC(varargin)

%PLOTSHAPE_VERSIONC Plots a specified shape
%
%   [A] = PlotShape_VersionC(SHAPE,X,Y) plots the specified SHAPE at the
%   specified (X,Y) location.
%
%   [...] = PlotShape_VersionC(SHAPE,X,Y,SIZE,COLOR,LINEWIDTH) does as
%   above but uses the specified SIZE, COLOR, and LINEWIDTH.
%
%INPUT:     -SHAPE: char array denoting the shape
%           -X:     x locat ion
%           -Y:     y location
%           -SIZE:  size of the shape
%           -COLOR: 1x3 vector denoting color
%           -LINEWIDTH: desired line width
%
%OUTPUT:    -A:     areas of shape
%
%Christopher Lum
%lum@uw.edu

switch nargin
    case 6
        %User specifies all inputs
        SHAPE       = varargin{1};
        X           = varargin{2};
        Y           = varargin{3};
        SIZE        = varargin{4};
        COLOR       = varargin{5};
        LINEWIDTH   = varargin{6};

    case 5
        %Assume LINEWIDTH = 1
        SHAPE       = varargin{1};
        X           = varargin{2};
        Y           = varargin{3};
        SIZE        = varargin{4};
        COLOR       = varargin{5};
        LINEWIDTH   = 1;

    case 4
        %Assume COLOR = [0 0 1] and everything above
        SHAPE       = varargin{1};
        X           = varargin{2};
        Y           = varargin{3};
        SIZE        = varargin{4};
        COLOR       = [0 0 1];
        LINEWIDTH   = 1;

    case 3
        %Assume SIZE = 1 and everything above
        SHAPE       = varargin{1};
        X           = varargin{2};
        Y           = varargin{3};
        SIZE        = 1;
        COLOR       = [0 0 1];
        LINEWIDTH   = 1;

    otherwise
        error('Invalid number of inputs')
end

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
