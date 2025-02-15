function animation_joystickID_CB(varargin)

%ANIMATION_JOYSTICKID_CB Callback fcn
%
%   ANIMATION_JOYSTICKID_CB(blk)
%   performs the required callback functions when the JoystickID parameters
%   of the UWAerospaceBlockset_Animation/joystick blocks is changed.
%
%   INPUT:  -blk:   string to the block path (should be called using gcb)
%
%   OUTPUT: none
%
%Created by Christopher Lum
%lum@u.washington.edu

%Version History:   -10/15/14: Created
%                   -10/17/14: Fixed problems.
%                   -10/18/14: Added 'None' as an option


%----------------------OBTAIN USER PREFERENCES-----------------------------
switch nargin
    case 1
        %User supplies all inputs
        blk = varargin{1};
        
    otherwise
        error('animation_joystickID_CB: Invalid number of inputs');
end


%-----------------------CHECKING DATA FORMAT-------------------------------
% blk


%-------------------------BEGIN CALCULATIONS-------------------------------
%What are the parameters of this block
blkMaskVariables = get_param(blk,'MaskVariables');

%What are the currently set values
blkMaskValues = get_param(blk,'MaskValues');

%Which popup value did the user select in this blk?
desiredPopupValue = blkMaskValues{1};

%Set the popup value based on what this blk's popup value is set at
if(strcmp(desiredPopupValue,'Joystick1'))
    desiredNestedPopupValue = 'Joystick1';
    
elseif(strcmp(desiredPopupValue,'Joystick2'))
    desiredNestedPopupValue = 'Joystick2';
 
elseif(strcmp(desiredPopupValue,'None'))
    desiredNestedPopupValue = 'None';
    
else
    error('animation_joystickID_CB: Should not reach here.')
    
end

%Get the path of the 'Pilot Joystick All' block
nestedBlockString = [blk,'/Pilot Joystick All'];

%Get a list of the parameters
nestedBlockMaskVariables = get_param(nestedBlockString,'MaskVariables');

%Find out which index corresponds to the parameter we want to set (remove
%the last ';'
[words] = SplitOnDesiredChar(nestedBlockMaskVariables(1:end-1),';');
foundIndex = false;
for k=1:length(words)
    [name,index] = ParseEqualAmpersand(words{k});
    
    if(strcmp(name,'JoystickID'))
        foundIndex = true;
        break
    end
end

if(~foundIndex)
    error('animation_joystickID_CB: The nested block does not appear to have the variable we are looking to set.')
end

%What are the currently set values
nestedBlockMaskValuesCurrent = get_param(nestedBlockString,'MaskValues');

%What values doe we want to set the nested block with
nestedBlockMaskValuesDesired = nestedBlockMaskValuesCurrent;
nestedBlockMaskValuesDesired{index} = desiredNestedPopupValue;

%Set the values of the nestedMyMaskedSystem
set_param(nestedBlockString, 'MaskValues', nestedBlockMaskValuesDesired);

end



function [name, index] = ParseEqualAmpersand(s)
%PARSEEQUALAMPERSAND  parses a string
%
%   [name, index] = PARSEEQUALAMPERSAND(s) parses a string of the form
%   'name=@index' and returns the name as a string and the index as a
%   double.
%
%   Example
%
%       [name, index] = ParseEqualAmpersand('offset=@3')
%
%INPUT:     -s:     string to parse
%
%OUTPUT:    -name:  name
%           -index: index
%
%Created by Christopher Lum
%lum@u.washington.edu

%Version History:   -06/12/12: Created

%----------------------OBTAIN USER PREFERENCES-----------------------------


%-----------------------CHECKING DATA FORMAT-------------------------------


%-------------------------BEGIN CALCULATIONS-------------------------------
equalIndex = find(s=='=');
if(length(equalIndex)~=1)
    error('Should only have 1 equal sign')
end

%make sure the next char is an ampersand
ampersand = s(equalIndex+1);
if(ampersand ~= '@')
    error('Equals sign should be followed by an ampersand')
end

%Parse the string
name = s(1:equalIndex-1);
index = str2num(s(equalIndex+2:end));

end