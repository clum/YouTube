%Demonstrate using readtable to import csv files
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
%csv files
inputFile = '.\csv\FileStructure_A.csv';            %(PASS) full table, works
% inputFile = '.\csv\FileStructure_B.csv';            %(PASS) missing entries after first row, works
% inputFile = '.\csv\FileStructure_C.csv';            %(PASS) missing single entry in first row, works
% inputFile = '.\csv\FileStructure_D.csv';            %(FAIL>PASS) missing three entries in first row, fails
% inputFile = '.\csv\FileStructure_E.csv';            %(FAIL>PASS) missing three entries in first row and missing entries in subsequent rows, fails
% inputFile = '.\csv\CoworkerFileStructure.csv';      %(PASS) file with more than 4 rows

%% read data via readtable
% T = readtable(inputFile)
T = ImportCSVData(inputFile)