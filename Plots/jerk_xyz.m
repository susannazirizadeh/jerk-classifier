function [j_xyz] = jerk_xyz( t,v,X,Y,Z )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


grav=X^2+Y^2+Z^2;
g= [(100*X.^2/grav); (100*Y.^2/grav) ; (100*Z.^2/grav)];
a=v(1000:end-1000,2:4);

tnew=t/10^3;
sps=round(1/mean(tnew(2:end,1)-tnew(1:end-1,1)));
n=length(tnew);
j=zeros(n,3);
j(2:end,:)=((a(2:end,:)-a(1:end-1,:))./(1/sps));
j_xyz=sqrt(sum(j.^2*g,2));
end

