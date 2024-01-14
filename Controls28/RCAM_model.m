function XDOT = RCAM_model(X, U)

%RCAM_MODEL Full 9 DOF model for RCAM aircraft
%
%   [XDOT] = RCAM_MODEL(X,U) returns the longitudinal state
%   derivatives, XDOT, given the current state and inputs, X and U.  The
%   constants are the nominal constants.
%
%   State vector X and input vector U is defined as
%   
%       X = [u;v;w;p;q;r;phi;theta;psi] = [x1;x2;x3;x4;x5;x6;x7;x8;x9]
%       U = [d_A;d_T;d_R;d_th1;d_th2] = [u1;u2;u3;u4;u5]
%
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/22/04: Created 
%11/23/04: Worked out some bugs.
%11/29/04: Fixed bug on line 227 (changed x8 to x9)
%05/23/05: Changed state vector.  Now last three states are
%          [phi;theta;psi], not [psi;theta;phi].
%11/14/08: Made this standalone (so don't need CL_wb_function.m and
%          CD_function.m anymore).
%08/10/11: Now using alternative method for moment transfers
%08/11/11: Changed thrust to use Umax parameter
%05/09/20: Changed to atan2

%-----------------------CONSTANTS-------------------------------
%Nominal vehicle constants
m = 120000;                     %Aircraft total mass (kg)

cbar = 6.6;                     %Mean Aerodynamic Chord (m)
lt = 24.8;                      %Distance by AC of tail and body (m)
S = 260;                        %Wing planform area (m^2)
St = 64;                        %Tail planform area (m^2)

Xcg = 0.23*cbar;                %x position of CoG in Fm (m)
Ycg = 0;                        %y position of CoG in Fm (m)
Zcg = 0.10*cbar;                %z position of CoG in Fm (m)

Xac = 0.12*cbar;                %x position of aerodynamic center in Fm (m)
Yac = 0;                        %y position of aerodynamic center in Fm (m)
Zac = 0;                        %z position of aerodynamic center in Fm (m)

%Engine inputs
Umax  = 120000*9.81;            %maximum thrust provided by one engine (N)

Xapt1 = 0;                      %x position of engine 1 force in Fm (m)
Yapt1 = -7.94;                  %y position of engine 1 force in Fm (m)
Zapt1 = -1.9;                   %z position of engine 1 force in Fm (m)

Xapt2 = 0;                      %x position of engine 2 force in Fm (m)
Yapt2 = 7.94;                   %y position of engine 2 force in Fm (m)
Zapt2 = -1.9;                   %z position of engine 2 force in Fm (m)

%Other constants
rho = 1.225;                    %Air density (kg/m^3)
g = 9.81;                       %Gravitational acceleration (m/s^2)
depsda = 0.25;                  %Change in downwash w.r.t. alpha (rad/rad)
alpha_L0 = -11.5*pi/180;        %Zero lift angle of attack (rad)
n = 5.5;                        %Slope of linear region of lift slope
a3 = -768.5;                    %Coefficient of alpha^3
a2 = 609.2;                     %Coefficient of alpha^2
a1 = -155.2;                    %Coefficient of alpha^1
a0 = 15.2;                      %Coefficient of alpha^0
alpha_switch = 14.5*(pi/180);   %alpha where lift slope goes from linear to non-linear

%--------------------------STATE VECTOR----------------------------------
%Extract state vector
x1 = X(1);                              %u
x2 = X(2);                              %v
x3 = X(3);                              %w
x4 = X(4);                              %p
x5 = X(5);                              %q
x6 = X(6);                              %r
x7 = X(7);                              %phi
x8 = X(8);                              %theta
x9 = X(9);                              %psi

u1 = U(1);                              %d_A (aileron)
u2 = U(2);                              %d_T (stabilizer)
u3 = U(3);                              %d_R (rudder)
u4 = U(4);                              %d_th1 (throttle 1)
u5 = U(5);                              %d_th2 (throttle 2)

%---------------INTERMEDIATE VARIABLES------------------------
%Calculate airspeed
Va = sqrt(x1^2 + x2^2 + x3^2);

%Calculate alpha and beta
alpha = atan2(x3,x1);
beta = asin(x2/Va);

%Calculate dynamic pressure
Q = 0.5*rho*Va^2;

%Also define the vectors wbe_b and V_b 
wbe_b = [x4;x5;x6];
V_b = [x1;x2;x3];

%---------------AERODYNAMIC FORCE COEFFICIENTS----------------
%Calculate the CL_wb
if alpha<=alpha_switch
    CL_wb = n*(alpha - alpha_L0);
else
    CL_wb = a3*alpha^3 + a2*alpha^2 + a1*alpha + a0;
end

%Calculate CL_t
epsilon = depsda*(alpha - alpha_L0);
alpha_t = alpha - epsilon + u2 + 1.3*x5*lt/Va;
CL_t = 3.1*(St/S)*alpha_t;

%Total lift force
CL = CL_wb + CL_t;

%Total drag force (neglecting tail)
CD =  0.13 + 0.07*(5.5*alpha + 0.654)^2;

%Calculate sideforce
CY = -1.6*beta + 0.24*u3;

%--------------DIMENSIONAL AERODYNAMIC FORCES---------------------
%Calculate the actual dimensional forces.  These are in F_s (stability axis)
FA_s = [-CD*Q*S;
         CY*Q*S;
        -CL*Q*S];
    
%Rotate these forces to F_b (body axis)
C_bs = [cos(alpha) 0 -sin(alpha);
        0 1 0;
        sin(alpha) 0 cos(alpha)];
    
FA_b = C_bs*FA_s;

%--------------AERODYNAMIC MOMENT ABOUT AC-------------------
%Calculate the moments in Fb.  Define eta, dCMdx and dCMdu
eta11 = -1.4*beta;
eta21 = -0.59 - (3.1*(St*lt)/(S*cbar))*(alpha - epsilon);
eta31 = (1 - alpha*(180/(15*pi)))*beta;

eta = [eta11;
       eta21;
       eta31];

dCMdx = (cbar/Va)*[-11 0 5;
                    0 (-4.03*(St*lt^2)/(S*cbar^2)) 0;
                    1.7 0 -11.5];
              
dCMdu = [-0.6 0 0.22;
          0 (-3.1*(St*lt)/(S*cbar)) 0;
          0 0 -0.63];

%Now calculate CM = [Cl;Cm;Cn] about Aerodynamic center in Fb
CMac_b = eta + dCMdx*wbe_b + dCMdu*[u1;u2;u3];

%Normalize to an aerodynamic moment
MAac_b = CMac_b*Q*S*cbar;

%OPTIONAL: Covert this to stability axis
C_sb = C_bs';
Mac_b = CMac_b*Q*S*cbar;
Mac_s = C_sb*Mac_b;
CMac_s = Mac_s./(Q*S*cbar);
CMac_s = C_sb*CMac_b;

%--------------AERODYNAMIC MOMENT ABOUT CG-------------------
%Transfer moment to cg
rcg_b = [Xcg;Ycg;Zcg];
rac_b = [Xac;Yac;Zac];
MAcg_b = C_bs*Mac_s + cross(FA_b,rcg_b - rac_b);

%-----------------ENGINE FORCE & MOMENT----------------------------
%Now effect of engine.  First, calculate the thrust of each engine
F1 = u4*Umax;
F2 = u5*Umax;

%Assuming that engine thrust is aligned with Fb, we have
FE1_b = [F1;0;0];
FE2_b = [F2;0;0];

FE_b = FE1_b + FE2_b;
  
%Now engine moment due to offset of engine thrust from CoG.
mew1 = [Xcg - Xapt1;
        Yapt1 - Ycg;
        Zcg - Zapt1];
        
mew2 = [Xcg - Xapt2;
        Yapt2 - Ycg;
        Zcg - Zapt2];

        
MEcg1_b = cross(mew1,FE1_b);
MEcg2_b = cross(mew2,FE2_b);

MEcg_b = MEcg1_b + MEcg2_b;

%--------------------GRAVITY EFFECTS--------------------------------
%Calculate gravitational forces in the body frame.  This causes no moment
%about CoG.
g_b = [-g*sin(x8);
        g*cos(x8)*sin(x7);
        g*cos(x8)*cos(x7)];
  
Fg_b = m*g_b;

%-------------------STATE DERIVATIVES------------------------------
%Inertia matrix
Ib = m*[40.07 0 -2.0923;
        0 64 0;
        -2.0923 0 99.92];
    
%Inverse of inertia matrix 
invIb = (1/m)*[0.0249836 0 0.000523151;
               0 0.015625 0;
               0.000523151 0 0.010019];

%Form F_b (all the forces in Fb) and calculate udot, vdot, wdot
F_b = Fg_b + FE_b + FA_b;
x1to3dot = (1/m)*F_b - cross(wbe_b,V_b);

%Form Mcg_b (all moments about CoG in Fb) and calculate pdot, qdot, rdot.
Mcg_b = MAcg_b + MEcg_b;
x4to6dot = invIb*(Mcg_b - cross(wbe_b,Ib*wbe_b));

%Calculate phidot,thetadot, and psidot    
H_phi = [1 sin(x7)*tan(x8) cos(x7)*tan(x8);
         0 cos(x7) -sin(x7);
         0 sin(x7)/cos(x8) cos(x7)/cos(x8)];
    
x7to9dot = H_phi*wbe_b;

%Place in first order form
XDOT = [x1to3dot;
        x4to6dot;
        x7to9dot];