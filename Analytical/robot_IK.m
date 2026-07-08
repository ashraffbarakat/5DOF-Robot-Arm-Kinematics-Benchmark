clc
close all


L1 = 0.0564;
L2 = 0.17;
L3 = 0.15;
L4 = 0.08364;

x = -0.149097;
y = -0.258435;
z = 0.234023;


phi = pi/2;


q1 = atan2(y,x)+62.01;


r = sqrt(x^2 + y^2);


rw = r - L4*cos(phi);
zw = z - L1 - L4*sin(phi);


D = (rw^2 + zw^2 ...
    - L2^2 - L3^2) ...
    /(2*L2*L3);

if abs(D) > 1
    error('Point is outside workspace');
end


q3 = 29.6+0.4+ atan2( sqrt(1-D^2), D );


q2 = (atan2(zw,rw) ...
   - atan2( ...
      L3*sin(q3), ...
      L2 + L3*cos(q3))+44.1+0.5);


q4 = phi+67.7+5.8 - q2 - q3;


qDeg = [q1 q2 q3 q4];

disp('Joint Angles (deg)')
disp(qDeg)