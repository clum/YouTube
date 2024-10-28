%Code listing that can be used in the notes
N = 6;
DeltaX = 1/5;

x = [0:DeltaX:(N-1)*DeltaX]'

f = 5 + 2*cos(2*pi*x - pi/2) + 3*cos(4*pi*x)

fhat = fft(f)