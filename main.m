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

state_initial = [0 0 1 0 0 0 0 0 0 0 0 0];

%------------------------------------------------------
%       PID parameter

          con_P_phi = 0.06;
          con_I_phi = 0;
          con_D_phi = 0.02;
          
          con_P_theta = 0.055;
          con_I_theta = 0;
          con_D_theta = 0.025;
          
          con_P_psi = 0.02;
          con_I_psi = 0;
          con_D_psi = 0.02;
          
          con_P_z = 5;
          con_I_z = 0.5;
          con_D_z = 4;
%------------------------------------------------------


matrix_omega_2_force = [k_F k_F k_F k_F; 0 k_F*L 0 -k_F*L;...
    -k_F*L 0 k_F*L 0; k_M -k_M k_M -k_M];
matrix_force_2_omega = inv(matrix_omega_2_force);


sim('pid_simulation');


temp = 0;
