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


phi = q2 + q3 + q4;

r = (L2*cos(q2) ...
  + L3*cos(q2 + q3) ...
  + L4*cos(phi));

z = (L1 ...
  + L2*sin(q2) ...
  + L3*sin(q2 + q3) ...
  + L4*sin(phi));

x = r*cos(q1);
y =  r*sin(q1);

%% End Effector Position
P = [x; y; z];

disp('End Effector Position (cm)')
disp(P)