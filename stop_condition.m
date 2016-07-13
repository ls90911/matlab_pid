function [ y ] = stop_condition( u )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%#codegen
global waypoint
d = norm([u(1)-waypoint(1) u(2)-waypoint(2)]);

if d < 0.3 
    y = 1;
else
    y = 0;
end
end

