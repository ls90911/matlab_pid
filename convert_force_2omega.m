function [ omega_desired ] = convert_force_2omega( u )
% This function is used to convert desired force and torque to actual omega
% 
global matrix_force_2_omega

test = u(1);

omega_desired_square = matrix_force_2_omega * u;

omega_desired = sqrt(omega_desired_square);
end

