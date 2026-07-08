clc; clear; close all;

startup_rvc;


L1 = 0.02;
L2 = 0.17;
L3 = 0.15;
L4 = 0.0364;


L(1) = Link([0 L1 0 pi/2]);   
L(2) = Link([0 0 L2 0]);      
L(3) = Link([0 0 L3 0]);      
L(4) = Link([0 0 L4 0]);      

robot = SerialLink(L, 'name', 'MyArm');


pick  = [0.15 0 0.25];
place = [0.1 0.2 0];


T_pick  = transl(pick);
T_place = transl(place);

q_home  = [0 0 0 0];
q_pick  = robot.ikcon(T_pick);
q_place = robot.ikcon(T_place);


steps = 60;
dt = 0.04;   

q_traj1 = jtraj(q_home, q_pick, steps);
q_traj2 = jtraj(q_pick, q_place, steps);

q_total = [q_traj1; q_traj2];


figure;
robot.plot(q_total(1,:), 'workspace', [-0.6 0.6 -0.6 0.6 0 0.6]);
hold on; grid on;

plot3(pick(1), pick(2), pick(3), 'go','MarkerSize',10,'LineWidth',2);
plot3(place(1), place(2), place(3), 'ro','MarkerSize',10,'LineWidth',2);

title('Pick & Place Simulation');
view(135,25);


box_size = 0.04;

cube = [ ...
    0 0 0;
    1 0 0;
    1 1 0;
    0 1 0;
    0 0 1;
    1 0 1;
    1 1 1;
    0 1 1];

cube = cube * box_size;

faces = [ ...
    1 2 3 4;
    5 6 7 8;
    1 2 6 5;
    2 3 7 6;
    3 4 8 7;
    4 1 5 8];

cube_pos = cube + repmat(pick, size(cube,1), 1);

h_box = patch('Vertices', cube_pos, 'Faces', faces,...
    'FaceColor','blue','FaceAlpha',0.8);

h_grip = plot3(0,0,0,'k','LineWidth',3);

ee_path = [];
h_path = plot3(0,0,0,'r','LineWidth',2);

info_box = annotation('textbox',[0.75 0.55 0.23 0.4],...
    'String','','FitBoxToText','on','BackgroundColor','white');

attached = false;
prev_q = q_total(1,:);

for i = 1:size(q_total,1)
    
    q = q_total(i,:);
    robot.animate(q);
    
    T = robot.fkine(q);
    pos = transl(T);
    
    % PATH
    ee_path = [ee_path; pos];
    set(h_path,'XData',ee_path(:,1),...
               'YData',ee_path(:,2),...
               'ZData',ee_path(:,3));
    
    grip_len = 0.05;
    set(h_grip,'XData',[pos(1) pos(1)],...
               'YData',[pos(2) pos(2)],...
               'ZData',[pos(3) pos(3)+grip_len]);
    
    if i > steps
        attached = true;
    end
    
    if attached
        new_cube = cube + repmat(pos, size(cube,1), 1);
        set(h_box,'Vertices',new_cube);
    end
    
    angles_deg = rad2deg(q);
    
    vel = (q - prev_q) / dt;
    vel_deg = rad2deg(vel);
    
    txt = sprintf(['Joint Data:\n\n' ...
        'J1: %.1f° | %.1f°/s\n' ...
        'J2: %.1f° | %.1f°/s\n' ...
        'J3: %.1f° | %.1f°/s\n' ...
        'J4: %.1f° | %.1f°/s'], ...
        angles_deg(1), vel_deg(1), ...
        angles_deg(2), vel_deg(2), ...
        angles_deg(3), vel_deg(3), ...
        angles_deg(4), vel_deg(4));
    
    info_box.String = txt;
    
    prev_q = q;
    
    drawnow;
    pause(dt);
end

disp('Done');