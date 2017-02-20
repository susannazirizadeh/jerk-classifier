function [ x_filt ] = bandpass( v )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
data=v(:,2:4);
tnew=v(:,1)/10^3;
t=tnew(2:end,1)-tnew(1:end-1,1);
fs=round(1/mean(t(2:end-1,1)));    % sampling frequency
fc1=10;   % Hz
[b,a]= butter(5,fc1/(fs/2),'low'); % low-pass filter 
n=length(tnew);
x_low=zeros(n,3);
x_low(:,:)= filtfilt(b,a,data(:,:));
fc2=0.5; %Hz
[d,c]= butter(5,fc2/(fs/2),'high');% high-pass filter
x_filt=zeros(n,4);
x_filt(:,2:4)= filtfilt(d,c,x_low(:,:));
x_filt(:,1)=tnew;
end

