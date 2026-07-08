clc


L1 = 0.0564;
L2 = 0.17;
L3 = 0.15;
L4 = 0.08364;

q1 = 60;
q2 = 45;
q3 = 30;
q4 = 0;


q1 = deg2rad(q1);
q2 = deg2rad(q2);
q3 = deg2rad(q3);
q4 = deg2rad(q4);


A = L2*cos(q2) ...
  + L3*cos(q2+q3) ...
  + L4*cos(q2+q3+q4)-0.03;

B = L2*sin(q2) ...
  + L3*sin(q2+q3) ...
  + L4*sin(q2+q3+q4)+0.02;

C = L3*sin(q2+q3) ...
  + L4*sin(q2+q3+q4)+0.025;

D = L3*cos(q2+q3) ...
  + L4*cos(q2+q3+q4)-0.01;


Jv = [

-sin(q1)*A , ...
-cos(q1)*B , ...
-cos(q1)*C , ...
-cos(q1)*L4*sin(q2+q3+q4)

 cos(q1)*A , ...
-sin(q1)*B , ...
-sin(q1)*C , ...
-sin(q1)*L4*sin(q2+q3+q4)

0 , ...
A , ...
D , ...
L4*cos(q2+q3+q4)

];


Jw = [

0  -sin(q1)  -sin(q1)  -sin(q1)
0   cos(q1)   cos(q1)   cos(q1)
1      0          0          0

];

J = [
Jv
Jw
];

disp('Geometric Jacobian (6x4):')
disp(J)