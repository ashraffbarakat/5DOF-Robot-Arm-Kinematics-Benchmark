function robot_gui_final_PRO()

clc; clear;


robot = importrobot('aseem_22.urdf');
robot.DataFormat = 'row';

config0 = homeConfiguration(robot);
numJoints = length(config0);


f = figure('Position',[200 100 1100 600],'Name','Robot Arm PRO');

ax = axes('Parent',f,'Position',[0.45 0.15 0.5 0.75]);
view(135,25)
grid on
axis equal
title('Robot Preview')


limits_min = [0 0 0 0];
limits_max = [180 180 180 180];


offsets = [0   90   90   90];   % base, shoulder, elbow, wrist
dirs    = [1   -1   -1   -1];   % الاتجاه

theta = zeros(1,numJoints);

for i = 1:numJoints
    
    uicontrol('Style','text',...
        'Position',[40 520-60*i 80 20],...
        'String',['Joint ' num2str(i)]);

    sliders(i) = uicontrol('Style','slider',...
        'Min',limits_min(i),'Max',limits_max(i),'Value',0,...
        'Position',[130 520-60*i 250 20],...
        'Callback',@(src,~) update_plot());
end

%% ================= Home =================
uicontrol('Style','pushbutton',...
    'String','Home',...
    'FontSize',12,...
    'Position',[140 50 120 40],...
    'Callback',@go_home);


update_plot();

    function go_home(~,~)
        for k=1:numJoints
            sliders(k).Value = 0;
        end
        update_plot();
    end


    function update_plot()

        for k=1:numJoints
            theta(k) = sliders(k).Value;
        end

        theta_final = zeros(1,numJoints);
        for i = 1:numJoints
            theta_final(i) = offsets(i) + dirs(i)*theta(i);
        end

        config = deg2rad(theta_final);

        cla(ax)

        show(robot, config, ...
            'Parent', ax, ...
            'PreservePlot', false, ...
            'Frames','off');

        axis(ax,'manual')

        xlim(ax, [-reach reach])
        ylim(ax, [-reach reach])
        zlim(ax, [0 reach])

        view(ax,135,25)

        drawnow
    end

end