%% Transforming raw_data into jerk_data for phone between shoulder blades with cutoff before 4000 and after 8000
% m= participants
% n= device
% o= speed
% p= gravity

%% Transfer into j_xyz part 2
% Allocat jerk_xyz_data.treadmill
jerk_xyz_data.treadmill= cell(1,12)
for m= 1:12
    jerk_xyz_data.treadmill{m}= cell(1,5)
    for n=1:5
    jerk_xyz_data.treadmill{m}{n}= cell(1,3)
        for o=1:3
        jerk_xyz_data.treadmill{m}{n}{o}= cell(1,6)
            for p=1:6
                jerk_xyz_data.treadmill{m}{n}{o}{p}= []
            end
        end
    end
end

%% Transform raw_data to jerk_xyz
count_less_than_8000 = 0;
count_more_than_8000 = 0;
for m= 1:12
    for n=1:5
        if isempty(raw_data.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty( raw_data.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty( raw_data.treadmill{m}{n}{o}{p}) ~= 1
                            for q=2:4
                                display(length(raw_data.treadmill{m}{n}{o}{p}))
%                                 if length(raw_data.treadmill{m}{n}{o}{p}) >= 8000
                                    X=mean(raw_data.treadmill{m}{n}{o}{p}(1000:end-1000,2));
                                    Y=mean(raw_data.treadmill{m}{n}{o}{p}(1000:end-1000,3));
                                    Z=mean(raw_data.treadmill{m}{n}{o}{p}(1000:end-1000,4));
                                    test=jerk_xyz(raw_data.treadmill{m}{n}{o}{p}(1000:end-1000,1),raw_data.treadmill{m}{n}{o}{p},X,Y,Z);
                                    jerk_xyz_data.treadmill{m}{n}{o}{p}=jerk_xyz(raw_data.treadmill{m}{n}{o}{p}(1000:end-1000,1),raw_data.treadmill{m}{n}{o}{p},X,Y,Z);
                                    jerk_xyz_data.treadmill{m}{n}{o}{p}(:,2)=jerk_xyz_data.treadmill{m}{n}{o}{p};
                                    jerk_xyz_data.treadmill{m}{n}{o}{p}(:,1)=raw_data.treadmill{m}{n}{o}{p}(1000:end-1000,1);
                                    
%                                     count_more_than_8000= count_more_than_8000 + 1;
%                                 else
%                                     count_less_than_8000= count_less_than_8000 + 1;
%                                 end
                            end
                        end
                    end
                end
            end
        end
    end
end


%% Per weight
weight= [73.815 87.34 69.69 85.1 70.4 80.5 72.37 93.49 78.2 85.8 78.1 73.1];

BWper=[ 0.2 0.5 0.7 0.8 0.9 1.0];

% BWweight= weight* BWper;

for i=1:6
    for j=1:12
    BWperweight(i,j)=weight(j)*BWper(i);
    end 
end

%% Develope mean of the data 
% Allocate mjerk_xyz
mjerk_xyz_data.treadmill= cell(1,12);                                                    
for m= 1:12
    mjerk_xyz_data.treadmill{m}= cell(1,5);
    for n=1:5
    mjerk_xyz_data.treadmill{m}{n}= cell(1,3);
        for o=1:3
        mjerk_xyz_data.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                 mjerk_xyz_data.treadmill{m}{n}{o}{p}= [];
             end
        end
    end
end
%%
% Calculate mean of jerk_xyz
for m= 1:12
    for n=1:5
        if isempty(jerk_xyz_data.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty(jerk_xyz_data.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty(jerk_xyz_data.treadmill{m}{n}{o}{p}) ~= 1
                            data = jerk_xyz_data.treadmill{m}{n}{o}{p}(:,2);
                            
                            if length(data) > 0
                                display(mean(data));
                                mjerk_xyz_data.treadmill{m}{n}{o}{p}= mean(data);
                            end
                        end
                    end
                end
            end
        end
    end
end
