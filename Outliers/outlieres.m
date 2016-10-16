%% Finding outliers and exclude outliers
% m= participants
% n= device
% o= speed
% p= gravity

clear all
load raw_data
% load mjerk_grav
% load jerk_grav

%% Develope mean of the data 
% Allocate mjerk_xyz
mraw.treadmill= cell(1,12);                                                    
for m= 1:12
    mraw.treadmill{m}= cell(1,5);
    for n=1:5
    mraw.treadmill{m}{n}= cell(1,3);
        for o=1:3
        mraw.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                 mraw.treadmill{m}{n}{o}{p}= [];
             end
        end
    end
end
%%
% Calculate mean of jerk_xyz
for m= 1:12
    for n=1:5
        if isempty(raw_data.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty(raw_data.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty(raw_data.treadmill{m}{n}{o}{p}) ~= 1
                            data = raw_data.treadmill{m}{n}{o}{p}(:,2);
                            
                            if length(data) > 0
                                display(mean(data));
                                mraw.treadmill{m}{n}{o}{p}= mean(data);
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

%% Display the mean of the jerk per weight
speed = [5 8 12];
device  = cellstr(['SP1';'SW1';'SP2';'SW2';'FP ']);

for n= 1:4%length(device)
    for o=1:length(speed)
        result= NaN(6,12);
        for m=1:12
            for p= 1:6
                if isempty( mraw.treadmill{m}{n}{o}{p} ) ~= 1
                    
                    result(p,m)= mraw.treadmill{m}{n}{o}{p};
                end
            end
        end
        
        figure;
        plot (BWperweight(1:6,1:6),result(1:6,1:6),'*-',BWperweight(1:6,7:12),result(1:6,7:12),'o-')
        title(['Calculated Load vs. bodyweight, ' num2str(speed(o)) 'km/h, ' device{n}])
        xlabel('Body weight [kg]')
        ylabel('Accelration [m/s^2] ')%('Jerk [m/s^3]')
        legend ('Participant 1','Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','southeast')
        grid on
        %    axis([10 100  0 300000])
        filename= (['jerk_xyz_' num2str(speed(o)) 'km_' device{n} '.pdf']);
        print(filename,'-dpdf')
    end
end