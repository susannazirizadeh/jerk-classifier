%% Transforming raw_int into jerk_grf with cutoff before 1000 and 1000 before end
% Force plate data will not be transformed, remained as forceplate data 
% m= participants
% n= device
% o= speed
% p= gravity

load raw_int
%% Transfer into j_xyz part 2
% Allocat jerk_grf.treadmill
jerk_grf.treadmill= cell(1,12);
for m= 1:12
    jerk_grf.treadmill{m}= cell(1,5);
    for n=1:5
        jerk_grf.treadmill{m}{n}= cell(1,3);
        for o=1:3
            jerk_grf.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                jerk_grf.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end

%% Transform raw_int to jerk_xyz for SM1,SW1,SP2,SW2

for m= 1:12 %Participants
    for n=1:4%5 % Excluding the Forceplate
        if isempty(raw_int.treadmill{m}{n}) ~= 1
            for o=1:3   % Speed
                if isempty( raw_int.treadmill{m}{n}{o}) ~= 1
                    for p=1:6   % Gravity
                        if isempty( raw_int.treadmill{m}{n}{o}{p}) ~= 1
                            jerk_grf.treadmill{m}{n}{o}{p}(:,2)=jerk_xyz(raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1),raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1:4));
                            jerk_grf.treadmill{m}{n}{o}{p}(:,1)=raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1);
                        end
                    end
                end
            end
        end
    end
end

%% Entering the force plate data without transfoming them into jerk
for m= 1:12
    if isempty(raw_int.treadmill{m}{5}) ~= 1
        for o=1:3
            if isempty( raw_int.treadmill{m}{5}{o}) ~= 1
                for p=1:6
                    if isempty( raw_int.treadmill{m}{5}{o}{p}) ~= 1
                        jerk_grf.treadmill{m}{5}{o}{p}(:,2)=raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,6);
                        jerk_grf.treadmill{m}{5}{o}{p}(:,1)=raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1);
                    end
                end
            end
        end
    end
end


%% Per weight
weight= [73.815 87.34 69.69 85.1 70.4 80.5 72.37 93.49 78.2 85.8 78.1 73.1]; %Weights of each participants
BWper=[ 0.2 0.5 0.7 0.8 0.9 1.0]; % Bodyweight percentages that they were running at
for i=1:6
    for j=1:12
        BWperweight(i,j)=weight(j)*BWper(i);
    end
end

%% Develope mean of the data 
% Allocate mjerk_xyz
mjerk_grf.treadmill= cell(1,12);
for m= 1:12
    mjerk_grf.treadmill{m}= cell(1,5);
    for n=1:5
        mjerk_grf.treadmill{m}{n}= cell(1,3);
        for o=1:3
            mjerk_grf.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                mjerk_grf.treadmill{m}{n}{o}{p}= NaN;
            end
        end
    end
end
%%
% Calculate mean of jerk_grf
for m= 1:12
    for n=1:5
        if isempty(jerk_grf.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty(jerk_grf.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty(jerk_grf.treadmill{m}{n}{o}{p}) ~= 1
                            data = jerk_grf.treadmill{m}{n}{o}{p}(:,2);
                            if isempty(data) ~= 1%length(data) > 0
                                mjerk_grf.treadmill{m}{n}{o}{p}= mean(data);
                            end
                        end
                    end
                end
            end
        end
    end
end

%% Transforming raw_int.outdoor into jerk_grf.outdoor with cutoff before 1000 and 1000 before end 
% m= participants   (12)
% n= device         (3)
% o= speed          (5)
% p= condition      (7) (asphalt,grass,soil,inlcineup, inclinedown, stairsup, stairs down)
load raw_int
partic= cellstr(['P1 ';'P2 ';'P3 ';'P4 ';'P5 ';'P6 ';'P7 ';'P8 ';'P9 ';'P10';'P11';'P12']);
device  = cellstr(['SP1';'SW1';'GPS']);
speed = cellstr(['5km/h ';'8km/h ';'12km/h';'slow  ';'fast  ']);
con= cellstr(['asphalt    ';'grass      ';'soil       ';'inlcineup  ';'inclinedown';'stairsup   ';'stairsdown ']);
%% Transfer into j_grf.outdoor
% Allocat jerk_grf.outdoor
jerk_grf.outdoor= cell(1,length(partic));
for m= 1:length(partic)
    jerk_grf.outdoor{m}= cell(1,length(device));
    for n=1:length(device)
        jerk_grf.outdoor{m}{n}= cell(1,length(speed));
        for o=1:length(speed)
            jerk_grf.outdoor{m}{n}{o}= cell(1,length(con));
            for p=1:length(con)
                jerk_grf.outdoor{m}{n}{o}{p}= [];
            end
        end
    end
end

%% Transform raw_int.outdoor to jerk_grf.outdoor for SP1 and SW1
for m= 1:length(partic) %Participants
    if isempty(jerk_grf.outdoor{m}) ~= 1
        for n=1:2 %length(device) % Excluding GPS
            if isempty(raw_int.outdoor{m}{n}) ~= 1
                for o=1:length(speed)   % Speed
                    if isempty( raw_int.outdoor{m}{n}{o}) ~= 1
                        for p=1:length(con)   % Conditions
                            if isempty( raw_int.outdoor{m}{n}{o}{p}) ~= 1
                                jerk_grf.outdoor{m}{n}{o}{p}(:,2)=jerk_xyz(raw_int.outdoor{m}{n}{o}{p}(1000:end-1000,1),raw_int.outdoor{m}{n}{o}{p}(1000:end-1000,1:4));
                                jerk_grf.outdoor{m}{n}{o}{p}(:,1)=raw_int.outdoor{m}{n}{o}{p}(1000:end-1000,1);
                            end
                        end
                    end
                end
            end
        end
    end
end
%% Develope mean of the data 
% Allocate mjerk_xyz.outdoor
mjerk_grf.outdoor= cell(1,length(partic));
for m= 1:length(partic)
    mjerk_grf.outdoor{m}= cell(1,length(device));
    for n=1:length(device)
        mjerk_grf.outdoor{m}{n}= cell(1,length(speed));
        for o=1:length(speed)
            mjerk_grf.outdoor{m}{n}{o}= cell(1,length(con));
            for p=1:length(con)
                mjerk_grf.outdoor{m}{n}{o}{p}= NaN;
            end
        end
    end
end

%%
% Calculate mean of jerk_grf.outdoor
for m= 1:length(partic)
    if isempty(jerk_grf.outdoor{m}) ~= 1
        for n=1:2 %length(speed)
            if isempty(jerk_grf.outdoor{m}{n}) ~= 1
                for o=1:length(speed)
                    if isempty(jerk_grf.outdoor{m}{n}{o}) ~= 1
                        for p=1:length(con)
                            if isempty(jerk_grf.outdoor{m}{n}{o}{p}) ~= 1
                                data = jerk_grf.outdoor{m}{n}{o}{p}(:,2);
                                if isempty(data) ~= 1%length(data) > 0
                                    mjerk_grf.outdoor{m}{n}{o}{p}= mean(data);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
