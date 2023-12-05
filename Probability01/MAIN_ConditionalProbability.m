%Christopher Lum
%lum@uw.edu
%
%Illustrate conditional probability using an example of boys and girls in a
%family.  
%
%Suppose that a family has 2 children.   Assuming there is an equal
%likelihood of having a boy or girl, there are two questions we would like
%to answer.
%
%   1.  What is the probability that the first child is a girl?
%   2.  What is the probility that both children are girls?
%   3.  You learn that one of the children is a girl.  What is the
%       probability that the other child is a girl as well?

%Version History:
%??/??/??: Created
%11/27/17: Changed to focus on girls and switched order and documentation
%11/11/22: Fixed script (some lines were deleted accidentally)
%11/27/23: Minor update to documentation

clear
clc
close all

%Define number of trials
N = 20000;

disp(['Running experiment for ',num2str(N),' trials'])
disp(' ')

%Determine the makeup of the family
%
%   1 = girl
%   0 = boy

for k=1:N
    %Conduct an experiment
    if(rand(1) > 0.5)
        child1(k) = 1;
    else
        child1(k) = 0;
    end
    
    if(rand(1) > 0.5)
        child2(k) = 1;
    else
        child2(k) = 0;
    end
end

%Question 1: What is the probability that child1 is a girl?
p1 = sum(child1)/length(child1);

disp(['Question 1: Probability of first child being a girl = ',num2str(p1)])

%Question 2: What is the probability that both children are girls
numCasesWithBothGirls = 0;
for k=1:N
    if(child1(k)==1 && child2(k)==1)
        numCasesWithBothGirls = numCasesWithBothGirls + 1;
    end
end

p2 = numCasesWithBothGirls / N;
disp(['Question 2: Probability of both children being girls = ',num2str(p2)])

%Question 3: We know that one child is a girl, what is the probability that
%the other child is a girl as well.
numCasesWithAtLeastOneGirl  = 0;
numCasesWithTwoGirls        = 0;
for k=1:N
    if(child1(k)==1 || child2(k)==1)
        numCasesWithAtLeastOneGirl = numCasesWithAtLeastOneGirl + 1;
    
        %Is the other child a girl as well?        
        if(child1(k) == 1 && child2(k) == 1)
            numCasesWithTwoGirls = numCasesWithTwoGirls + 1;
        end
    end
end

p3 = numCasesWithTwoGirls / numCasesWithAtLeastOneGirl;
disp(['Question 3: Probability of other child being a girl if we know the one is a girl = ',num2str(p3)])
disp(' ')

disp('DONE!')