function [varargout] = SendPositionOrientationToXPlaneOverUDP(varargin)

%SENDPOSITIONORIENTATIONTOXPLANEOVERUDP Does as described
%
%   SENDPOSITIONORIENTATIONTOXPLANEOVERUDP(U, IP_ADDRESS, PORT_NUMBER,
%   DIGITSPREC) takes the orientation and positions (in vector U) and
%   converts to an appropriate string to send and sends over UDP to
%   X-Plane.
%
%   The vector U should be
%
%       U = [
%            phi (radians)
%            theta (radians)
%            psi (radians)
%            latitude (radians)
%            longitude (radians)
%            altitude (m)
%           ]
%   
%   X-Plane receives and handles this message using the
%   UWTimedProcessingUDP.xpl plugin.
%
%   The PORT_NUMBER should be set to the same thing that the
%   UWTimedProcessingUDP.xpl (the X-Plane plugin) is expecting (typically
%   49003).
%
%   DIGITSPREC specifies how many digits of precision to use when
%   converting from a number to a string (in the num2str command).  If you
%   are getting choppy animation X-Plane, try increasing this value.
%
%   Example usage
%
%       SendPositionOrientationToXPlaneOverUDP(U, '192.168.1.3', 49003, 10)
%   
%
%
%INPUT:     -U:             6x1 vector of [phi;theta;psi;lat;lon;alt]
%           -IP_ADDRESS:    string of the IP address of the machine running
%                           X-Plane
%           -PORT_NUMBER:   port number that UWTimedProcessingUDP.xpl is
%                           using to listen for UDP packets
%           -DIGITSPREC:    number of digits of precision to use when
%                           converting a number to a string
%
%OUTPUT:    -None
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/04/12: Created
%10/19/14: Updated for UWMatlab codebase
%01/09/15: Removed reliance on mapping toolbox radtodeg
%06/02/20: Removed reliance on UWConversionFactors

%----------------------OBTAIN USER PREFERENCES-----------------------------
switch nargin
    case 4
        %User supplies all inputs
        U                   = varargin{1};
        IP_ADDRESS          = varargin{2};
        PORT_NUMBER         = varargin{3};
        DIGITSPREC          = varargin{4};
        
    otherwise
        error('Invalid number of inputs');
end

%-----------------------CHECKING DATA FORMAT-------------------------------
%In the interest of efficiency, do not check inputs, errors should be
%raised later if input arguments are incorrect

% U

% IP_ADDRESS

% PORT_NUMBER

% DIGITSPREC

%-------------------------BEGIN CALCULATIONS-------------------------------
%Unpack inputs
phi         = U(1);
theta       = U(2);
psi         = U(3);
latitude    = U(4);
longitude   = U(5);
altitude    = U(6);

%UWTimedProcessingUDP.xpl is expecting phi, theta, psi, lat, and lon to be
%in degrees, convert there here
phiDeg          = rad2deg(phi);
thetaDeg        = rad2deg(theta);
psiDeg          = rad2deg(psi);
latitudeDeg     = rad2deg(latitude);
longitudeDeg    = rad2deg(longitude);

%UWTimedProcessingUDP.xpl is expecting a space deliniated file string
data=[num2str(phiDeg, DIGITSPREC),' ',...
    num2str(thetaDeg, DIGITSPREC),' ',...
    num2str(psiDeg, DIGITSPREC),' ',...
    num2str(latitudeDeg, DIGITSPREC),' ',...
    num2str(longitudeDeg, DIGITSPREC),' ',...
    num2str(altitude, DIGITSPREC)];
    
%Send the data over UDP
debug = 0;
SendStringOverUDP(data, IP_ADDRESS, PORT_NUMBER, debug);




