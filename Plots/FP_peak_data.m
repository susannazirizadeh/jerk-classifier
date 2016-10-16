%% Entering the force plate data 
%% Transfer into j_xyz part 2
% Allocat jerk_xyz_int.treadmill
jerk_xyz_int.treadmill= cell(1,12);
for m= 1:12
    jerk_xyz_int.treadmill{m}= cell(1,5);
    for n=1:5
    jerk_xyz_int.treadmill{m}{n}= cell(1,3);
        for o=1:3
        jerk_xyz_int.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                jerk_xyz_int.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end
for m= 1:12
        if isempty(raw_int.treadmill{m}{5}) ~= 1
            for o=1:3
                if isempty( raw_int.treadmill{m}{5}{o}) ~= 1
                    for p=1:6
                        if isempty( raw_int.treadmill{m}{5}{o}{p}) ~= 1
                                    [pks,locs]=findpeaks(raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,6),raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1));
                                    jerk_xyz_int.treadmill{m}{5}{o}{p}(:,2)= pks;
                                    jerk_xyz_int.treadmill{m}{5}{o}{p}(:,1)=locs;
%                                     jerk_xyz_int.treadmill{m}{5}{o}{p}(:,1)=raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1);
                        end
                    end
                end
            end
        end
end
%% Develope mean of the data 
% Allocate mjerk_xyz
mjerk_xyz_int.treadmill= cell(1,12);                                                    
for m= 1:12
    mjerk_xyz_int.treadmill{m}= cell(1,5);
    for n=1:5
    mjerk_xyz_int.treadmill{m}{n}= cell(1,3);
        for o=1:3
        mjerk_xyz_int.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                 mjerk_xyz_int.treadmill{m}{n}{o}{p}= [];
             end
        end
    end
end
%%
% Calculate mean of jerk_xyz
for m= 1:12
    for n=1:5
        if isempty(jerk_xyz_int.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty(jerk_xyz_int.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty(jerk_xyz_int.treadmill{m}{n}{o}{p}) ~= 1
                            data = jerk_xyz_int.treadmill{m}{n}{o}{p}(:,2);
                            
                            if length(data) > 0
                                display(mean(data));
                                mjerk_xyz_int.treadmill{m}{n}{o}{p}= mean(data);
                            end
                        end
                    end
                end
            end
        end
    end
end
