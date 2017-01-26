function [j_all, positives,sps] = jerk_all( t,v )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% t= timestemp
% v= acceleration vector of three dimentions 

a=v(:,2:4);
tnew=t/10^3;
sps=round(1/mean(tnew(2:end,1)-tnew(1:end-1,1)));
n=length(tnew);
j=zeros(n,3);
positives=zeros(n,1);
j(2:end,:)=((a(2:end,:)-a(1:end-1,:))./(1/sps));

positives(2:end,1) = j(2:end,2) <= 0;

j_all=sqrt(sum(j.^2,2));

end

