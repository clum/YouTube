classdef FlightRoute
    %FLIGHTROUTE Represents a simple flight path which is simply a series
    %of points in 3D space.  All points are expressed in the XYZ
    %(East/North/Up) frame.  The flight route can be eitehr opened or
    %closed.  If the flight route is closed, this implies that the last
    %point is connected to the first point (for example a closed triangle).
    %
    %For more information, see the C# version of this class.
    %
    %Christopher Lum
    %lum@uw.edu
    
    %Version History
    %05/13/19: Created
    
    %----------------------------------------------------------------------
    %Public properties/fields
    %----------------------------------------------------------------------
    properties (GetAccess='public', SetAccess='public')
    end   
    
    %----------------------------------------------------------------------
    %Private properties/fields
    %----------------------------------------------------------------------
    properties (GetAccess='private', SetAccess='private')
        %See Points property
        %Should be stored as a wide matrix
        point_list;
        
        %See IsClosedRoute property
        isClosedRoute;
    end
    
    %----------------------------------------------------------------------
    %Public Dependent properties/fields
    %----------------------------------------------------------------------
    properties (Dependent)
        %The points of the flight path expressed in the XYZ (East/North/Up)
        %frame
        Points;
        
        %Indicates if the flight route is closed or not.
        %
        %If the route is open then the last point in the fligh route is the
        %last waypoint.
        %
        %If the route is closed then the last point actually connects to the
        %first point in a closed fashion (for example a closed triangle)
        IsClosedRoute;

        %The number of waypoints in this route
        NumWaypoints;
    end
    
  
    %----------------------------------------------------------------------
    %Public methods
    %----------------------------------------------------------------------
    methods
        %Constructors
        function obj = FlightRoute(varargin)
            %FLIGHTROUTE  Constructor for the object
            %
            %   [OBJ] = FLIGHTROUTE() creates an empty object
            %
            %   [...] = FLIGHTROUTE(BUILDER) does as above but initializes
            %   the object with points specified in the matrix BUILDER.
            %   BUILDER should be a 3xN matrix.
            %
            %   [...] = FLIGHTROUTE(BUILDER, ISCLOSED) does as above but
            %   allows the user to specify if the route is opened of
            %   closed.
            %
            %INPUT:     -BUILDER:   3xN matrix of waypoints
            %           -ISCLOSED:  logical denoted if it is closed
            %
            %OUTPUT:    -OBJ:       FlightRoute object
            %
            %Created by Christopher Lum
            %lum@uw.edu
            
            %Version History
            %05/13/19: Created
            %06/05/19: Updated documentation
            
            %------------------OBTAIN USER PREFERENCES---------------------
            switch nargin
                case 2
                    %User supplies all inputs
                    BUILDER     = varargin{1};
                    ISCLOSED    = varargin{2};
                    
                case 1
                    %Assume not a closed route                   
                    BUILDER     = varargin{1};
                    ISCLOSED    = false;

                case 0
                    %Assume empty list and everything above                 
                    BUILDER     = [];
                    ISCLOSED    = false;
                    
                otherwise
                    error('Invalid number of inputs for constructor');
            end

            %------------------CHECKING DATA FORMAT------------------------
            % BUILDER
            %Ensure this is a tall matrix
            [M,N] = size(BUILDER);
            
            if(N > 0)
                assert(M==3,'BUILDER should be a 3-by-N matrix')
            end
            
            % ISCLOSED
            assert(isa(ISCLOSED, 'logical'), 'ISCLOSED should be a logical')
        
            
            %--------------------BEGIN CALCULATIONS------------------------
            obj.point_list      = BUILDER;
            obj.isClosedRoute   = ISCLOSED;
        end
        
        %Destructor
        function delete(obj)
        end
        
        %Get/Set
        function value = get.Points(obj)
            value = obj.point_list;
        end
        
        function value = get.IsClosedRoute(obj)
            value = obj.isClosedRoute;
        end
        
        function obj = set.IsClosedRoute(obj, isClosed)
            assert(isa(isClosed, 'logical'), 'IsClosedRoute should be set to a logical')
            if(obj.NumWaypoints > 1)
                obj.isClosedRoute = isClosed;
            else
                error('A flight route must have more than 1 waypoint to be closed.')
            end
        end
                
        function value = get.NumWaypoints(obj)        
            [M,N] = size(obj.point_list);
            assert(M==3,'Something went wrong, there should only be 3 rows in point_list')
            value = N;
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
            %05/13/19: Created
            disp('Points: ')
            obj.Points
            
            disp(['IsClosedRoute: ',num2str(obj.IsClosedRoute)])
        end
        
        function [varargout] = ChangePoint(obj, INDEX, POINT)
            %CHANGEPOINT Change a point to a different value/location
            %
            %   [OBJ2] = OBJ.CHANGEPOINT(INDEX, POINT) changes the waypoint at
            %   the specified INDEX to a new value/location specified by
            %   POINT.
            %
            %INPUT:     -INDEX: index of point to change
            %           -POINT: new value to chan
            %
            %OUTPUT:    -None
            %
            %Created by Christopher Lum
            %lum@uw.edu
            
            %Version History
            %05/13/19: Created
            
            %------------------CHECKING DATA FORMAT------------------------
            % INDEX
            assert(INDEX <= obj.NumWaypoints, 'INDEX exceeds number of waypoints')
            
            %-------------------BEGIN CALCULATIONS-------------------------
            point_list = obj.point_list;
            point_list(:,INDEX) = POINT;
            
            obj.point_list = point_list;
            
            %Package output
            varargout{1} = obj;
        end

        function [varargout] = DistanceToWaypoint(obj, POSITION, INDEX)
            %DISTANCETOWAYPOINT Computes distance to specified waypoint.
            %
            %   [DISTANCE] = OBJ.DISTANCETOWAYPOINT(POSITION, INDEX)
            %   Computes the distance from the specified poisition
            %   (expressed in the XYZ frame) to the waypoint specified by
            %   INDEX.
            %
            %INPUT:     -POSITION:  point expressed in the XYZ frame (3x1 vector)
            %           -INDEX:     index of waypoint in question
            %
            %OUTPUT:    -DISTANCE:  distance to waypoint
            %
            %Created by Christopher Lum
            %lum@uw.edu
            
            %Version History
            %05/13/19: Created
            
            %------------------CHECKING DATA FORMAT------------------------
            % POSITION
            assert(length(POSTION)==3, 'POSITION should have 3 elements')
            
            % INDEX
            assert(INDEX <= obj.NumWaypoints, 'INDEX exceeds number of waypoints')
            
            %-------------------BEGIN CALCULATIONS-------------------------
            waypoint = obj.GetPoint(INDEX);
            
            dx = waypoint(1) - POSITION(1);
            dy = waypoint(2) - POSITION(2);
            dz = waypoint(3) - POSITION(3);
            
            distance = sqrt(dx^2 + dy^2 + dz^2);            
            
            %Package output
            varargout{1} = distance;
        end
        
        function [varargout] = GetPoint(obj, INDEX)
            %GETPOINT Gets the specified point
            %
            %   [POINT] = OBJ.GETPOINT(INDEX) gets the point at the
            %   specified INDEX.
            %
            %INPUT:     -INDEX:     index of waypoint in question
            %
            %OUTPUT:    -POINT:     desired waypoint expressed in the XYZ frame (3x1 vector)
            %
            %Created by Christopher Lum
            %lum@uw.edu
            
            %Version History
            %05/13/19: Created
            
            %------------------CHECKING DATA FORMAT------------------------
            % INDEX
            assert(INDEX <= obj.NumWaypoints, 'INDEX exceeds number of waypoints')
            
            %-------------------BEGIN CALCULATIONS-------------------------
            point = obj.point_list(:,INDEX);
            
            %Package output
            varargout{1} = point;
        end
    end

end

