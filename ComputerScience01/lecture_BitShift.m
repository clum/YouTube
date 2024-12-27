function [] = lecture_BitShift()

%Demonstrate logical vs. arthimetic shift.
%
%Christopher Lum
%lum@uw.edu

%Version History
%12/24/24: Created

clear
clc
close all

%% user selections
numBits = 8;

%% left shift (unsigned value)
disp('LEFT SHIFT (UNSIGNED VALUE)')
x_uint8 = uint8(0b00101001);
PrintStats(x_uint8,numBits)

%shift left by 1
x_uint8_L1 = bitshift(x_uint8,1);
PrintStats(x_uint8_L1,numBits)

%shift left by 2
x_uint8_L2 = bitshift(x_uint8,2);
PrintStats(x_uint8_L2,numBits)

%shift left by 3 (overflow occurs)
x_uint8_L3 = bitshift(x_uint8,3); 
PrintStats(x_uint8_L3,numBits)

disp(' ')

%% left shift (signed value)
disp('LEFT SHIFT (SIGNED VALUE)')
x_int8 = int8(x_uint8);
PrintStats(x_int8,numBits)

%shift left by 1
x_int8_L1 = bitshift(x_int8,1);
PrintStats(x_int8_L1,numBits)

%shift left by 2 (overflow occurs, sign changes)
x_int8_L2 = bitshift(x_int8,2);
PrintStats(x_int8_L2,numBits)

x_int8_L3 = bitshift(x_int8,3);
PrintStats(x_int8_L3,numBits)

disp(' ')

%% right shift (unsigned value)
disp('RIGHT SHIFT (UNSIGNED VALUE)')
x_uint8 = uint8(0b10101001);
PrintStats(x_uint8,numBits)

%shift right by 1
x_uint8_R1 = bitshift(x_uint8,-1);
PrintStats(x_uint8_R1,numBits)

%shift right by 2
x_uint8_R2 = bitshift(x_uint8,-2);
PrintStats(x_uint8_R2,numBits)

%shift right by 3
x_uint8_R3 = bitshift(x_uint8,-3);
PrintStats(x_uint8_R3,numBits)

%shift right by 4
x_uint8_R4 = bitshift(x_uint8,-4);
PrintStats(x_uint8_R4,numBits)

%shift right by 5
x_uint8_R5 = bitshift(x_uint8,-5);
PrintStats(x_uint8_R5,numBits)

%shift right by 6
x_uint8_R6 = bitshift(x_uint8,-6);
PrintStats(x_uint8_R6,numBits)

%shift right by 7
x_uint8_R7 = bitshift(x_uint8,-7);
PrintStats(x_uint8_R7,numBits)

%shift right by 8
x_uint8_R8 = bitshift(x_uint8,-8);
PrintStats(x_uint8_R8,numBits)

disp(' ')

%% left shift (signed negative value)
disp('RIGHT SHIFT (SIGNED NEGATIVE VALUE)')

%Note that casting x_uint8 to int8 actually saturates to the maximum
%positive value
disp('Demonstrating casting')
x_int8 = int8(x_uint8); 
PrintStats(x_int8,numBits)
disp(' ')

%Redefine (0b10101001 = -87)
x_int8 = int8(-87);
PrintStats(x_int8,numBits)

%shift right by 1 (notice sign extension)
x_int8_R1 = bitshift(x_int8,-1);
PrintStats(x_int8_R1,numBits)

%shift right by 2 (notice sign extension)
x_int8_R2 = bitshift(x_int8,-2);
PrintStats(x_int8_R2,numBits)

%shift right by 3 (notice sign extension)
x_int8_R3 = bitshift(x_int8,-3);
PrintStats(x_int8_R3,numBits)

%shift right by 4 (notice sign extension)
x_int8_R4 = bitshift(x_int8,-4);
PrintStats(x_int8_R4,numBits)

%shift right by 5 (notice sign extension)
x_int8_R5 = bitshift(x_int8,-5);
PrintStats(x_int8_R5,numBits)

%shift right by 6 (notice sign extension)
x_int8_R6 = bitshift(x_int8,-6);
PrintStats(x_int8_R6,numBits)

%shift right by 7 (notice sign extension)
x_int8_R7 = bitshift(x_int8,-7);
PrintStats(x_int8_R7,numBits)

%shift right by 8 (notice sign extension)
x_int8_R8 = bitshift(x_int8,-8);
PrintStats(x_int8_R8,numBits)

disp(' ')

%% left shift (signed positive value)
disp('RIGHT SHIFT (SIGNED POSITIVE VALUE)')

%Redefine (0b10101001 = -87)
x_int8 = int8(0b00010011);
PrintStats(x_int8,numBits)

%shift right by 1 (notice sign extension)
x_int8_R1 = bitshift(x_int8,-1);
PrintStats(x_int8_R1,numBits)

%shift right by 2
x_int8_R2 = bitshift(x_int8,-2);
PrintStats(x_int8_R2,numBits)

%shift right by 3
x_int8_R3 = bitshift(x_int8,-3);
PrintStats(x_int8_R3,numBits)

%shift right by 4
x_int8_R4 = bitshift(x_int8,-4);
PrintStats(x_int8_R4,numBits)

%shift right by 5
x_int8_R5 = bitshift(x_int8,-5);
PrintStats(x_int8_R5,numBits)

disp('DONE!')

end

function [] = PrintStats(x,numBits)
    disp(['binary: ',dec2bin(x,numBits),' | decimal: ',num2str(x),' | type: ',class(x)]);
end