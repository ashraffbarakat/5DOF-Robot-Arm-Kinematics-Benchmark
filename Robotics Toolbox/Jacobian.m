clc


L1 = 0.0564;
L2 = 0.17;
L3 = 0.15;
L4 = 0.08364;

q1 = deg2rad(60);
q2 = deg2rad(45);
q3 = deg2rad(30);
q4 = deg2rad(0);


A = L2*cos(q2) ...
  + L3*cos(q2+q3) ...
  + L4*cos(q2+q3+q4);

B = L2*sin(q2) ...
  + L3*sin(q2+q3) ...
  + L4*sin(q2+q3+q4);


Jv = [

-sin(q1)*A , ...
-cos(q1)*B , ...
-cos(q1)*(L3*sin(q2+q3)+L4*sin(q2+q3+q4)) , ...
-cos(q1)*L4*sin(q2+q3+q4)

cos(q1)*A , ...
-sin(q1)*B , ...
-sin(q1)*(L3*sin(q2+q3)+L4*sin(q2+q3+q4)) , ...
-sin(q1)*L4*sin(q2+q3+q4)

0 , ...
A , ...
L3*cos(q2+q3)+L4*cos(q2+q3+q4) , ...
L4*cos(q2+q3+q4)

];


Jw = [

0 -sin(q1) -sin(q1) -sin(q1)
0  cos(q1)  cos(q1)  cos(q1)
1      0        0        0

];


J = [
Jv
Jw
];

disp('Full Jacobian')
disp(J)


r = rank(J);
fprintf('Rank(J) = %d\n',r);

sigma = svd(J);

disp('Singular Values')
disp(sigma)


qdot = [
0.5
0.2
-0.1
0.3
];

twist = J*qdot;

v = twist(1:3);
w = twist(4:6);

disp('Linear Velocity')
disp(v)

disp('Angular Velocity')
disp(w)


v_des = [
0.05
0
0
];

qdot_des = pinv(Jv)*v_des;

disp('Required Joint Velocities')
disp(qdot_des)