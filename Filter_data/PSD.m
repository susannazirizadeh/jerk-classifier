%% Steps for filtering
%   1. Welch PSD estimate to obtain the frequencies for filter
%   2. Interprete PSD
%   3. Use either lowpass filter or bandpass filter
%% Welch's PSD estimate
x= raw_data.treadmill{1}{1}{1}{6}(:,2);
x= x- mean(x);
t= raw_data.treadmill{1}{1}{1}{6}(:,1);

for m=150:20:400; %in sec

fs= 200;

[P,f]=pwelch(x,hanning(m),m/2,m,fs);
title('Power spektrum density')
xlabel('Frequency [Hz]')
ylabel('Power [dB]')
figure; hold on;
semilogy(f,P);
% print -depsc ./PSD_3600.eps
end 