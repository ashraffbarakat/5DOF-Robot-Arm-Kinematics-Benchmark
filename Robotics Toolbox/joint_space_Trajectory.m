clc
close all

Arm_C.DataFormat = 'column';


waypoints = [0.15	0.2	0.16	0.2;
             0.1	0.16	0.15	0.12;
             0.12	0.25	0.08	0.1];

timePoints = [0 0.5 1 1.5];
t = linspace(0,1.5,300);

[pos,vel,acc] = cubicpolytraj( ...
                    waypoints,...
                    timePoints,...
                    t,...
                    'VelocityBoundaryCondition',...
                    zeros(3,4));


ik = inverseKinematics('RigidBodyTree',Arm_C);

weights = [0 0 0 1 1 1];
q0 = zeros(4,1);
qTraj = zeros(4,length(t));

for i = 1:length(t)

    Tgoal = trvec2tform(pos(:,i)');

    [qSol,~] = ik('Body5',Tgoal,weights,q0);

    qTraj(:,i) = qSol;
    q0 = qSol;

end


figure
plot(t,rad2deg(qTraj)')
grid on
xlabel('Time (s)')
ylabel('Joint Angle (deg)')
title('Joint-Space Trajectory')
legend('J1','J2','J3','J4')