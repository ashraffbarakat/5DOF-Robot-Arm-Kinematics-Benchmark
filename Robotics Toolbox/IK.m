clc
close all

Arm_C.DataFormat = 'column';

ik = inverseKinematics('RigidBodyTree',Arm_C);

x = -0.149097;
y = -0.258435;
z = 0.234023;

Tgoal = trvec2tform([x y z]);

weights = [0 0 0 1 1 1];

q0 = zeros(4,1);

[qSol,solInfo] = ik('Body5',Tgoal,weights,q0);

disp('Joint Angles (deg)')
disp(rad2deg(qSol))

Tcheck = getTransform(Arm_C,qSol,'Body5');

disp('Desired Position:')
disp([x;y;z])

disp('Achieved Position:')
disp(Tcheck(1:3,4))

fprintf('Position Error = %.6f m\n', ...
        norm([x;y;z]-Tcheck(1:3,4)));

figure
show(Arm_C,qSol,'Frames','on');
axis equal
grid on