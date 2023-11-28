%Example showing binomial distributions
%
%Christopher Lum
%lum@uw.edu

clear
clc
close all

%% User selections
%weights for RouletteWheel function
W = [1 1 1 1 1 1];
n = 4;  %number of trials in a single game

numGames = 100000;

%% Play game many times
disp(['Now playing game ',num2str(numGames),' times'])
numGamesWithAtLeastTwoSixes = 0;
for k=1:numGames
    %Roll die 4 times
    results = RouletteWheel(W,n);
    
    numSixes = length(find(results==6));
    
    if(numSixes>=2)
        numGamesWithAtLeastTwoSixes = numGamesWithAtLeastTwoSixes + 1;    
    end
end

%Display probability
disp(['Probability of games with at least 2 sixes = ',num2str(numGamesWithAtLeastTwoSixes/numGames)])