function [j] = jerk(t,x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% data=load(fname);
% a=data(:,2:4);

% tnew=t/10^3;
sps=round(1/mean(t(2:end,1)-t(1:end-1,1)));
n=length(t);
j=zeros(n,1);
j(2:end)=(x(2:end)-x(1:end-1))./(1/sps);

% mean(j(find(j>0)))
% 
% amag=sqrt(x.^2);
% 
% tnew=t/10^9;
% sps=round(1/(tnew(2,1)-tnew(1,1)));
% n=length(tnew);
% j=zeros(n,1);
% j(2:end)=(x(2:end)-x(1:end-1))./(1/sps);
% pl=sqrt(j.^2);
% jk=pl./(77*9.81);
% wl=3*sps;

% for i=2:n
%     j(i,:)=(a(i,:)-a(i-1,:))./(1/sps);
%     
%     %pl(i)=sqrt(sum((a(i,:)-a(i-1,:)).^2)/sps);
%     pl(i)=sqrt(sum(j(i,:).^2));
% end
%pwl=pl.*amag;
%apl=zeros(n-wl,1);
% for i=1:n-wl
%     apl(i)=sum(pl(i:i+wl-1));
% end


%pwl=pwl./(78*9.81);
%apl=apl./(78*9.81);