 %% Preparing acceleration data for classification
 % 1. PSD estimate for cut-off frequency
 % 2. Filter data with high-pass filter
 % 3. Feature extraction of 'Load rate'
 %      3.1 Time-domain 
 %      3.2 Frequency-domain
 % 4. Feature extraction of acc
 %      4.1 Time-domain 
 %      4.2 Frequency-domain
 % 5. Feature matrix
load raw_int
partic= cellstr(['P1 ';'P2 ';'P3 ';'P4 ';'P5 ';'P6 ';'P7 ';'P8 ';'P9 ';'P10';'P11';'P12']);
device  = cellstr(['SP1';'SW1';'GPS']);
speed = cellstr(['5km/h ';'8km/h ';'12km/h';'slow  ';'fast  ']);
con= cellstr(['asphalt    ';'grass      ';'soil       ';'inlcineup  ';'inclinedown';'stairsup   ';'stairsdown ']);
weight= [67.1; 79.4; 63.2; 77.1; 63.5; 72.7; 65.5; 84.8; 70.5; 77.5; 70.6; 62.7]; %Weights of each participants
 %% 1. PSD estimate for cut-off frequency (Welch's PSD estimate)
%  for i=6:7
% x= raw_int.outdoor{2}{1}{4}{i}(:,2);
% t= raw_int.outdoor{2}{1}{4}{i}(:,1);
% fs= 99;
%  m=360; %in sec
% [P,f]=pwelch(x,hanning(m),m/2,m,fs);
% figure; hold on;
% semilogy(f,P);
%  end 

% decided cut-off filter 0.5 Hz and 10Hz
%% 2. Filter data with high-pass filter
% Allocat classification_data.acc_pos
raw_filt.outdoor= cell(1,length(partic));
for m= 1:length(partic)
    raw_filt.outdoor{m}= cell(1,length(device));
    for n=1:length(device)
        raw_filt.outdoor{m}{n}= cell(1,length(speed));
        for o=1:length(speed)
            raw_filt.outdoor{m}{n}{o}= cell(1,length(con));
            for p=1:length(con)
                raw_filt.outdoor{m}{n}{o}{p}= [];
            end
        end
    end
end
% Bandpass filter 
for m= 1:length(partic) %Participants
    if isempty(raw_int.outdoor{m}) ~= 1
        for n=1%:2%length(device) % Excluding GPS
            if isempty(raw_int.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p=1:5%length(con)   % Conditions
                            if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                            [ raw_filt.outdoor{m}{n}{o}{p}(:,:)] = bandpass(raw_int.outdoor{m}{n}{o}{p}(:,:));
                            end 
                        end
                    end
                    for p=6:7 %length(con)   % Conditions
                        if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                            [ raw_filt.outdoor{m}{n}{o}{p}(:,:)] = bandpass(raw_int.outdoor{m}{n}{o}{p}(:,:));
                        end
                    end
                end
            end
        end
    end
end
