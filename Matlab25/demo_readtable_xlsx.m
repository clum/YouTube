%Demonstrate using readtable to import xlsx files
%
%This script accompanies the YouTube video at https://youtu.be/tYkIt16bggw
%
%Christopher Lum
%lum@uw.edu

%Version History
%02/24/24: Created

clear
clc
close all

%% User selection
%xlsx files
inputFile = '.\xlsx\FileStructure_A.xlsx';          %(PASS) full table
% inputFile = '.\xlsx\FileStructure_B.xlsx';          %(PASS) missing entries after first row
% inputFile = '.\xlsx\FileStructure_C.xlsx';          %(PASS) missing single entry in first row
% inputFile = '.\xlsx\FileStructure_D.xlsx';          %(FAIL>PASS) missing three entries in first row
% inputFile = '.\xlsx\FileStructure_E.xlsx';          %(FAIL>PASS) missing three entries in first row and missing entries in subsequent rows
% inputFile = '.\xlsx\CoworkerFileStructure.xlsx';    %(FAIL>PASS)file with more than 4 rows

%% read data via readtable
% T = readtable(inputFile)
T = ImportXLSXData(inputFile)

disp('DONE!')