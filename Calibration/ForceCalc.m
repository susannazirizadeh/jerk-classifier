function [ fp ] = ForceCalc( v )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n=length(v(:,1));
M=zeros(n,1);
M(:,1)= mean(v(:,1:4),2);
grav=9.80665002864; % Obtaining neuton 
fp=zeros(n,1);
fp(:,1)=grav*(M(:,1)+1.5334)./(-0.0074);

end

