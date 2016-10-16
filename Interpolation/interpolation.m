%% Interpolate the data which is missing
% m= participants
% n= device
% o= speed
% p= gravity

clear all
load raw_data
load mjerk_grav
load jerk_grav

% mean(j(find(j>0)))

%% Transfer into j_xyz part 2
% Allocat jerk_xyz_data.treadmill
raw_zero.treadmill= cell(1,12);
for m= 1:12
    raw_zero.treadmill{m}= cell(1,5);
    for n=1:5
    raw_zero.treadmill{m}{n}= cell(1,3);
        for o=1:3
        raw_zero.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                raw_zero.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end

raw_nans.treadmill= cell(1,12);
for m= 1:12
    raw_nans.treadmill{m}= cell(1,5);
    for n=1:5
    raw_nans.treadmill{m}{n}= cell(1,3);
        for o=1:3
        raw_nans.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                raw_nans.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end
raw_int.treadmill= cell(1,12);
for m= 1:12
    raw_int.treadmill{m}= cell(1,5);
    for n=1:5
    raw_int.treadmill{m}{n}= cell(1,3);
        for o=1:3
        raw_int.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                raw_int.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end

%% Exclude repeted values
for m= 1:12
    for n=1:5
        if isempty(raw_data.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty( raw_data.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty( raw_data.treadmill{m}{n}{o}{p}) ~= 1
                            j=1;k=1;
                            for i=2:length(raw_data.treadmill{m}{n}{o}{p}(:,2))
                                if raw_data.treadmill{m}{n}{o}{p}(i,2)~=raw_data.treadmill{m}{n}{o}{p}(i-1,2);
                                    for q=1:4
                                        raw_zero.treadmill{m}{n}{o}{p}(j,q)= raw_data.treadmill{m}{n}{o}{p}(i,q);
                                    end
                                    j=j+1;
                                else
                                    raw_nans.treadmill{m}{n}{o}{p}(k,1)= raw_data.treadmill{m}{n}{o}{p}(i,1);
                                    k=k+1;
                                end
                            end
                            
                            if isempty( raw_nans.treadmill{m}{n}{o}{p}) ~= 1
                                x= raw_zero.treadmill{m}{n}{o}{p}(:,1); %Linear Interpolation
                                v1= raw_zero.treadmill{m}{n}{o}{p}(:,2);
                                v2= raw_zero.treadmill{m}{n}{o}{p}(:,3);
                                v3= raw_zero.treadmill{m}{n}{o}{p}(:,4);
                                xq= raw_nans.treadmill{m}{n}{o}{p}(:,1);
                                vq1 = interp1(x,v1,xq);
                                vq2 = interp1(x,v2,xq);
                                vq3 = interp1(x,v3,xq);
                            end
                            
                            j=1;
                            for i=2:length(raw_data.treadmill{m}{n}{o}{p}(:,2))
                                if raw_data.treadmill{m}{n}{o}{p}(i,2)~=raw_data.treadmill{m}{n}{o}{p}(i-1,2);
                                    for q=1:4
                                        raw_int.treadmill{m}{n}{o}{p}(i,q)= raw_data.treadmill{m}{n}{o}{p}(i,q);
                                    end
                                else
                                    raw_int.treadmill{m}{n}{o}{p}(i,1)= raw_data.treadmill{m}{n}{o}{p}(i,1);
                                    raw_int.treadmill{m}{n}{o}{p}(i,2)= vq1(j);
                                    raw_int.treadmill{m}{n}{o}{p}(i,3)= vq2(j);
                                    raw_int.treadmill{m}{n}{o}{p}(i,4)= vq3(j);
                                    j=j+1;
                                end
                            end
                        end
                    end
                end
                
            end
        end
    end
end

%% Correct forceplate data 

for m= 1:12 
    if isempty(raw_data.treadmill{m}{5}) ~= 1
        for o=1:3
            if isempty(raw_data.treadmill{m}{5}{o}) ~= 1
                for p=1:6
                    if isempty(raw_data.treadmill{m}{5}{o}{p}) ~= 1
                        raw_int.treadmill{m}{5}{o}{p}(:,2:5)=raw_data.treadmill{m}{5}{o}{p}(:,2:5);
                    end
                end
            end
            
        end
    end
end

