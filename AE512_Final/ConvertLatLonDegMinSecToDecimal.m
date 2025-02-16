function [varargout] = ConvertLatLonDegMinSecToDecimal(varargin)

%CONVERTLATLONDEGMINSECTODECIMAL  Converts deg, min, sec to decimal
%
%   [DECIMAL] = CONVERTLATLONDEGMINSECTODECIMAL(DEGREES, MINUTES, SECONDS)
%   converts the lat/lon coordinate given in DEGREES, MINUTES, SECONDS to
%   the equivalent DECIMAL value.
%
%INPUT:     -DEGREES:       degrees (integer in range [-180,180] )
%           -MINUTES:       minutes (integer in range (-60, 60) )
%           -SECONDS        seconds (decimal in range (-60, 60) )
%
%OUTPUT:    -COORDINATE:    lat/lon coordinate in decimal form (deg)
%
%Christopher Lum
%lum@uw.edu

%Version History
%04/10/08: Created
%01/14/24: Updated documentation

%----------------------OBTAIN USER PREFERENCES-----------------------------
switch nargin
    case 3
        %User supplies all inputs
        DEGREES     = varargin{1};
        MINUTES     = varargin{2};
        SECONDS     = varargin{3};
        
    otherwise
        error('Invalid number of inputs');
end

%-----------------------CHECKING DATA FORMAT-------------------------------
% DEGREES
if((DEGREES > 180) || (DEGREES < -180))
    error('DEGREES should be in [-180, 180]')
end

% MINUTES
if((MINUTES <= -60) || (MINUTES >= 60))
    error('MINUTES should be in (-60, 60)!')
end

if(MINUTES < 0)
    %Make sure that DEGREES == 0 and SECONDS >= 0
    if(DEGREES == 0) && (SECONDS >=0)
    else
        error('MINUTES can be negative only if DEGREES = 0 and SECONDS >= 0')
    end
end

% SECONDS
if((SECONDS <= -60) || (SECONDS >= 60))
    error('SECONDS should be in (-60, 60)!')
end

if(SECONDS < 0)
    %Make sure that DEGREES == 0 and MINUTES == 0
    if(DEGREES == 0)  && (MINUTES ==0)
    else
        error('MINUTES can be negative only if DEGREES = 0 and MINUTES == 0')
    end
end

%-------------------------BEGIN CALCULATIONS-------------------------------
if ((DEGREES < 0) || (MINUTES < 0) || (SECONDS < 0))
    %this is negative (S or W coordinate)
    DECIMAL = abs(DEGREES) + abs(MINUTES/60) + abs(SECONDS/3600);
    DECIMAL = -1*DECIMAL;
    
else
    DECIMAL = DEGREES + MINUTES/60 + SECONDS/3600;
    
end

%Output the object
varargout{1} = DECIMAL;