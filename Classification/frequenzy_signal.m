% Finding out the frequency of a signal
% 1. Power density spectrum PDS with 'pwelch' function. This will show us to
% cut of which frequncies for the filter
% 2. Filter with cut-off frequencies that 
% 3. Find out frequency: With 'findpeak' function find periodicity and then
% 1/period=frequency 
load jerk_jerk_pos
partic= cellstr(['P1 ';'P2 ';'P3 ';'P4 ';'P5 ';'P6 ';'P7 ';'P8 ';'P9 ';'P10';'P11';'P12']);
device  = cellstr(['SP1';'SW1';'GPS']);
speed = cellstr(['5km/h ';'8km/h ';'12km/h';'slow  ';'fast  ']);
con= cellstr(['asphalt    ';'grass      ';'soil       ';'inlcineup  ';'inclinedown';'stairsup   ';'stairsdown ']);
weight= [67.1; 79.4; 63.2; 77.1; 63.5; 72.7; 65.5; 84.8; 70.5; 77.5; 70.6; 62.7]; %Weights of each participants 
%% 1. PDS with 'pwelch' function
% Looking at some PDS to desicde the cutoff frequency
% x= jerk_jerk_pos.outdoor{1}{1}{1}{1}(:,2);
% x= x- mean(x);
% t=jerk_jerk_pos.outdoor{1}{1}{1}{1}(:,1);
% figure; hold on;
% plot(t,x);
% 
% m=360; %in sec
% 
% [P,f]=pwelch(x,hanning(m),m/2,m,fs);
% figure; hold on;
% semilogy(f,P);

%% 2. Filter the data with lowpass filter cutoff filter 15Hz
for m= 1:length(partic) %Participants
    if isempty(jerk_jerk_pos.outdoor{m}) ~= 1
        for n=1:2%length(device) % Excluding GPS
            if isempty(jerk_jerk_pos.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty(jerk_jerk_pos.outdoor{m}{n}{o}) ~= 1
%                         for p=1:5 % Condition: everything, without stairs
%                             if isempty(jerk_jerk_pos.outdoor{m}{n}{o}{p}) ~= 1
%                                 x=jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,2);
%                                 fs=jerk_jerk_pos.outdoor{m}{n}{o}{p}(1,4);
%                                 Wn=10; %cutoff frequncy based on PDS in section 1.
%                                 nfilt= 5;% Filter order
%                                 [b,a]= butter(5,Wn/(fs/2),'low');
%                                 x_low= filtfilt(b,a,x);
%                                 t=([0:length(x)-1]/fs)';
% %                                 [pks1,locs] = findpeaks(x_low,'MinPeakDistance',60);
%                                 %                                 cycles = diff(locs);
%                                 %                                 meanCycle = mean(cycles);
%                                 Nf=100; % Hz Nyquist frequency:the minimum rate at which a signal can be sampled without introducing errors, which is twice the highest frequency present in the signal
%                                 df = fs/Nf;
%                                 f = 0:df:fs/2-df;
%                                 tracc = fftshift(fft(x_low-mean(x_low),Nf));
%                                 dBacc = 20*log10(abs(tracc(Nf/2+1:Nf)));
%                                 [pks2,MaxFreq] = findpeaks(dBacc,'NPeaks',1,'SortStr','descend');
%                                 FFT.outdoor{m}{n}{o}{p}=f(MaxFreq);
%                             end
%                         end
                        for p=6:7 % Condition: stairs
                            if isempty(jerk_jerk_pos.outdoor{m}{n}{o}{p}) ~= 1
                                x=jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,2);
                                fs=jerk_jerk_pos.outdoor{m}{n}{o}{p}(1,4);
                                Wn=10; %cutoff frequncy based on PDS in section 1.
                                nfilt= 5;% Filter order
                                [b,a]= butter(5,Wn/(fs/2),'low');
                                x_low= filtfilt(b,a,x);
                                t=([0:length(x)-1]/fs)';
                                [pks1,locs] = findpeaks(x_low,'MinPeakDistance',60);
                                %                                 cycles = diff(locs);
                                %                                 meanCycle = mean(cycles);
                                Nf=100; % Hz Nyquist frequency:the minimum rate at which a signal can be sampled without introducing errors, which is twice the highest frequency present in the signal
                                df = fs/Nf;
                                f = 0:df:fs/2-df;
                                tracc = fftshift(fft(x_low-mean(x_low),Nf));
                                dBacc = 20*log10(abs(tracc(Nf/2+1:Nf)));
                                [pks2,MaxFreq] = findpeaks(dBacc,'NPeaks',1,'SortStr','descend');
                                FFT.outdoor{m}{n}{o}{p}=f(MaxFreq);
                            end
                        end
                    end
                end
            end
        end
    end
end
%% Plot of one example
% yaxis = [20 100];
% plot(f,dBacc,1./[meanCycle meanCycle],yaxis)
% xlabel('Frequency (year^{-1})')
% ylabel('| FFT | (dB)')
% axis([0 10 yaxis])
% text(1/meanCycle + .02,25,['<== 1/' num2str(meanCycle)])
% Period = 1/f(MaxFreq)
% hold on
% plot(f(MaxFreq),pks2,'or')
% hold off
% legend('Fourier transform','1/meanCycle','1/Period')

%%