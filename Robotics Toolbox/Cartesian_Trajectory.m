clc;



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


figure
plot3(pos(1,:),pos(2,:),pos(3,:),'LineWidth',2)
hold on
scatter3(waypoints(1,:),...
         waypoints(2,:),...
         waypoints(3,:),...
         100,'filled')
grid on
axis equal
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')
title('Cartesian Trajectory')


figure
plot(t,vel')
grid on
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Cartesian Velocity')
legend('Vx','Vy','Vz')

