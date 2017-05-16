function [j_new, positives] = jerk_fp(t,x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% t= timestemp
% v= acceleration vect
tnew=t/10^3;
sps=round(1/mean(tnew(2:end,1)-tnew(1:end-1,1)));
n=length(t);
j=zeros(n,1);
positives=zeros(n,1);
j(2:end,1)=((x(2:end,1)-x(1:end-1,1))./(1/sps));

positives(2:end,1) = j(2:end,1) <= 0;

j_new=sqrt(j.^2).* positives;