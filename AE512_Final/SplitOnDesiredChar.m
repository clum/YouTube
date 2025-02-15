function [varargout] = SplitOnDesiredChar(varargin)

%SPLITONDESIREDCHAR Splits a string into a 1xN cell array
%
%   [X] = SPLITONDESIREDCHAR(S, DELINIATOR) Splits the string S into a 1 x
%   N cell array of words which are delinated by the DELINIATOR.
%
%See also LoadTextData, LoadTextDataMatrix
%
%INPUT:     -S:          string to split
%           -DELINIATOR: character to use as column deliniator
%
%OUTPUT:    -X:           1 x N cell array of words
%
%Created by Christopher Lum
%lum@u.washington.edu

%Version History:   -10/16/08: Created

%----------------------OBTAIN USER PREFERENCES-----------------------------
switch nargin        
    case 2
        %User supplies all inputs
        S           = varargin{1};
        DELINIATOR  = varargin{2};
                
    otherwise
        error('Invalid number of inputs');
end


%-----------------------CHECKING DATA FORMAT-------------------------------
% S
if(~isstr(S))
    error('S must be a string')
end

% DELINIATOR
if(~ischar(DELINIATOR))
    error('DELINIATOR must be a char')
end


%-------------------------BEGIN CALCULATIONS-------------------------------
X = {};
if(isempty(S))
    %S is empty, return an empty cell array

else
    %S is non-empty
    wordStartIndex = 1;
    wordEndIndex = length(S);
    for k=1:length(S)
        if (S(k)==DELINIATOR)
            wordEndIndex = k;
            
            if((wordEndIndex-1) < wordStartIndex)
                %encountered two DELINIATOR in a row, this should be empty
                currentWord = '';
            else
                currentWord = S(wordStartIndex:wordEndIndex-1);
            end
            X{1,end+1} = currentWord;
            wordStartIndex = wordEndIndex + 1;
        end
    end
    
    %Push the back the remainder
    if(wordStartIndex > length(S))
        currentWord = '';
    else
        currentWord = S(wordStartIndex:end);
    end
    X{1,end+1} = currentWord;
end

%Output the object
varargout{1} = X;

