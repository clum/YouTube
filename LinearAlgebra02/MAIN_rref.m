%Illustrate reduced row echelon form.
%
%Christopher Lum
%lum@uw.edu

%Version History
%09/10/23: Created

clear
clc
close all

Atilde = [
    1 2 -2 4;
    2 3 1 3;
    3 0 -1 2
    ];

rref(Atilde)

disp('DONE!')