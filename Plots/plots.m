
%% Per weight
 load mjerk_jerk
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
for n= 1:4%length(device)
    for o=2:length(speed)
        result= NaN(6,12);
        figure;
        for m= 2:12
            for p= 1:6
                if isempty( mjerk_jerk.treadmill{m}{n}{o}{p} ) ~= 1
                    
                    result(p,m)= mjerk_jerk.treadmill{m}{n}{o}{p};
                end
            end
            plot (BWperweight(1:6,1:6),result(1:6,1:6),'*-',BWperweight(1:6,7:12),result(1:6,7:12),'o-')
            title(['Calculated Load vs. bodyweight, ' num2str(speed(o)) 'km/h, ' device{n}])
            xlabel('Body weight [kg]')
            ylabel('Jerk [m/s^3]')
            legend ('Participant 1','Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','southeast')
            grid on
             hold on 
            %    axis([10 100  0 300000])
            filename= (['jerk_jerk_' num2str(speed(o)) 'km_' device{n} '.pdf']);
            print(filename,'-dpdf')
        end
    end
end 