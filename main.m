clear
clc

global k_F k_M L m g I_xx I_yy I_zz I matrix_force_2_omega

k_F = 6.11*10^-8;
k_M = 1.5*10^-9;
L = 0.175;
I_xx = 2.32*10^-3;
I_yy = 2.32*10^-3;
I_zz = 4.00*10^-3;
m = 0.5;
g = 9.8;
I = [I_xx 0 0; 0 I_yy 0; 0 0 I_zz];
k_velocity_feedback = 3.2;

state_initial = [0 0 0 0 0 0 0 0 0 0 0 0];

%------------------------------------------------------
%       PID parameter

          con_P = 30;
          con_I = 0;
          con_D = 0;
%------------------------------------------------------


matrix_omega_2_force = [k_F k_F k_F k_F; 0 k_F*L 0 -k_F*L;...
    -k_F*L 0 k_F*L 0; k_M -k_M k_M -k_M];
matrix_force_2_omega = inv(matrix_omega_2_force);


sim('pid_simulation');


temp = 0;
