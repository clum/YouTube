function [X] = rand2(varargin)

%RAND2  Generates a uniformly distributed random number in an interval
%
%   [X] = RAND2(LB,UB) Generates a random sample in the interval [LB,UB].
%   This makes use of the built in function RAND
%
%   [X] = RAND2(LB,UB,N) Generates N samples in the interval [LB,UB]
%   returned as a 1xN vector.
%
%
%INPUT:     -LB:    lower bound
%           -UB:    upper bound
%           -N:     number of samples (optional)
%
%OUTPUT:    -X:     vector of samples between lb and ub
%
%Created by Christopher Lum
%lum@uw.edu

%Version History
%03/02/06: Created
%12/06/06: Updated documentation
%12/08/06: Updated documentation and allowed for variable number of inputs
%10/23/07: Updated documentation
%01/08/08: Allowed lower bound to be equal to upper bound
%02/28/17: Update to version history documentation
%04/23/17: Changed email address of contact info
%05/21/19: Fixed whitespacing

%----------------------OBTAIN USER PREFERENCES-----------------------------
switch nargin
    case 3
        %User supplies all inputs
        LB = varargin{1};
        UB = varargin{2};
        N  = varargin{3};
        
    case 2
        %Assume user only wants 1 sample
        LB = varargin{1};
        UB = varargin{2};
        N  = 1;
        
    otherwise
        error('Invalid number of inputs');
end

%-----------------------CHECKING DATA FORMAT-------------------------------
[n_lb,m_lb] = size(LB);
[n_ub,m_ub] = size(UB);
[n_N,m_N] = size(N);

if (n_lb>1) || (m_lb>1)
    error('Lower bound must be a scalar')
end

if (n_ub>1) || (m_ub>1)
    error('Upper bound must be a scalar')
end

if (n_N>1) || (m_N>1)
    error('Number of samples must be a scalar')
end

if (LB>UB)
    error('Upper bound must be greater than or equal to lower bound')
end

%-------------------------BEGIN CALCULATIONS-------------------------------
%Generate sample in range [0,1]
y = rand(1,N);

X = y*(UB-LB) + LB;