function [ sig_ref ] = signal_time_step( u )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t = u;
angle = 40;

if t < 5
    phi_ref = angle/180*pi;
    theta_ref = 0;
    psi_ref = -angle/180*pi;
    z_ref = 1;
elseif t < 10
    phi_ref = 0;
    theta_ref = angle/180*pi;
    psi_ref = 0;
    z_ref = 2;    
elseif t < 15
    phi_ref = -angle/180*pi;
    theta_ref = 0;
    psi_ref = angle/180*pi;
    z_ref = 3; 
else
    phi_ref = 0;
    theta_ref = -angle/180*pi;
    psi_ref = 0;
    z_ref = 4;     
end
sig_ref = [phi_ref;theta_ref;psi_ref;z_ref];
end

