%The MNIST data set is stored as raw data (bytes) and must be parsed to
%obtain individual images and labels.
%
%See http://yann.lecun.com/exdb/mnist/ for more info
%
%Christopher Lum
%lum@uw.edu

%Version History
%01/29/23: Created

clear
clc
close all

tic

%% User selections
samplesBetweenDiagnostics = 500;
outputFileName = 'MNISTData.mat';

%% Load parameters
temp = load('MNISTInfo.mat');
MNISTInfo = temp.MNISTInfo;

%% Parse data
%TrainingSetImages
fileName = [MNISTInfo.outputFolderTrainingSetImages,'\',MNISTInfo.outputFolderTrainingSetImages];
disp(['Now reading from ',fileName])

try
    permission = 'r';
    machinefmt = 'b';   %pursuant to MNIST documentation, data is stored in 'Big-endian' format
    fileID = fopen(fileName,permission,machinefmt);
    
    magicNumber = fread(fileID,1,'int32');
    assert(magicNumber==2051)
    
    numItems = fread(fileID,1,'int32');
    disp(['numItems = ',num2str(numItems)])
    
    numRows = fread(fileID,1,'int32');
    assert(numRows==28)
    
    numCols = fread(fileID,1,'int32');
    assert(numCols==28)
    
    TrainingSetImages = uint8(zeros(numRows,numCols,numItems));
    for k=1:numItems
        A = uint8(zeros(numRows,numCols));
        for m=1:numRows
            for n=1:numCols
                A(m,n) = fread(fileID,1,'uint8');
            end
        end
        
        TrainingSetImages(:,:,k) = A;
        
        if(mod(k,samplesBetweenDiagnostics)==0)
            disp([num2str(k/numItems*100),'% complete'])
        end
    end

    assert(max(max(max(TrainingSetImages)))<=255)
    assert(min(min(min(TrainingSetImages)))>=0)
        
    fclose(fileID);
    
catch ME
    warning(ME.message)
    fclose(fileID);
    
end
disp(' ')

%TrainingSetLabels
fileName = [MNISTInfo.outputFolderTrainingSetLabels,'\',MNISTInfo.outputFolderTrainingSetLabels];
disp(['Now reading from ',fileName])

try
    permission = 'r';
    machinefmt = 'b';   %pursuant to MNIST documentation, data is stored in 'Big-endian' format
    fileID = fopen(fileName,permission,machinefmt);
    
    magicNumber = fread(fileID,1,'int32');
    assert(magicNumber==2049)
    
    numItems = fread(fileID,1,'int32');
    disp(['numItems = ',num2str(numItems)])
    
    TrainingSetLabels = uint8(zeros(numItems,1));
    for k=1:numItems
        TrainingSetLabels(k) = fread(fileID,1,'uint8');
    end
    
    assert(max(TrainingSetLabels)<=9)
    assert(min(TrainingSetLabels)>=0)
    
    fclose(fileID);
    
catch ME
    warning(ME.message)
    fclose(fileID);
    
end
disp(' ')

%TestSetImages
fileName = [MNISTInfo.outputFolderTestSetImages,'\',MNISTInfo.outputFolderTestSetImages];
disp(['Now reading from ',fileName])

try
    permission = 'r';
    machinefmt = 'b';   %pursuant to MNIST documentation, data is stored in 'Big-endian' format
    fileID = fopen(fileName,permission,machinefmt);
    
    magicNumber = fread(fileID,1,'int32');
    assert(magicNumber==2051)
    
    numItems = fread(fileID,1,'int32');
    disp(['numItems = ',num2str(numItems)])
    
    numRows = fread(fileID,1,'int32');
    assert(numRows==28)
    
    numCols = fread(fileID,1,'int32');
    assert(numCols==28)
    
    TestSetImages = uint8(zeros(numRows,numCols,numItems));
    for k=1:numItems
        A = uint8(zeros(numRows,numCols));
        for m=1:numRows
            for n=1:numCols
                A(m,n) = fread(fileID,1,'uint8');
            end
        end
        
        TestSetImages(:,:,k) = A;
        
        if(mod(k,samplesBetweenDiagnostics)==0)
            disp([num2str(k/numItems*100),'% complete'])
        end
    end

    assert(max(max(max(TestSetImages)))<=255)
    assert(min(min(min(TestSetImages)))>=0)
        
    fclose(fileID);
    
catch ME
    warning(ME.message)
    fclose(fileID);
    
end
disp(' ')

%TestSetLabels
fileName = [MNISTInfo.outputFolderTestSetLabels,'\',MNISTInfo.outputFolderTestSetLabels];
disp(['Now reading from ',fileName])

try
    permission = 'r';
    machinefmt = 'b';   %pursuant to MNIST documentation, data is stored in 'Big-endian' format
    fileID = fopen(fileName,permission,machinefmt);
    
    magicNumber = fread(fileID,1,'int32');
    assert(magicNumber==2049)
    
    numItems = fread(fileID,1,'int32');
    disp(['numItems = ',num2str(numItems)])
    
    TestSetLabels = uint8(zeros(numItems,1));
    for k=1:numItems
        TestSetLabels(k) = fread(fileID,1,'uint8');
    end
    
    assert(max(TestSetLabels)<=9)
    assert(min(TestSetLabels)>=0)
    
    fclose(fileID);
    
catch ME
    warning(ME.message)
    fclose(fileID);
    
end
disp(' ')

%% Save data
save(outputFileName,'TrainingSetImages','TrainingSetLabels','TestSetImages','TestSetLabels')
disp(['Saved to ',outputFileName])

toc
disp('DONE!')