%Generate plots to include in the lecture regarding hand sketching Bode
%plots
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/11/12: Created
%12/08/12: Updated documentation
%11/18/14: Updated
%04/22/19: Updated and improved complex conjugate plots
%04/24/19: Fixed bug where it was not in standard bode plot form
%01/06/25: Minor update

clear
clc
close all

%Single real pole
p = 0.3;

Gnum = [1];
Gden = [1/p 1];

G = tf(Gnum, Gden);

figure
bode(G)
grid on
title(['Single Real Pole at p = ',num2str(p)])

%Single real zero
z = 2;
Gnum = [1/z 1];
Gden = [1];

G = tf(Gnum,Gden)

figure
bode(G)
grid on
title(['Single Real Zero at z = ',num2str(z)])

%Single pole at origin
Gnum = [1];
Gden = [1 0];

G = tf(Gnum, Gden);

figure
w = logspace(-2,2,100);
bode(G,w)
grid on
title('Single Pole at Origin')

%Single zero at origin
Gnum = [1 0];
Gden = [1];

G = tf(Gnum, Gden);

figure
w = logspace(-2,2,100);
bode(G,w)
grid on
title('Single Zero at Origin')

%Complex conjuage pair of poles
%Also see hw10_p3.m
zeta = 0.1;
wn = 10;
Gnum = [1];
Gden = [1/wn^2 2*zeta/wn 1];

G = tf(Gnum,Gden);

figure
bode(G);
grid on
title(['Pair of Complex Conjugate Poles with \zeta = ',num2str(zeta), ', \omega_n = ',num2str(wn)])

%Complex conjugate pair of zeros
zeta = 0.1;
wn = 10;
Gnum = [1/wn^2 2*zeta/wn 1];
Gden = [1];

G = tf(Gnum,Gden);

figure
bode(G);
grid on
title(['Pair of Complex Conjugate Zeros with \zeta = ',num2str(zeta), ', \omega_n = ',num2str(wn)])

%Constant gain
K = 3;
Gnum = [K];
Gden = [1];

G = tf(Gnum,Gden);

figure
bode(G);
grid on
title(['Constant gain of ',num2str(K)])

disp('DONE')