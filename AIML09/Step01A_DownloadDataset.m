%Obtain and unzip the MNIST data set.
%
%See http://yann.lecun.com/exdb/mnist/ for more info
%
%Christopher Lum
%lum@uw.edu

%Version History
%01/29/23: Created
%01/30/23: Adding information about path.  Fixing issue w/ unzip overwrite

clear
clc
close all

tic

%% User selections
fileNameTrainingSetImages   = 'train-images-idx3-ubyte.gz';
fileNameTrainingSetLabels   = 'train-labels-idx1-ubyte.gz';

fileNameTestSetImages       = 't10k-images-idx3-ubyte.gz';
fileNameTestSetLabels       = 't10k-labels-idx1-ubyte.gz';

downloadBaseURL             = 'http://yann.lecun.com/exdb/mnist';

outputFileName              = 'MNISTInfo.mat';

%% Download data
if(~exist(fileNameTrainingSetImages))
    disp(['Downloading ',fileNameTrainingSetImages]);
    websave(fileNameTrainingSetImages,[downloadBaseURL,'/',fileNameTrainingSetImages]);
end

if(~exist(fileNameTrainingSetLabels))
    disp(['Downloading ',fileNameTrainingSetLabels]);
    websave(fileNameTrainingSetLabels,[downloadBaseURL,'/',fileNameTrainingSetLabels]);
end

if(~exist(fileNameTestSetImages))
    disp(['Downloading ',fileNameTestSetImages]);
    websave(fileNameTestSetImages,[downloadBaseURL,'/',fileNameTestSetImages]);
end

if(~exist(fileNameTestSetLabels))
    disp(['Downloading ',fileNameTestSetLabels]);
    websave(fileNameTestSetLabels,[downloadBaseURL,'/',fileNameTestSetLabels]);
end

%% Unzip data
disp('Unzipping data')
[outputFolderTrainingSetImages,~] = SeperateFileNameAndExtension(fileNameTrainingSetImages);
if(~exist(outputFolderTrainingSetImages))
    gunzip(fileNameTrainingSetImages,outputFolderTrainingSetImages)
end

[outputFolderTrainingSetLabels,~] = SeperateFileNameAndExtension(fileNameTrainingSetLabels);
if(~exist(outputFolderTrainingSetLabels))
    gunzip(fileNameTrainingSetLabels,outputFolderTrainingSetLabels)
end

[outputFolderTestSetImages,~] = SeperateFileNameAndExtension(fileNameTestSetImages);
if(~exist(outputFolderTestSetImages))
    gunzip(fileNameTestSetImages,outputFolderTestSetImages)
end

[outputFolderTestSetLabels,~] = SeperateFileNameAndExtension(fileNameTestSetLabels);
if(~exist(outputFolderTestSetLabels))
    gunzip(fileNameTestSetLabels,outputFolderTestSetLabels)
end

%% Save relevant information
MNISTInfo.outputFolderTrainingSetImages = outputFolderTrainingSetImages;
MNISTInfo.outputFolderTrainingSetLabels = outputFolderTrainingSetLabels;
MNISTInfo.outputFolderTestSetImages     = outputFolderTestSetImages;
MNISTInfo.outputFolderTestSetLabels     = outputFolderTestSetLabels;

cwd = pwd;
MNISTInfo.ApplicationDirectory = fileparts(cwd);

save(outputFileName,'MNISTInfo')
disp(['Saved to ',outputFileName])

toc
disp('DONE!')