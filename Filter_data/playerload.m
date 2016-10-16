function [pl,pwl,apl,a,t,j] = playerload(fname)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

data=load(fname);
a=data(:,2:4);
amag=sqrt(sum(a.^2,2));
t=data(:,1)/10^9;
sps=round(1/(t(2,1)-t(1,1)));
n=length(t);
j=zeros(n,3);
j(2:end,:)=(a(2:end,:)-a(1:end-1,:))./(1/sps);
pl=sqrt(sum(j.^2,2));
wl=3*sps;

% for i=2:n
%     j(i,:)=(a(i,:)-a(i-1,:))./(1/sps);
%     
%     %pl(i)=sqrt(sum((a(i,:)-a(i-1,:)).^2)/sps);
%     pl(i)=sqrt(sum(j(i,:).^2));
% end
pwl=pl.*amag;
apl=zeros(n-wl,1);
for i=1:n-wl
    apl(i)=sum(pl(i:i+wl-1));
end
pl=pl./(78*9.81);
pwl=pwl./(78*9.81);
apl=apl./(78*9.81);


