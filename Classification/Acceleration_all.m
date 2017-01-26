%% Transforming raw_int.outdoor into classification_data with cutoff before 500 and 500 before end 
% m= participants   (12)
% n= device         (3)
% o= speed          (5)
% p= condition      (7) (asphalt,grass,soil,inlcineup, inclinedown, stairsup, stairs down)
load raw_int

partic= cellstr(['P1 ';'P2 ';'P3 ';'P4 ';'P5 ';'P6 ';'P7 ';'P8 ';'P9 ';'P10';'P11';'P12']);
device  = cellstr(['SP1';'SW1';'GPS']);
speed = cellstr(['5km/h ';'8km/h ';'12km/h';'slow  ';'fast  ']);
con= cellstr(['asphalt    ';'grass      ';'soil       ';'inlcineup  ';'inclinedown';'stairsup   ';'stairsdown ']);
weight= [67.1; 79.4; 63.2; 77.1; 63.5; 72.7; 65.5; 84.8; 70.5; 77.5; 70.6; 62.7]; %Weights of each participants 
%% Transfer into classification_data.jerk_all
% Allocat classification_data.jerk_all
classification_data.jerk_all= cell(1,length(partic));
for m= 1:length(partic)
    classification_data.jerk_all{m}= cell(1,length(device));
    for n=1:length(device)
        classification_data.jerk_all{m}{n}= cell(1,length(speed));
        for o=1:length(speed)
            classification_data.jerk_all{m}{n}{o}= cell(1,length(con));
            for p=1:length(con)
                classification_data.jerk_all{m}{n}{o}{p}= [];
            end
        end
    end
end
%% Transform raw_int.outdoor to classification_data.jerk_all for SP1 and SW1
% For smartphone and smartwatch 
for m= 1:length(partic) %Participants
    if isempty(raw_int.outdoor{m}) ~= 1
        for n=1:2%length(device) % Excluding GPS
            if isempty(raw_int.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p=1:5%length(con)   % Conditions
                            if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                [classification_data.jerk_all{m}{n}{o}{p}(:,2),classification_data.jerk_all{m}{n}{o}{p}(:,3),classification_data.jerk_all{m}{n}{o}{p}(:,4)]=acc_all(raw_int.outdoor{m}{n}{o}{p}(500:end-500,1),raw_int.outdoor{m}{n}{o}{p}(500:end-500,1:4));
                                classification_data.jerk_all{m}{n}{o}{p}(:,1)=raw_int.outdoor{m}{n}{o}{p}(500:end-500,1);
                            end
                        end
%                     end
                % end
                %for o=4:5%1:length(speed)   % Speed % For the stairs
%                     if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p=6:7 %length(con)   % Conditions
                            if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                [classification_data.jerk_all{m}{n}{o}{p}(:,2),classification_data.jerk_all{m}{n}{o}{p}(:,3),classification_data.jerk_all{m}{n}{o}{p}(:,4)]=acc_all(raw_int.outdoor{m}{n}{o}{p}(10:end-10,1),raw_int.outdoor{m}{n}{o}{p}(10:end-10,1:4));
                                classification_data.jerk_all{m}{n}{o}{p}(:,1)=raw_int.outdoor{m}{n}{o}{p}(10:end-10,1);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

 % For GPS data
for m= 1:length(partic) %Participants
    if isempty(classification_data.jerk_all{m}) ~= 1
        for n=3 
            if isempty(raw_int.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p=1:length(con)   % Conditions
                            if isempty(raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                classification_data.jerk_all{m}{n}{o}{p}(:,1:3)=raw_int.outdoor{m}{n}{o}{p}(:,1:3);
                            end
                        end
                    end
                end
            end
        end
    end
end
%% % Allocat FFT.outdoor
FFT.outdoor= cell(1,length(partic));
for m= 1:length(partic)
    FFT.outdoor{m}= cell(1,length(device));
    for n=1:length(device)
        FFT.outdoor{m}{n}= cell(1,length(speed));
        for o=1:length(speed)
            FFT.outdoor{m}{n}{o}= cell(1,length(con));
            for p=1:length(con)
                FFT.outdoor{m}{n}{o}{p}= NaN;
            end
        end
    end
end

%% FFT

for m= 1:length(partic) %Participants
    if isempty(classification_data.jerk_all{m}) ~= 1
        for n=1:2%length(device) % Excluding GPS
            if isempty(classification_data.jerk_all{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty(classification_data.jerk_all{m}{n}{o}) ~= 1
                        for p=1:5 % Condition: everything, without stairs
                            if isempty(classification_data.jerk_all{m}{n}{o}{p}) ~= 1
                                x=classification_data.jerk_all{m}{n}{o}{p}(find(classification_data.jerk_all{m}{n}{o}{p}(:,2)),2);
                                if length(x) > 15
                                fs=classification_data.jerk_all{m}{n}{o}{p}(1,4);
                                Wn=13; %cutoff frequncy based on PDS in section 1.
                                nfilt= 5;% Filter order
                                [b,a]= butter(5,Wn/(fs/2),'low');
                                x_low= filtfilt(b,a,x);
                                t=([0:length(x)-1]/fs)';
                                [pks1,locs] = findpeaks(x_low,t,'MinPeakDistance',t(15));
                                FFT.outdoor{m}{n}{o}{p}=mean(diff(locs)/fs);
                                end 
                            end
                        end
                        for p=6:7 % Condition: stairs
                            if isempty(classification_data.jerk_all{m}{n}{o}{p}) ~= 1
                                x=classification_data.jerk_all{m}{n}{o}{p}(find(classification_data.jerk_all{m}{n}{o}{p}(:,2)),2);
                                if length(x) > 15
                                fs=classification_data.jerk_all{m}{n}{o}{p}(1,4);
                                Wn=13; %cutoff frequncy based on PDS in section 1.
                                nfilt= 5;% Filter order
                                [b,a]= butter(5,Wn/(fs/2),'low');
                                x_low= filtfilt(b,a,x);
                                t=([0:length(x)-1]/fs)';
                                [pks1,locs] = findpeaks(x_low,t,'MinPeakDistance',t(15));
                                FFT.outdoor{m}{n}{o}{p}=mean(diff(locs)/fs);
                                end 
                            end
                        end
                    end
                end
            end
        end
    end
end
%% Develope mean of the data 
% Allocate mjerk_xyz
mloadrate.outdoor= cell(1,length(partic));
for m= 1:length(partic)
    mloadrate.outdoor{m}= cell(1,length(device));
    for n=1:length(device)
        mloadrate.outdoor{m}{n}= cell(1,length(speed));
        for o=1:length(speed)
            mloadrate.outdoor{m}{n}{o}= cell(1,length(con));
            for p=1:length(con)
                mloadrate.outdoor{m}{n}{o}{p}= NaN;
            end
        end
    end
end

%% Calculate mean of jerk_jerk_pos
% For smartwatch and smartphone
for m= 1:length(partic)
    if isempty(classification_data.jerk_all{m}) ~= 1
        for n=1:2 %length(device)
            if isempty(classification_data.jerk_all{m}{n}) ~= 1
                for o=1:length(speed)
                    if isempty(classification_data.jerk_all{m}{n}{o}) ~= 1
                        for p=1:length(con)
                            if isempty(classification_data.jerk_all{m}{n}{o}{p}) ~= 1
                            mloadrate.outdoor{m}{n}{o}{p}= sum(classification_data.jerk_all{m}{n}{o}{p}(:,2))./sum(classification_data.jerk_all{m}{n}{o}{p}(:,3))*weight(m,1);
                            end
                        end
                    end
                end
            end
        end
    end
end



% For GPS
for m= 1:length(partic)
    if isempty(classification_data.jerk_all{m}) ~= 1
        for n=3 %length(device)
            if isempty(classification_data.jerk_all{m}{n}) ~= 1
                for o=1:length(speed)
                    if isempty(classification_data.jerk_all{m}{n}{o}) ~= 1
                        for p=1:length(con)
                            if isempty(classification_data.jerk_all{m}{n}{o}{p}) ~= 1
                            mloadrate.outdoor{m}{n}{o}{p}= (nanmean(classification_data.jerk_all{m}{n}{o}{p}(:,3)))*3.6;
                            end
                        end
                    end
                end
            end
        end
    end
end

%%  Calculating results of outdoor session for classifier    
y=19; % Sum of conditions and speed  
for n=1:2%length(device)
    results.acc_all{n}= cell(1,length(partic));
    for m=1:length(partic)
        results.acc_all{n}{m}= NaN(y,8);
    end
end

% condition; asphalt=1, grass=2, soil=3, inclineup=4, inclinedown= 5,
% stairsup=6, stairsdown=7

i=0; % Participant counter
for n=1:2%length(device)
    for m= 1:length(partic)
        if isempty( mloadrate.outdoor{m} ) ~= 1
            for o=1:length(speed)
                if isempty( mloadrate.outdoor{m}{n}{o} ) ~= 1
                    for  p=1:length(con)
                        if isempty( mloadrate.outdoor{m}{n}{o}{p} ) ~= 1
                            results.acc_all{n}{m}(:,1)= cell2mat([mloadrate.outdoor{m}{1}{1}(1:5)';mloadrate.outdoor{m}{1}{2}(1:5)';mloadrate.outdoor{m}{1}{3}(1:5)';mloadrate.outdoor{m}{1}{4}(6:7)';mloadrate.outdoor{m}{1}{5}(6:7)']); %loadrate smartphone
                            results.acc_all{n}{m}(:,2)= cell2mat([mloadrate.outdoor{m}{2}{1}(1:5)';mloadrate.outdoor{m}{2}{2}(1:5)';mloadrate.outdoor{m}{2}{3}(1:5)';mloadrate.outdoor{m}{2}{4}(6:7)';mloadrate.outdoor{m}{2}{5}(6:7)']); %loadrate smartwatch
                            results.acc_all{n}{m}(:,3)= ([1;1;1;1;1;2;2;2;2;2;3;3;3;3;3;4;4;5;5]); % speed
                            results.acc_all{n}{m}(:,4)= ([1;2;3;4;5;1;2;3;4;5;1;2;3;4;5;6;7;6;7]); % condition
                            results.acc_all{n}{m}(:,5)=([weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m)]); %weight
                            results.acc_all{n}{m}(:,6)=([m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m]); % participant 
                            results.acc_all{n}{m}(:,7)=cell2mat([mloadrate.outdoor{m}{3}{1}(1:5)';mloadrate.outdoor{m}{3}{2}(1:5)';mloadrate.outdoor{m}{3}{3}(1:5)';mloadrate.outdoor{m}{3}{4}(6:7)';mloadrate.outdoor{m}{3}{5}(6:7)']); %GPS
                            results.acc_all{n}{m}(:,8)= cell2mat([FFT.outdoor{m}{n}{1}(1:5)';FFT.outdoor{m}{n}{2}(1:5)';FFT.outdoor{m}{n}{3}(1:5)';FFT.outdoor{m}{n}{4}(6:7)';FFT.outdoor{m}{n}{5}(6:7)']); %frequency
                            
                        end
                    end
                end
            end
        end
    end
end