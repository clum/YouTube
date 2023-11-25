%Familiarize with the MNIST data set
%
%Christopher Lum
%lum@uw.edu

%Version History
%01/29/23: Created
%05/21/23: Moved to another folder
%11/24/23: Updated

clear
clc
close all

ChangeWorkingDirectoryToThisLocation();

tic

%% User selections
M       = 3;            %num rows in subplot
N       = 3;            %num cols in subplot
set     = 'training';    %'training' or 'testing'

%% Load data
temp = load('MNISTInfo.mat');
MNISTInfo = temp.MNISTInfo;

temp2 = load('MNISTData.mat');
TrainingSetImages   = temp2.TrainingSetImages;
TrainingSetLabels   = temp2.TrainingSetLabels;
TestSetImages       = temp2.TestSetImages;
TestSetLabels       = temp2.TestSetLabels;

%% Visualize some random samples
%View image and label
figure('Name',['set = ',set])
k = 1;
for m=1:M
    for n=1:N
        subplot(M,N,k)
        
        %Chose a random index
        switch set
            case 'training'
                numImages = length(TrainingSetLabels);
                
            case 'testing'
                numImages = length(TestSetLabels);
                
            otherwise
                error('Unsupported set')
        end
        
        idx = floor(rand(1)*numImages);
        
        %Chose which set of data
        switch set
            case 'training'
                A       = TrainingSetImages(:,:,idx);
                label   = TrainingSetLabels(idx);
        
            case 'testing'
                A       = TestSetImages(:,:,idx);
                label   = TestSetLabels(idx);
                
            otherwise
                error('Unsupported set')
        end
        
        imshow(A)
        title(['idx ',num2str(idx),',  Label ' ,num2str(label)])
        
        k = k + 1;
    end
end

%% Visualize ambiguous examples
indices = [
    57487;
    35645;
    38231
    ];

figure
for k=1:length(indices)
    idx = indices(k);
    label = TrainingSetLabels(idx);
    subplot(1,length(indices),k)
    imshow(TrainingSetImages(:,:,idx))
    title(['idx ',num2str(idx),',  Label ' ,num2str(label)])        
end

toc
disp('DONE!')