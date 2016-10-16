load raw_int
%% Transfer into j_xyz part 2
% Allocat jerk_xyz_int_data.treadmill
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

%% Transform raw_int into jerk in gravity direction
% load aload
for m= 1:12
    for n=1:4%5
        if isempty(raw_int.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty( raw_int.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        disp('working')
                        if isempty( raw_int.treadmill{m}{n}{o}{p}) ~= 1
                                jerk_xyz_int.treadmill{m}{n}{o}{p}(:,2)=jerk_xyz(raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1),raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,:));
                                jerk_xyz_int.treadmill{m}{n}{o}{p}(:,1)=raw_int.treadmill{m}{n}{o}{p}(1000:end-1000,1);
                        end
                    end
                end
            end
        end
    end
end

%% Entering the force plate data 
for m= 1:12
    if isempty(raw_int.treadmill{m}{5}) ~= 1
        for o=1:3
            if isempty( raw_int.treadmill{m}{5}{o}) ~= 1
                for p=1:6
                    if isempty( raw_int.treadmill{m}{5}{o}{p}) ~= 1
                        jerk_xyz_int.treadmill{m}{5}{o}{p}(:,2)=jerk(raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1),raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,6));
                        jerk_xyz_int.treadmill{m}{5}{o}{p}(:,1)=raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1);
                    end
                end
            end
        end
    end
end
% %% Entering the force plate data 
% for m= 1:12
%     if isempty(raw_int.treadmill{m}{5}) ~= 1
%         for o=1:3
%             if isempty( raw_int.treadmill{m}{5}{o}) ~= 1
%                 for p=1:6
%                     if isempty( raw_int.treadmill{m}{5}{o}{p}) ~= 1
%                         jerk_xyz_int.treadmill{m}{5}{o}{p}(:,2)=raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,6);
%                         jerk_xyz_int.treadmill{m}{5}{o}{p}(:,1)=raw_int.treadmill{m}{5}{o}{p}(1000:end-1000,1);
%                     end
%                 end
%             end
%         end
%     end
% end
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
% Calculate mean of jerk_xyz_int in the gravity direction (in this case 4th
% colum)
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

% for n= 1:4%length(device)
%     for o=1:length(speed)
        result= NaN(6,12);
        for m=1:11
            for p= 1:6
                if isempty( mjerk_xyz_int.treadmill{m}{3}{3}{p} ) ~= 1
                    
                    result(p,m)= mjerk_xyz_int.treadmill{m}{3}{3}{p};
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
%             plot(x,yCalc1)
            title('Smartphone jerk value in vertical directions 12km/h')
            xlabel('Body weight [kg]')
            ylabel('Jerk [m/s^3]')
            legend ('Participant 1','Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','southeast')
%             legend ('Participant 1','Line 1','Participate 2','Line 2','Participate 3','Line 3','Participate 4','Line 4','Participate 5','Line 5','Participate 6','Line 6','Participate 7','Line 7','Participate 8','Line 8','Participate 9','Line 9','Participate 10','Line 10','Participate 11','Line 11','Location','southeast')
            grid on
%             Rsq(m,1)= 1 - sum((y - yCalc1).^2)/sum((y - mean(y)).^2);
            
        end
        
%         
%        for m=1:11 
%         R=corrcoef(BWperweight(1:6,m),result(1:6,m));
%         display= R;
%        end 

%         
%         figure;
%         plot(BWperweight(1:6,1:12),result(1:6,1:12),'o')
%         title(['Calculated Load vs. bodyweight in gravity direction, ' num2str(speed(o)) 'km/h, ' device{n}])
%         
%         %    axis([10 100  0 300000])
%         filename= (['jerk_xyz_int_' num2str(speed(o)) 'km_' device{n} '.pdf']);
% %         print(filename,'-dpdf')
%     end
% end

