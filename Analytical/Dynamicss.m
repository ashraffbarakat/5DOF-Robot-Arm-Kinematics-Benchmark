clc
clear
close all


L1 = 0.0564;
L2 = 0.17;
L3 = 0.15;
L4 = 0.08364;


m1 = 0.1;
m2 = 0.1;
m3 = 0.1;
m4 = 0.1;

g = 9.81;


q1 = deg2rad(60);
q2 = deg2rad(45);
q3 = deg2rad(30);
q4 = deg2rad(0);


qd = zeros(4,1);

qdd = zeros(4,1);


r1 = L1/2;
r2 = L2/2;
r3 = L3/2;
r4 = L4/2;


I1 = m1*L1^2/12;
I2 = m2*L2^2/12;
I3 = m3*L3^2/12;
I4 = m4*L4^2/12;


Jv1 = zeros(3,4);

Jw1 = [
0 0 0 0
0 0 0 0
1 0 0 0
];


A2 = r2*cos(q2);
B2 = r2*sin(q2);

Jv2 = [

-sin(q1)*A2    -cos(q1)*B2      0      0
 cos(q1)*A2    -sin(q1)*B2      0      0
      0             A2          0      0

];

Jw2 = [

0   -sin(q1)   0   0
0    cos(q1)   0   0
1        0      0   0

];


A3 = L2*cos(q2) ...
   + r3*cos(q2+q3);

B3 = L2*sin(q2) ...
   + r3*sin(q2+q3);

C3 = r3*sin(q2+q3);
D3 = r3*cos(q2+q3);

Jv3 = [

-sin(q1)*A3   -cos(q1)*B3   -cos(q1)*C3      0
 cos(q1)*A3   -sin(q1)*B3   -sin(q1)*C3      0
      0             A3             D3        0

];

Jw3 = [

0   -sin(q1)   -sin(q1)   0
0    cos(q1)    cos(q1)   0
1        0           0     0

];



A4 = L2*cos(q2) ...
   + L3*cos(q2+q3) ...
   + r4*cos(q2+q3+q4);

B4 = L2*sin(q2) ...
   + L3*sin(q2+q3) ...
   + r4*sin(q2+q3+q4);

C4 = L3*sin(q2+q3) ...
   + r4*sin(q2+q3+q4);

D4 = L3*cos(q2+q3) ...
   + r4*cos(q2+q3+q4);

E4 = r4*sin(q2+q3+q4);
F4 = r4*cos(q2+q3+q4);

Jv4 = [

-sin(q1)*A4   -cos(q1)*B4   -cos(q1)*C4   -cos(q1)*E4
 cos(q1)*A4   -sin(q1)*B4   -sin(q1)*C4   -sin(q1)*E4
      0             A4             D4             F4

];

Jw4 = [

0   -sin(q1)   -sin(q1)   -sin(q1)
0    cos(q1)    cos(q1)    cos(q1)
1        0           0           0

];



M1 = m1*(Jv1'*Jv1) + I1*(Jw1'*Jw1);
M2 = m2*(Jv2'*Jv2) + I2*(Jw2'*Jw2);
M3 = m3*(Jv3'*Jv3) + I3*(Jw3'*Jw3);
M4 = m4*(Jv4'*Jv4) + I4*(Jw4'*Jw4);

M = M1 + M2 + M3 + M4;

disp('Inertia Matrix M(q)')
disp(M)



G = [

0;

g*( ...
m2*r2*cos(q2) ...
+ m3*(L2*cos(q2)+r3*cos(q2+q3)) ...
+ m4*(L2*cos(q2)+L3*cos(q2+q3)+r4*cos(q2+q3+q4)));

g*( ...
m3*r3*cos(q2+q3) ...
+ m4*(L3*cos(q2+q3)+r4*cos(q2+q3+q4)));

g*( ...
m4*r4*cos(q2+q3+q4));

];

disp('Gravity Vector G(q)')
disp(G)


C = zeros(4);

disp('Coriolis Matrix C(q,qdot)')
disp(C)



tau = M*qdd + C*qd + G;

disp('Joint Torque Vector')
disp(tau)