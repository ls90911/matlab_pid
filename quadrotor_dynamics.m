function [ dx ] = quadrotor_dynamics( x_u )
% This function is dynamics of quadrotor
% The model is from minimun snap trajectory generation and control for
% quadrotors. The data is from quadrotor kinematics dynamics
global k_F k_M L m g I



x = x_u(1);
y = x_u(2);
z = x_u(3);
v_x = x_u(4);
v_y = x_u(5);
v_z = x_u(6);
phi = x_u(7);
theta = x_u(8);
psi = x_u(9);
p = x_u(10);
q = x_u(11);
r = x_u(12);
omega1 = x_u(13);
omega2 = x_u(14);
omega3 = x_u(15);
omega4 = x_u(16);

u1 = (omega1^2+omega2^2+omega3^2+omega4^2)*k_F;
u2 = (omega2^2-omega4^2)*k_F*L;
u3 = (-omega1^2+omega3^2)*k_F*L;
u4 = (k_M*omega1^2-k_M*omega2^2+k_M*omega3^2-k_M*omega4^2);

% rotation matrix
R_b_2_a = [cos(psi)*cos(theta)-sin(phi)*sin(psi)*sin(theta) -cos(phi)*sin(psi) ...
    cos(phi)*sin(theta)+cos(theta)*sin(phi)*sin(psi);...
    cos(theta)*sin(psi)+cos(psi)*sin(phi)*sin(theta) cos(phi)*cos(psi) ...
    sin(psi)*sin(theta)-cos(psi)*cos(theta)*sin(phi);...
    -cos(phi)*sin(theta) sin(phi) cos(phi)*cos(theta)];
R_d_angle = inv([cos(theta) 0 -cos(phi)*sin(theta); 0 1 sin(phi);...
    sin(theta) 0 cos(phi)*cos(theta)]);

dx = [v_x v_y v_z]';
dv = [0 0 -g]'+ R_b_2_a*[0 0 u1]'/m;
d_angle = R_d_angle * [p q r]';
dq = inv(I)*(cross(-[p q r]',I*[p q r]')+[u2 u3 u4]');

dx = [dx;dv;d_angle;dq];
end

