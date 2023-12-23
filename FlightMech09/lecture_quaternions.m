%Christopher Lum
%lum@uw.edu
%
%Investigate quaternions using the same example we looked at when
%discussing Euler angles.

%Version History
%04/05/20: Created
%12/23/23: Moved to YouTube GitHub

clear
clc
close all

%Define rotation angles
psi = 70*pi/180;
theta = 130*pi/180;
phi = 25*pi/180;

%Compute Cbv
C1v = [cos(psi) sin(psi) 0;
    -sin(psi) cos(psi) 0;
    0 0 1];

C21 = [cos(theta) 0 -sin(theta);
    0 1 0;
    sin(theta) 0 cos(theta)];

Cb2 = [1 0 0;
    0 cos(phi) sin(phi);
    0 -sin(phi) cos(phi)];

Cbv = Cb2*C21*C1v;

%Get eigenvalues and eigenvectors
[V,D] = eig(Cbv)

idxUnityEigenvalue = 3;
lambda = D(idxUnityEigenvalue,idxUnityEigenvalue);
n = V(:,idxUnityEigenvalue);

tol = 10e-6;
assert(LumFunctionsMisc.AreValuesApproximatelyEqual(lambda,1,tol))
assert(max(abs(Cbv*n - lambda*n))<tol)

%Compute equivalent quaternion using an approximate value of the rotation
%(we guess that is approximately a left handed rotation through 233.5 deg)
e = n./(norm(n));

mu = deg2rad(233.5);            %This is a left handed rotation
theta2 = -mu + 2*pi;            %Convert to a right handed rotation and make positive
s = cos(theta2/2)
v = e*sin(theta2/2);

q = [s;v]

%Compute the actual quaternion associated with the Euler rotation
q_matlab = angle2quat(psi, theta, phi); %Note order of inputs!

%Compute the exact value of the transformation/rotation angle
qs_matlab = q_matlab(1);
theta_exact = 2*acos(qs_matlab);
rad2deg(theta_exact)

%Compare the axis of rotation (e vs. eigenvector)
v_matlab = q_matlab(2:4);
e_matlab = v_matlab*(1/sin(theta_exact/2))

%cross product between the axis of rotation from the quaternion and the
%axis of rotation from the eigenvector analysis should be the same
sum(abs(cross(e_matlab, n)))

disp('DONE!')