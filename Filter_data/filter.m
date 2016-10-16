%% Steps for filtering
%   1. Welch PSD estimate to obtain the frequencies for filter
%   2. Interprete PSD
%   3. Use either lowpass filter or bandpass filter
%% Welch's PSD estimate
m=360; %in sec

[P,f]=pwelch(x,hanning(m),m/2,m,fs);
figure; hold on;
semilogy(f,P);
% print -depsc ./PSD_3600.eps