function [] = SendStringOverUDP(varargin)

%SENDSTRINGOVERUDP  Sends a string over UDP to a location and port number
%
%   SENDSTRINGOVERUDP(STR,IP_ADDRESS,PORT_NUMBER) Sends the string STR to
%   the specified IP_ADDRESS using PORT_NUMBER over a UDP connection.  
%
%   SENDSTRINGOVERUDP(STR,IP_ADDRESS,PORT_NUMBER,DEBUG) Does as above but
%   prints messages to the screen about the status if DEBUG==1.
%
%   Example usage
%
%       SendStringOverUDP('test string', '192.168.1.112', 49003)
%
%INPUT:     -STR:           string of data to send
%           -IP_ADDRESS:    string of the IP address where to send data
%           -PORT_NUMBER:   port number to use for sending data
%           -DEBUG:         set to 1 to display messages about status
%
%OUTPUT:    -None
%
%See also SENDSTRINGOVERUDP_UDPTOOLBOX
%
%Christopher Lum
%lum@uw.edu

%Version History
%05/04/12: Created
%08/27/15: Updated for local host operations
%06/02/20: Removed dependency on UDP Toolbox
%01/04/24: Minor whitespace updates

%----------------------OBTAIN USER PREFERENCES-----------------------------
switch nargin
    case 4
        %User supplies all inputs
        STR             = varargin{1};
        IP_ADDRESS      = varargin{2};
        PORT_NUMBER     = varargin{3};
        DEBUG           = varargin{4};
        
    case 3
        %Assume user does not want DEBUG messages
        STR             = varargin{1};
        IP_ADDRESS      = varargin{2};
        PORT_NUMBER     = varargin{3};
        DEBUG           = 0;
        
    otherwise
        error('Invalid number of inputs');
end

%-----------------------CHECKING DATA FORMAT-------------------------------
% STR

% IP_ADDRESS

% PORT_NUMBER

% DEBUG

%-------------------------BEGIN CALCULATIONS-------------------------------
%Setup a UDP port
if(DEBUG)
    disp(['Setting up udpsocket on port #',num2str(PORT_NUMBER),' ...'])
end

udps = dsp.UDPSender();

udps.RemoteIPAddress = IP_ADDRESS;
udps.RemoteIPPort = PORT_NUMBER;

%Convert the string to an integer array in order to send using udps
udps(uint8(STR))