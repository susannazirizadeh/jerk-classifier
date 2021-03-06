%% Transforming raw_int.outdoor into classification_data with cutoff before 500 and 500 before end 
% m= participants   (12)
% n= device         (3)
% o= speed          (5)
% p= condition      (7) (asphalt,grass,soil,inlcineup, inclinedown, stairsup, stairs down)
%   load raw_int

partic= cellstr(['P1 ';'P2 ';'P3 ';'P4 ';'P5 ';'P6 ';'P7 ';'P8 ';'P9 ';'P10';'P11';'P12']);
device  = cellstr(['SP1';'SW1';'GPS']);
speed = cellstr(['5km/h ';'8km/h ';'12km/h';'slow  ';'fast  ']);
con= cellstr(['asphalt    ';'grass      ';'soil       ';'inlcineup  ';'inclinedown';'stairsup   ';'stairsdown ']);
weight= [67.1; 79.4; 63.2; 77.1; 63.5; 72.7; 65.5; 84.8; 70.5; 77.5; 70.6; 62.7]; %Weights of each participants 
%% Transfer into classification_data.jerk_pos
% Allocat classification_data.jerk_pos
classification_data.jerk_pos= cell(1,length(partic));
for m= 1:length(partic)
    classification_data.jerk_pos{m}= cell(1,length(device));
    for n=1:length(device)
        classification_data.jerk_pos{m}{n}= cell(1,length(speed));
        for o=1:length(speed)
            classification_data.jerk_pos{m}{n}{o}= cell(1,length(con));
            for p=1:length(con)
                classification_data.jerk_pos{m}{n}{o}{p}= [];
            end
        end
    end
end

%% Transform raw_int.outdoor to classification_data.jerk_pos for SP1 and SW1
% For smartphone and smartwatch 
for m= 1:length(partic) %Participants
    if isempty(raw_int.outdoor{m}) ~= 1
        for n=1%:2%length(device) % Excluding GPS
            if isempty(raw_int.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p=1:5%length(con)   % Conditions
                            if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                a=raw_int.outdoor{m}{n}{o}{p}(1:length(raw_int.outdoor{m}{n}{o}{p}(:,:)),1); % time 
                                b=raw_int.outdoor{m}{n}{o}{p}(1:length(raw_int.outdoor{m}{n}{o}{p}),1:4);    % vector 
                                [classification_data.jerk_pos{m}{n}{o}{p}(:,2),classification_data.jerk_pos{m}{n}{o}{p}(:,3),classification_data.jerk_pos{m}{n}{o}{p}(:,4)]=jerk_pos(a(500:end-500,1),b(500:end-500,1:4));
                                classification_data.jerk_pos{m}{n}{o}{p}(:,1)=a(500:end-500,1);
                            end
                        end
                        for p=6:7 %length(con)   % Conditions
                            if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                a=raw_int.outdoor{m}{n}{o}{p}(1:length(raw_int.outdoor{m}{n}{o}{p}),1);
                                b=raw_int.outdoor{m}{n}{o}{p}(1:length(raw_int.outdoor{m}{n}{o}{p}),1:4);
                                [classification_data.jerk_pos{m}{n}{o}{p}(:,2),classification_data.jerk_pos{m}{n}{o}{p}(:,3),classification_data.jerk_pos{m}{n}{o}{p}(:,4)]=jerk_pos(a(10:end-10,1),b(10:end-10,1:4));
                                classification_data.jerk_pos{m}{n}{o}{p}(:,1)=a(10:end-10,1);
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
    if isempty(classification_data.jerk_pos{m}) ~= 1
        for n=3
            if isempty(raw_int.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p=1:5%length(con)   % Conditions
                            if isempty(raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                classification_data.jerk_pos{m}{n}{o}{p}(:,1:3)=raw_int.outdoor{m}{n}{o}{p}(500:end-500,1:3);
                            end
                        end
                        for p=6:7%length(con)   % Conditions
                            if isempty(raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                classification_data.jerk_pos{m}{n}{o}{p}(:,1:3)=raw_int.outdoor{m}{n}{o}{p}(10:end-10,1:3);
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
                mloadrate.outdoor{m}{n}{o}{p}= NaN(1,5);
            end
        end
    end
end

%% Calculate mean of jerk_pos
% For smartwatch and smartphone
for m= 1:length(partic)
    if isempty(classification_data.jerk_pos{m}) ~= 1
        for n=1:2 %length(device)
            if isempty(classification_data.jerk_pos{m}{n}) ~= 1
                for o=1:length(speed)
                    if isempty(classification_data.jerk_pos{m}{n}{o}) ~= 1
                        for p=1:5%length(con)
                            if isempty(classification_data.jerk_pos{m}{n}{o}{p}) ~= 1
                                win=500;
                                for i= 1:win/2:length(classification_data.jerk_pos{m}{n}{o}{p})
                                    if i+win < length(classification_data.jerk_pos{m}{n}{o}{p}) % Windowing, window length= 500 data points (4 seconds) with 50% overlapping
                                        
                                        sum_window = sum(classification_data.jerk_pos{m}{n}{o}{p}(i:i+(win-1),2));
                                        count_nonzero = sum(classification_data.jerk_pos{m}{n}{o}{p}(i:i+(win-1),3));
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),1)= (sum_window./count_nonzero)*weight(m,1); % mean of 500 data points
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),2)= o; % speed
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),3)= p; % condition
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),4)= weight(m); %weight of participant
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),5)= m; % participant ID
                                    end
                                end
                                win=500;
                                if isempty(classification_data.jerk_pos{m}{3}{o}{p}) ~= 1 %GPS with 1Hz sampling frequency , window 4s
                                    for i= 1:win/2:length(classification_data.jerk_pos{m}{3}{o}{p})
                                        if i+win < length(classification_data.jerk_pos{m}{3}{o}{p})
                                            mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),1)= (nanmean(classification_data.jerk_pos{m}{3}{o}{p}(i:i+(win-1),3)))*3.6; % 3.6 is to make it from m/s to km/h 
                                            mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),2)= o; % speed
                                            mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),3)= p; % condition
                                            mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),4)= weight(m); %weight of participant
                                            mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),5)= m; % participant ID
                                        end
                                    end
                                end
                            end
                        end
                        for p= 6:7
                            if isempty(classification_data.jerk_pos{m}{n}{o}{p}) ~= 1
                                win=100;
                                for i= 1:win/2:length(classification_data.jerk_pos{m}{n}{o}{p})
                                    if i+win < length(classification_data.jerk_pos{m}{n}{o}{p}) % Windowing, window length= 100 data points (5 seconds) with 50% overlapping
                                        sum_window = sum(classification_data.jerk_pos{m}{n}{o}{p}(i:i+(win-1),2));
                                        count_nonzero = sum(classification_data.jerk_pos{m}{n}{o}{p}(i:i+(win-1),3));
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),1)= (sum_window./count_nonzero)*weight(m,1); % mean of 500 data points
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),2)= o; % speed
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),3)= p; % condition
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),4)= weight(m); %weight of participant
                                        mloadrate.outdoor{m}{n}{o}{p}((i + (win/2)-1) / (win/2),5)= m; % participant ID
                                    end
                                end 
                             if isempty(classification_data.jerk_pos{m}{n}{o}{p}) ~= 1
                                %GPS with 1Hz sampling frequency , window 5s
                                win=100;
                                for i= 1:win/2:length(classification_data.jerk_pos{m}{3}{o}{p})
                                    if i+win < length(classification_data.jerk_pos{m}{3}{o}{p})
                                        mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),1)= (nanmean(classification_data.jerk_pos{m}{3}{o}{p}(i:i+(win-1),3)))*3.6; % 3.6 is to make it from m/s to km/h
                                        mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),2)= o; % speed
                                        mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),3)= p; % condition
                                        mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),4)= weight(m); %weight of participant
                                        mloadrate.outdoor{m}{3}{o}{p}((i + (win/2)-1) / (win/2),5)= m; % participant ID
                                        
                                    end
                                end
                             end 
                            end
                        end
                    end
                end
            end
        end
    end
end


%%  Calculating results.jerkpos of outdoor session for classifier     
y=366; % Sum of conditions and speed  
for n=1:2%length(device)
    results.jerk_pos{n}= cell(1,length(partic));
    for m=1:length(partic)
        results.jerk_pos{n}{m}= NaN(y,6);
    end
end

% condition; asphalt=1, grass=2, soil=3, inclineup=4, inclinedown= 5,
% stairsup=6, stairsdown=7
i=0; % Participant counter
for n=1:3
    for m= 1:length(partic)
        if isempty( mloadrate.outdoor{m} ) ~= 1
            for o=1:3%length(speed)
                if isempty( mloadrate.outdoor{m}{n}{o} ) ~= 1
                    for  p=1:length(con)
                        if isempty( mloadrate.outdoor{m}{n}{o}{p} ) ~= 1
                            SP_5= [mloadrate.outdoor{m}{1}{1}{1}(:,:); mloadrate.outdoor{m}{1}{1}{2}(:,:); mloadrate.outdoor{m}{1}{1}{3}(:,:); mloadrate.outdoor{m}{1}{1}{4}(:,:); mloadrate.outdoor{m}{1}{1}{5}(:,:)];
                            SP_8= [mloadrate.outdoor{m}{1}{2}{1}(:,:); mloadrate.outdoor{m}{1}{2}{2}(:,:); mloadrate.outdoor{m}{1}{2}{3}(:,:); mloadrate.outdoor{m}{1}{2}{4}(:,:); mloadrate.outdoor{m}{1}{2}{5}(:,:)];
                            SP_12= [mloadrate.outdoor{m}{1}{3}{1}(:,:); mloadrate.outdoor{m}{1}{3}{2}(:,:); mloadrate.outdoor{m}{1}{3}{3}(:,:); mloadrate.outdoor{m}{1}{3}{4}(:,:); mloadrate.outdoor{m}{1}{3}{5}(:,:)];
                            SP_slow= [ mloadrate.outdoor{m}{1}{4}{6}(:,:); mloadrate.outdoor{m}{1}{4}{7}(:,:)];
                            SP_fast= [mloadrate.outdoor{m}{1}{5}{6}(:,:); mloadrate.outdoor{m}{1}{5}{7}(:,:)];
                            GPS_5=[mloadrate.outdoor{m}{3}{1}{1}(:,:);mloadrate.outdoor{m}{3}{1}{2}(:,:);mloadrate.outdoor{m}{3}{1}{3}(:,:);mloadrate.outdoor{m}{3}{1}{4}(:,:);mloadrate.outdoor{m}{3}{1}{5}(:,:)];
                            GPS_8=[mloadrate.outdoor{m}{3}{2}{1}(:,:);mloadrate.outdoor{m}{3}{2}{2}(:,:);mloadrate.outdoor{m}{3}{2}{3}(:,:);mloadrate.outdoor{m}{3}{2}{4}(:,:);mloadrate.outdoor{m}{3}{2}{5}(:,:)];
                            GPS_12= [mloadrate.outdoor{m}{3}{3}{1}(:,:); mloadrate.outdoor{m}{3}{3}{2}(:,:); mloadrate.outdoor{m}{3}{3}{3}(:,:); mloadrate.outdoor{m}{3}{3}{4}(:,:); mloadrate.outdoor{m}{3}{3}{5}(:,:)];
                            GPS_slow= [ mloadrate.outdoor{m}{3}{4}{6}(:,:); mloadrate.outdoor{m}{3}{4}{7}(:,:)];
                            GPS_fast= [mloadrate.outdoor{m}{3}{5}{6}(:,:); mloadrate.outdoor{m}{3}{5}{7}(:,:)];
                            GPS=[GPS_5;SP_8;GPS_12;GPS_slow;GPS_fast];
                            SP=[SP_5;SP_8;SP_12;SP_slow;SP_fast];
                            results.jerk_pos{n}{m}(1:length(SP),1:5)= SP; %loadrate smartphone
                            a=GPS(:,1);
                            results.jerk_pos{n}{m}(1:length(GPS),6)= a;
                        end
                    end
                end
            end
        end
    end
end
