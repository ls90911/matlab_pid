function [ sig_ref ] = signal_sin_cos( u )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
t = u;
T = 5;
A = 20;
phi_ref = A/180*pi*sin(2*pi/T*t);
theta_ref = A/180*pi*sin(2*pi/T*t+pi/4);
psi_ref = A/180*pi*sin(2*pi/T*t+pi/2);
if t < 5
    z_ref = 1;
elseif t < 10
    z_ref = 2;    
elseif t < 15
    z_ref = 3; 
else
    z_ref = 4;     
end
sig_ref = [phi_ref;theta_ref;psi_ref;z_ref];
end

