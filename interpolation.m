%% Transforming raw_data into jerk_data with interpolation of missing data for phone between with cutoff before 4000 and after 8000
% m= participants
% n= device
% o= speed
% p= gravity
load raw_data

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