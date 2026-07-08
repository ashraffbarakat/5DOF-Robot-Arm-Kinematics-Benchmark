clc
close all


Arm_C.DataFormat = 'column';

% اتجاه الجاذبية (Y-Up)
Arm_C.Gravity = [0 -9.81 0];


q = deg2rad([60;
             45;
             30;
             0]);


qdot = [0.5;
        0.2;
       -0.1;
        0.3];


qddot = [1;
         0;
         0;
         0];



M = massMatrix(Arm_C,q);

disp('=================================')
disp('Inertia Matrix M(q)')
disp(M)



C = velocityProduct(Arm_C,q,qdot);

disp('=================================')
disp('Coriolis and Centrifugal Vector')
disp(C)


G = gravityTorque(Arm_C,q);

disp('=================================')
disp('Gravity Vector G(q)')
disp(G)

tau_eq = M*qddot + C + G;

disp('=================================')
disp('Joint Torques (From Equation)')
disp(tau_eq)


tau_id = inverseDynamics(Arm_C,q,qdot,qddot);

disp('=================================')
disp('Joint Torques (inverseDynamics)')
disp(tau_id)



disp('=================================')
disp('Difference')
disp(tau_eq - tau_id)