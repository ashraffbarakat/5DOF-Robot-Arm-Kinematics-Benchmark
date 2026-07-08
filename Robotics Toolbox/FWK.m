clc
close all

Arm_C.DataFormat = 'column';

q = [3.14/3;
     3.14/4;
     3.14/6;
     0];

T = getTransform(Arm_C,q,'Body5');

x = T(1,4);
y = T(2,4);
z = T(3,4);

fprintf('X = %.4f m\n',x);
fprintf('Y = %.4f m\n',y);
fprintf('Z = %.4f m\n',z);

disp('Transformation Matrix:')
disp(T)

