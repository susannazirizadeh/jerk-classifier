%% Transforming raw_int into jerk_jerk_pos with cutoff before 1000 and 1000 before end
 load raw_int
%% Transfer into jerk_jerk_pos part 2
% Allocat jerk_jerk_pos_data.treadmill
jerk_jerk_pos.treadmill= cell(1,12);
for m= 1:12
    jerk_jerk_pos.treadmill{m}= cell(1,5);
    for n=1:5
        jerk_jerk_pos.treadmill{m}{n}= cell(1,3);
        for o=1:3
            jerk_jerk_pos.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                jerk_jerk_pos.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end
%% Transform raw_int into jerk in original direction
for m= 1:12 %Participants
    for n=1:4%5 % Excluding the Forceplate
        if isempty(raw_int.treadmill{m}{n}) ~= 1
            for o=1:3   % Speed
                if isempty( raw_int.treadmill{m}{n}{o}) ~= 1
                    for p=1:6   % Gravity
                        if isempty( raw_int.treadmill{m}{n}{o}{p}) ~= 1
                                [jerk_jerk_pos.treadmill{m}{n}{o}{p}(:,2),jerk_jerk_pos.treadmill{m}{n}{o}{p}(:,3)]=jerk_pos(raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1),raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,:));
                                jerk_jerk_pos.treadmill{m}{n}{o}{p}(:,1)=raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1);
                        end
                    end
                end
            end
        end
    end
end
%% Entering the force plate data using "jerk" function 
for m= 1:12
    if isempty(raw_int.treadmill{m}{5}) ~= 1
        for o=1:3
            if isempty( raw_int.treadmill{m}{5}{o}) ~= 1
                for p=1:6
                    if isempty( raw_int.treadmill{m}{5}{o}{p}) ~= 1
                        [jerk_jerk_pos.treadmill{m}{5}{o}{p}(:,2),jerk_jerk_pos.treadmill{m}{5}{o}{p}(:,3)]=jerk_fp(raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1),raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,6));
                        jerk_jerk_pos.treadmill{m}{5}{o}{p}(:,1)=raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1);
                    end
                end
            end
        end
    end
end
%% Develope mean of the data 
% Allocate mjerk_jerk_pos
mjerk_jerk_pos.treadmill= cell(1,12);
for m= 1:12
    mjerk_jerk_pos.treadmill{m}= cell(1,5);
    for n=1:5
        mjerk_jerk_pos.treadmill{m}{n}= cell(1,3);
        for o=1:3
            mjerk_jerk_pos.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                mjerk_jerk_pos.treadmill{m}{n}{o}{p}= NaN;
            end
        end
    end
end
%% Calculate mean 
% Calculate mean of jerk_jerk_pos in the gravity direction for smartphones
% and smartwatches 
for m= 1:12
    for n=1:4%5
        if isempty(jerk_jerk_pos.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty(jerk_jerk_pos.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty(jerk_jerk_pos.treadmill{m}{n}{o}{p}) ~= 1
                            mjerk_jerk_pos.treadmill{m}{n}{o}{p}= sum(jerk_jerk_pos.treadmill{m}{n}{o}{p}(:,2))./sum(jerk_jerk_pos.treadmill{m}{n}{o}{p}(:,3));
                        end
                    end
                end
            end
        end
    end
end


% Mean for forceplate data  
for m= 1:12
    for n= 5
        if isempty(jerk_jerk_pos.treadmill{m}{5}) ~= 1
            for o=1:3
                if isempty(jerk_jerk_pos.treadmill{m}{5}{o}) ~= 1
                    for p=1:6
                        if isempty(jerk_jerk_pos.treadmill{m}{5}{o}{p}) ~= 1
                                mjerk_jerk_pos.treadmill{m}{5}{o}{p}= sum(jerk_jerk_pos.treadmill{m}{5}{o}{p}(:,2))./sum(jerk_jerk_pos.treadmill{m}{5}{o}{p}(:,3)); % mean for 
                        end
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

%% Display the mean of the jerk per weight
speed = [5 8 12];
device  = cellstr(['SP1';'SW1';'SP2';'SW2';'FP ']);

% for n= 1:4%length(device)
%     for o=1:length(speed)
        result= NaN(6,12);
        for m=1:11
            for p= 1:6
                if isempty( mjerk_jerk_pos.treadmill{m}{3}{3}{p} ) ~= 1
                    
                    result(p,m)= mjerk_jerk_pos.treadmill{m}{3}{3}{p};
                end
            end
        end
        
        figure
        Rsq=zeros(11,1);
        for m=1:11
            x= BWperweight(1:6,m);
            y= result(1:6,m);
            b1 = x\y;
            yCalc1 = b1*x;yCalc1 = b1*x;
            
            hold on
            scatter(x,y)
            title('Smartphone jerk value in vertical directions 12km/h')
            xlabel('Body weight [kg]')
            ylabel('Jerk [m/s^3]')
            legend ('Participant 1','Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','southeast')
            grid on

            
        end

