function [ x_filt ] = bandpass( v, extra,cutoff, weight, m,o,p,distance)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
data=v(5:end-4,2:4);
tnew=v(5:end-4,1)/10^3;
t=tnew(2:end,1)-tnew(1:end-1,1);
fs=round(1/mean(t(2:end-1,1)));    % sampling frequency
fc1=15;   % Hz
[b,a]= butter(5,fc1/(fs/2),'low'); % low-pass filter 
 n=length(tnew)-1;
x_low=zeros(n,3);
x_low(:,:)= filtfilt(b,a,data(1:end-1,:));
% x_low= data;
fc2=0.5; %Hz
[d,c]= butter(5,fc2/(fs/2),'high');% high-pass filter
x_filt=zeros(n,4);
% x_filt(:,2:4)= filtfilt(d,c,x_low(1:end-1,:));
x_filt(:,2:4)= filtfilt(d,c,x_low(:,:));
x_filt(:,1)=tnew(1:end-1,:);
end

% Bandpass filter 
% x=detrend(x);
% [b,a]= butter(5,25/(fs/2),'low');
% z_low= filtfilt(b,a,x);
% 
% 
% [d,c]= butter(5,4/(fs/2),'high');
% z_high= filtfilt(d,c,z_low);
% plot(t,z_high);