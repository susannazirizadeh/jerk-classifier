%% Transforming raw_int into loadrate with cutoff before 1000 and 1000 before end
    load raw_int
weight= [73.815 87.34 69.69 85.1 70.4 80.5 72.37 93.49 78.2 85.8 78.1 73.1]; %Weights of each participants
BWper=[ 0.2 0.5 0.7 0.8 0.9 1.0]; % Bodyweight percentages that they were running at
for i=1:6
    for j=1:12
        BWperweight(i,j)=weight(j)*BWper(i);
    end
end
%% Transfer into loadrate part 2
% Allocat loadrate_data.treadmill
loadrate.treadmill= cell(1,12);
for m= 1:12
    loadrate.treadmill{m}= cell(1,5);
    for n=1:5
        loadrate.treadmill{m}{n}= cell(1,3);
        for o=1:3
            loadrate.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                loadrate.treadmill{m}{n}{o}{p}= [];
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
%                             loadrate.treadmill{m}{n}{o}{p}(:,2)=jerk_xyz(raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1),raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,:));
                                [loadrate.treadmill{m}{n}{o}{p}(:,2),loadrate.treadmill{m}{n}{o}{p}(:,3)]=jerk_all(raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1),raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,:));
                                loadrate.treadmill{m}{n}{o}{p}(:,2)=loadrate.treadmill{m}{n}{o}{p}(:,2).*BWperweight(p,m);
                                loadrate.treadmill{m}{n}{o}{p}(:,1)=raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1);
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
%                         loadrate.treadmill{m}{5}{o}{p}(:,3)=jerk(raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1),raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,6));
                        [loadrate.treadmill{m}{5}{o}{p}(:,2),loadrate.treadmill{m}{5}{o}{p}(:,3)]=jerk_fp(raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1),raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,6));
                        loadrate.treadmill{m}{5}{o}{p}(:,1)=raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1);
                    end
                end
            end
        end
    end
end
%% Develope mean of the data 
% Allocate mloadrate
mloadrate.treadmill= cell(1,12);
for m= 1:12
    mloadrate.treadmill{m}= cell(1,5);
    for n=1:5
        mloadrate.treadmill{m}{n}= cell(1,3);
        for o=1:3
            mloadrate.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                mloadrate.treadmill{m}{n}{o}{p}= NaN;
            end
        end
    end
end
%% Calculate mean 
% Calculate mean of loadrate in the gravity direction for smartphones
% and smartwatches 
for m= 1:12
    for n=1:4%5
        if isempty(loadrate.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty(loadrate.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty(loadrate.treadmill{m}{n}{o}{p}) ~= 1
%                             mloadrate.treadmill{m}{n}{o}{p}=mean(loadrate.treadmill{m}{n}{o}{p}(:,2));
                            mloadrate.treadmill{m}{n}{o}{p}= sum(loadrate.treadmill{m}{n}{o}{p}(:,2))./sum(loadrate.treadmill{m}{n}{o}{p}(:,3));
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
        if isempty(loadrate.treadmill{m}{5}) ~= 1
            for o=1:3
                if isempty(loadrate.treadmill{m}{5}{o}) ~= 1
                    for p=1:6
                        if isempty(loadrate.treadmill{m}{5}{o}{p}) ~= 1
%                          mloadrate.treadmill{m}{n}{o}{p}=mean(loadrate.treadmill{m}{n}{o}{p}(:,2));
                                mloadrate.treadmill{m}{5}{o}{p}= sum(loadrate.treadmill{m}{5}{o}{p}(:,2))./sum(loadrate.treadmill{m}{5}{o}{p}(:,3)); % mean for 
                        end
                    end
                end
            end
        end
    end
end