function [a_all, fs] = acc_all( v )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% t= timestemp
% v= acceleration vector of three dimentions 

a=v(:,2:4);
tnew=v(:,1)/10^3;
fs=round(1/mean(tnew(2:end,1)-tnew(1:end-1,1)));
n=length(tnew);
positives=zeros(n,1);

positives(2:end,1) = a(2:end,2) <= 0;

a_all=sqrt(sum(a.^2,2));

end