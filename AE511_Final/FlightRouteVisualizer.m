classdef FlightRouteVisualizer
    %FLIGHTROUTEVISUALIZER Visualize a FlightRoute object
    %
    %Christopher Lum
    %lum@uw.edu
    
    %Version History
    %06/05/19: Created
    
    %----------------------------------------------------------------------
    %Public properties/fields
    %----------------------------------------------------------------------
    properties (GetAccess='public', SetAccess='public')
        %1x3 matrix in range [0, 1] denoting the color of the waypoints and legs
        Color;
        
        %line width of the waypoints and legs
        LineWidth;
        
        %marker size of the waypoints
        MarkerSize;
        
        %Add waypoint numbers or not (logical)
        PlotWaypointNumbers;
    end   
    
    %----------------------------------------------------------------------
    %Private properties/fields
    %----------------------------------------------------------------------
    properties (GetAccess='private', SetAccess='private')
        %object to be visualized
        flightRoute;
    end
    
    %----------------------------------------------------------------------
    %Public Dependent properties/fields
    %----------------------------------------------------------------------
    properties (Dependent)
    end
    
  
    %----------------------------------------------------------------------
    %Public methods
    %----------------------------------------------------------------------
    methods
        %Constructors
        function obj = FlightRouteVisualizer(varargin)
            %FLIGHTROUTEVISUALIZER  Constructor for the object
            %
            %   [OBJ] = FLIGHTROUTEVISUALIZER(ROUTE) creates a viusalizer
            %   object
            %
            %   [...] = FLIGHTROUTEVISUALIZER(ROUTE, COLOR, LINEWIDTH,
            %   MARKERSIZE, PLOTWAYPOINTNUMBERS) does as above but uses
            %   specified options.
            %
            %INPUT:     -ROUTE:                 FlightRoute object to be visualized
            %           -COLOR:                 See Color property
            %           -LINEWIDTH:             See LineWidth property
            %           -MARKERSIZE:            See MarkerSize property
            %           -PLOTWAYPOINTNUMBERS:   See PlotWaypointNumbers property
            %
            %OUTPUT:    -OBJ:                   FlightRouteVisualizer object
            %
            %Created by Christopher Lum
            %lum@uw.edu
            
            %Version History
            %06/05/19: Created
            
            %------------------OBTAIN USER PREFERENCES---------------------
            switch nargin
                case 5
                    %User supplies all inputs
                    ROUTE               = varargin{1};
                    COLOR               = varargin{2};
                    LINEWIDTH           = varargin{3};
                    MARKERSIZE          = varargin{4};
                    PLOTWAYPOINTNUMBERS = varargin{5};
                    
                case 1
                    %Assume standard parameters
                    ROUTE               = varargin{1};
                    COLOR               = [0 0 1];
                    LINEWIDTH           = 2;
                    MARKERSIZE          = 14;
                    PLOTWAYPOINTNUMBERS = true;
                    
                otherwise
                    error('Invalid number of inputs for constructor');
            end

            %------------------CHECKING DATA FORMAT------------------------
            % ROUTE
            %Ensure this is a FlightRoute object
            assert(isa(ROUTE,'FlightRoute'), 'ROUTE should be a FlightRoute object')
            
            
            %--------------------BEGIN CALCULATIONS------------------------
            obj.flightRoute         = ROUTE;
            obj.Color               = COLOR;
            obj.LineWidth           = LINEWIDTH;
            obj.MarkerSize          = MARKERSIZE;
            obj.PlotWaypointNumbers = PLOTWAYPOINTNUMBERS;
        end
        
        %Destructor
        function delete(obj)
        end
        
        %Get/Set
        function obj = set.Color(obj, color)
            [M,N] = size(color);
            assert(M==1 && N==3, 'Color must be a 1x3 matrix')
            assert((max(color) <= 1) && (min(color) >= 0), 'All elements must be in range [0,1]')
            
            obj.Color = color;
        end
        
        function obj = set.LineWidth(obj, lineWidth)
            assert(lineWidth > 0, 'LineWidth must be > 0')
            obj.LineWidth = lineWidth;
        end
        
        function obj = set.MarkerSize(obj, markerSize)
            assert(markerSize > 0, 'MarkerSizemust be > 0')
            obj.MarkerSize = markerSize;
        end
        
        function obj = set.PlotWaypointNumbers(obj, plotWaypointNumbers)
            assert(isa(plotWaypointNumbers, 'logical'), 'PlotWaypointNumbers must be a boolean')
            obj.PlotWaypointNumbers = plotWaypointNumbers;
        end
        
        %Class API
        function [] = display(obj)
            %DISPLAY  Define how object is displayed in the command window
            %
            %   DISPLAY() defines how the object is displayed in the
            %   command window.
            %
            %INPUT:     -None
            %
            %Created by Christopher Lum
            %lum@uw.edu
            
            %Version History
            %06/05/19: Created
            
            disp(['Visualizer for FlightRoute with ',num2str(obj.flightRoute.NumWaypoints),' waypoints.'])
        end
        
        function [varargout] = PlotFlightRoute(obj)
            %PLOTFLIGHTROUTE Plots the FlightRoute
            %
            %   OBJ.PLOTFLIGHTROUTE() Plots the flight route.
            %
            %INPUT:     -none
            %
            %OUTPUT:    -none
            %
            %Created by Christopher Lum
            %lum@uw.edu
            
            %Version History
            %05/13/19: Created
            
            %------------------CHECKING DATA FORMAT------------------------
            
            %-------------------BEGIN CALCULATIONS-------------------------
            was_hold = ishold;
            
            if ~was_hold
                hold on
            end
            
            %Plot the waypoints
            Points = obj.flightRoute.Points;
            IsClosedRoute = obj.flightRoute.IsClosedRoute;
            NumWaypoints = obj.flightRoute.NumWaypoints;
            
            for k=1:NumWaypoints
                plot3(Points(1,k), Points(2,k), Points(3,k), 'o',...
                    'Color', obj.Color,...
                    'LineWidth', obj.LineWidth,...
                    'MarkerSize', obj.MarkerSize)
                
                if(obj.PlotWaypointNumbers)
                    text(Points(1,k), Points(2,k), Points(3,k), num2str(k))
                end
            end
            
            %Plot the legs
            for k=1:NumWaypoints
                if(~IsClosedRoute && k==NumWaypoints)
                    break
                end
                
                %Get the next waypoint
                if(IsClosedRoute && k==NumWaypoints)
                    nextWP = Points(:,1);
                else
                    nextWP = Points(:,k+1);
                end
                                
                currentWP = Points(:,k);
                
                deltaLeg = nextWP - currentWP;
                plot3([currentWP(1) (currentWP(1)+deltaLeg(1))], ...
                    [currentWP(2) (currentWP(2)+deltaLeg(2))], ...
                    [currentWP(3) (currentWP(3)+deltaLeg(3))], ...
                    'Color', obj.Color,...
                    'LineWidth', obj.LineWidth,...
                    'MarkerSize', obj.MarkerSize)
            end
            
            if(IsClosedRoute)
                %last leg returns
            end

            
            %Return the hold state on the figure
            if ~was_hold
                hold off
            end
        end
    end

end

