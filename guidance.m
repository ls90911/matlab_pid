function [ ref ] = guidance(u)
% waypoint [3 3 3] is the point chosen by planner
%   Detailed explanation goes here
global waypoint_relative state T

t = u;
current_position = [0 0 state(3)];
velocity_at_zero = norm([state(5) state(4)]);
%chi = atan2(state(5),state(4));
chi = pi/2;

[center,radius,flag] = solve_center(current_position,waypoint_relative,chi);

alpha = vector_angle([-center(1) center(2)],[waypoint_relative(1)-center(1)...
    waypoint_relative(2)-center(2)]);
c = alpha * radius;
T = c/velocity_at_zero;
if abs(t-T) < 0.1
    stop_flag = 1;
else
    stop_flag = 0;
end
omega = alpha / T;
gamma = atan2(-center(2),-center(1));

if flag == 1
    x_ref = center(1) + radius*cos(gamma-omega*t);
    y_ref = center(2) + radius*sin(gamma-omega*t);
    dx_ref = radius * omega*sin(gamma-omega*t);
    dy_ref = -radius*omega*cos(gamma-omega*t);
    ddx_ref = -radius*omega^2*cos(gamma-omega*t);
    ddy_ref = -radius*omega^2*sin(gamma-omega*t);
elseif flag == 0
    x_ref = center(1) + radius*cos(gamma+omega*t);
    y_ref = center(2) + radius*sin(gamma+omega*t);
    dx_ref = -radius*omega*sin(gamma+omega*t);
    dy_ref = radius*omega*cos(gamma+omega*t);
    ddx_ref = -radius*omega^2*cos(gamma+omega*t);
    ddy_ref = -radius*omega^2*sin(gamma+omega*t);
else
    x_ref = 0;
    y_ref = 0;
    dx_ref = 0;
    dy_ref = 0;
    ddx_ref = 0;
    ddy_ref = 0;
end

ref = [x_ref y_ref dx_ref dy_ref ddx_ref ddy_ref stop_flag T]';
end



function [alpha] = vector_angle(vector1,vector2)
% this function is used to calculate the angle between two vectors

alpha = acos((vector1*vector2')/(norm(vector1)*norm(vector2)));

end

%------------------------------------------------------------------------
% This functon is used for sloving the position of circle's center
% point1[1 1] and point2[3 3] are the position of two points
% psi[150/180*pi] is the yaw angle at point1
% r is the radius of the circle
% center[3 1] is the center of the circle
% flag == 1 means clockwise rotation flag == 0 means anticlockwise
% flag == 2 means the straight line 
%------------------------------------------------------------------------
function [ center,radius,flag ] = solve_center(point1,point2,psi)
x0 = point1(1);
y0 = point1(2);
x_f = point2(1);
y_f = point2(2);

if psi == atan2(y_f-y0,x_f-x0)
    center = [0 0];
    radius = 0;                   
    flag =2;
    return;
end

d = norm([x_f-x0 y_f-y0]);

mu = atan2((y_f-y0),(x_f-x0));

theta_ = acos([cos(psi) sin(psi)]*[x_f-x0 y_f-y0]'/...
    (norm([cos(psi) sin(psi)])*norm([x_f-x0 y_f-y0])));

R = d/(2*sin(abs(theta_)));
x_m = (x0+x_f)/2;
y_m = (y0+y_f)/2;
h = R * cos(abs(theta_));
x_o_temp_1 = h*cos(mu-pi/2);
y_o_temp_1 = h*(sin(mu-pi/2));

x_o_temp_2 = h*cos(mu+pi/2);
y_o_temp_2 = h*sin(mu+pi/2);

x_o_1 = x_m+x_o_temp_1;
y_o_1 = y_m+y_o_temp_1;

x_o_2 = x_m+x_o_temp_2;
y_o_2 = y_m+y_o_temp_2;

if abs([cos(psi) sin(psi)]*[x_o_1-x0 y_o_1-y0]') <0.01
    x_o = x_o_1;
    y_o = y_o_1;
else
    x_o = x_o_2;
    y_o = y_o_2;
end



eta = atan2(y0-y_o,x0-x_o);
x_temp_1 = x_o+R*cos(eta-0.05);
y_temp_1 = y_o+R*sin(eta-0.05);
x_temp_2 = x_o+R*cos(eta+0.05);
y_temp_2 = y_o+R*sin(eta+0.05);

derta_psi1 = acos([x_temp_1-x0 y_temp_1-y0]*[cos(psi) sin(psi)]'/...
    (norm([x_temp_1-x0 y_temp_1-y0])*norm([cos(psi) sin(psi)])));
derta_psi2 = acos([x_temp_2-x0 y_temp_2-y0]*[cos(psi) sin(psi)]'/...
    (norm([x_temp_2-x0 y_temp_2-y0])*norm([cos(psi) sin(psi)])));

if abs(derta_psi1)< abs(derta_psi2)
    flag = 1;
else
    flag = 0;
end
center = [x_o y_o];
radius = R;
end