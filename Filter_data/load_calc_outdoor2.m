%% Transforming raw_int.outdoor into jerk_jerk_pos.outdoor with cutoff before 1000 and 1000 before end 
% m= participants   (12)
% n= device         (3)
% o= speed          (5)
% p= condition      (7) (asphalt,grass,soil,inlcineup, inclinedown, stairsup, stairs down)
load raw_int
load mloadrate
load results_loadrate

partic= cellstr(['P1 ';'P2 ';'P3 ';'P4 ';'P5 ';'P6 ';'P7 ';'P8 ';'P9 ';'P10';'P11';'P12']);
device  = cellstr(['SP1';'SW1';'GPS']);
speed = cellstr(['5km/h ';'8km/h ';'12km/h';'slow  ';'fast  ']);
con= cellstr(['asphalt    ';'grass      ';'soil       ';'inlcineup  ';'inclinedown';'stairsup   ';'stairsdown ']);
weight= [67.1; 79.4; 63.2; 77.1; 63.5; 72.7; 65.5; 84.8; 70.5; 77.5; 70.6; 62.7]; %Weights of each participants 
%% Transfer into jerk_jerkpos.outdoor
% Allocat jerk_jerk_pos.outdoor
jerk_jerk_pos.outdoor= cell(1,length(partic));
for m= 1:length(partic)
    jerk_jerk_pos.outdoor{m}= cell(1,length(device));
    for n=1:length(device)
        jerk_jerk_pos.outdoor{m}{n}= cell(1,length(speed));
        for o=1:length(speed)
            jerk_jerk_pos.outdoor{m}{n}{o}= cell(1,length(con));
            for p=1:length(con)
                jerk_jerk_pos.outdoor{m}{n}{o}{p}= [];
            end
        end
    end
end
%% Transform raw_int.outdoor to jerk_jerk_pos.outdoor for SP1 and SW1
% For smartphone and smartwatch 
for m= 1:length(partic) %Participants
    if isempty(jerk_jerk_pos.outdoor{m}) ~= 1
        for n=1:2%length(device) % Excluding GPS
            if isempty(raw_int.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p=1:5%length(con)   % Conditions
                            if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                [jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,2),jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,3)]=jerk_pos(raw_int.outdoor{m}{n}{o}{p}(1000:end-1000,1),raw_int.outdoor{m}{n}{o}{p}(1000:end-1000,1:4));
                                jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,1)=raw_int.outdoor{m}{n}{o}{p}(1000:end-1000,1);
                            end
                        end
                    end
                end
            end
        end
    end
end
% For the stairs
for m= 1:length(partic) %Participants
    if isempty(jerk_jerk_pos.outdoor{m}) ~= 1
        for n=1:2%length(device) % Excluding GPS
            if isempty(raw_int.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p= 6:7 %1:length(con)   % Conditions
                            if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                [jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,2),jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,3)]=jerk_pos(raw_int.outdoor{m}{n}{o}{p}(100:end-100,1),raw_int.outdoor{m}{n}{o}{p}(100:end-100,1:4));
                                jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,1)=raw_int.outdoor{m}{n}{o}{p}(100:end-100,1);
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
    if isempty(jerk_jerk_pos.outdoor{m}) ~= 1
        for n=3 
            if isempty(raw_int.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p=1:length(con)   % Conditions
                            if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,1:3)=raw_int.outdoor{m}{n}{o}{p}(:,1:3);
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
    if isempty(jerk_jerk_pos.outdoor{m}) ~= 1
        for n=1:2 %length(device)
            if isempty(jerk_jerk_pos.outdoor{m}{n}) ~= 1
                for o=1:length(speed)
                    if isempty(jerk_jerk_pos.outdoor{m}{n}{o}) ~= 1
                        for p=1:length(con)
                            if isempty(jerk_jerk_pos.outdoor{m}{n}{o}{p}) ~= 1
                            mloadrate.outdoor{m}{n}{o}{p}= sum(jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,2))./sum(jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,3))*weight(m,1);
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
    if isempty(jerk_jerk_pos.outdoor{m}) ~= 1
        for n=3 %length(device)
            if isempty(jerk_jerk_pos.outdoor{m}{n}) ~= 1
                for o=1:length(speed)
                    if isempty(jerk_jerk_pos.outdoor{m}{n}{o}) ~= 1
                        for p=1:length(con)
                            if isempty(jerk_jerk_pos.outdoor{m}{n}{o}{p}) ~= 1
                            mloadrate.outdoor{m}{n}{o}{p}= (nanmean(jerk_jerk_pos.outdoor{m}{n}{o}{p}(:,3)))*3.6;
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
    results_loadrate.outdoor{n}= cell(1,length(partic));
    for m=1:length(partic)
        results_loadrate.outdoor{n}{m}= NaN(y,5);
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
                            results_loadrate.outdoor{n}{m}(:,1)= cell2mat([mloadrate.outdoor{m}{n}{1}(1:5)';mloadrate.outdoor{m}{n}{2}(1:5)';mloadrate.outdoor{m}{n}{3}(1:5)';mloadrate.outdoor{m}{n}{4}(6:7)';mloadrate.outdoor{m}{n}{5}(6:7)']);
                            results_loadrate.outdoor{n}{m}(:,2)= ([1;1;1;1;1;2;2;2;2;2;3;3;3;3;3;4;4;5;5]);
                            results_loadrate.outdoor{n}{m}(:,3)= ([1;2;3;4;5;1;2;3;4;5;1;2;3;4;5;6;7;6;7]);
                            results_loadrate.outdoor{n}{m}(:,4)=([weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m),weight(m)]);
                            results_loadrate.outdoor{n}{m}(:,5)=([m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m]);
                            results_loadrate.outdoor{n}{m}(:,6)=cell2mat([mloadrate.outdoor{m}{3}{1}(1:5)';mloadrate.outdoor{m}{3}{2}(1:5)';mloadrate.outdoor{m}{3}{3}(1:5)';mloadrate.outdoor{m}{3}{4}(6:7)';mloadrate.outdoor{m}{3}{5}(6:7)']);
                        end
                    end
                end
            end
        end
    end
end