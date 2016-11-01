function [j] = jerk(t,x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% data=load(fname);
% a=data(:,2:4);

% tnew=t/10^3;
sps=round(1/mean(t(2:end,1)-t(1:end-1,1)));
n=length(t);
j=zeros(n,1);
j(2:end,1)=(x(2:end,1)-x(1:end-1,1))./(1/sps);
 