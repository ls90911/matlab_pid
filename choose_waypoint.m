function [ position_in_local_coordinate ] = choose_waypoint( position_obstacle,...
    position_local_coordinate,angle_local_coordinate)
% this function is used to calculate position between drone and the next
% obstacle
% position_drone is current position in earth coordinate
% position_obstacle is position of next obstacle in earth coordinate
% position_local_coordinate & angle_local_coordinate are position between 
% local coordinate and earth coordinate

C = [cos(angle_local_coordinate) sin(angle_local_coordinate) 0; ...
    -sin(angle_local_coordinate) cos(angle_local_coordinate) 0; ...
    0 0 1];

temp_coor = position_obstacle-position_local_coordinate;
%position_in_local_coordinate = C*position_obstacle-position_local_coordinate;
position_in_local_coordinate = C * temp_coor;
end

