% load mloadrate          % Data set with the mean of the data with jerk data from the phone and the force  of the force plate
 
%% Fit a line for smartphone and forceplate data 
speed = [5 8 12];
for o=1:length(speed)
    figure;
    mloadrate1= NaN(6,12);
    mloadrate2= NaN(6,12);
    for m= 1:12
        for p= 1:6
            if isempty( mloadrate.treadmill{m}{3}{o}{p} ) ~= 1
                if isempty( mloadrate.treadmill{m}{5}{o}{p} ) ~= 1
                    mloadrate1(p,m)= mloadrate.treadmill{m}{3}{o}{p};   % Smartphone data combined into a matrix for the linear regression
                    mloadrate2(p,m)= mloadrate.treadmill{m}{5}{o}{p};   % Force plate data combined into a matrix for the linear regression
                end
            end
        end
        
        try
            f=fit(mloadrate2(:,m),mloadrate1(:,m),'poly1');             % Fitting model
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        display(f)
        plot (mloadrate2(1:6,1:6),mloadrate1(1:6,1:6),'*',mloadrate2(1:6,7:12),mloadrate1(1:6,7:12),'o') % Plot data points
        hold on
        plot(f,'-');  % Plot linear regression line
        hold on
        title(['Jerk of Smartphone between the sholder baldes and force plate, ' num2str(speed(o)) 'km/h'])
        xlabel('Jerk of ground reaction force by force plate [N]')
        ylabel('Jerk device [m/s^3]')
        legend ('Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','northwest')
        grid on
        filename= (['jerk_grf_SW1_FP_' num2str(speed(o)) 'km.pdf']);
        print(filename,'-dpdf')
    end
end

%% Linear regression model with two variables
    % Jerk from smartphone= responds variable
    % Load rate from force place= predictor variable 
    % Speed= predictore variable
    % Body weight
    
    % Per weight
weight= [73.815 87.34 69.69 85.1 70.4 80.5 72.37 93.49 78.2 85.8 78.1 69.7];
BWper=[ 0.2 0.5 0.7 0.8 0.9 1.0];
for i=1:6
    for j=1:12
    BWperweight(i,j)=weight(j)*BWper(i);
    end 
end   
    
speed = [5 8 12];
device  = cellstr(['SP1';'SW1';'SP2';'SW2';'FP ']);
participant= [1 2 3 4 5 6 7 8 9 10 11 12];
for n=1:4
    results_loadrate.treadmill{n}= cell(1,12);
    for m=1:12
        results_loadrate.treadmill{n}{m}= NaN(18,5);
    end
end


i=0; % Participant counter
for n=1:4
for m= 1:12
%     figure;
    for  p=1:6
        if isempty( mloadrate.treadmill{m}{3}{1}{p} ) ~= 1
            if isempty( mloadrate.treadmill{m}{3}{2}{p} ) ~= 1
                if isempty( mloadrate.treadmill{m}{3}{3}{p} ) ~= 1         
                    results_loadrate.treadmill{n}{m}(:,1)= cell2mat([mloadrate.treadmill{m}{5}{1}(1:6)';mloadrate.treadmill{m}{5}{2}(1:6)';mloadrate.treadmill{m}{5}{3}(1:6)']);
                    results_loadrate.treadmill{n}{m}(:,2)= cell2mat([mloadrate.treadmill{m}{n}{1}(1:6)';mloadrate.treadmill{m}{n}{2}(1:6)';mloadrate.treadmill{m}{n}{3}(1:6)']);
                    results_loadrate.treadmill{n}{m}(:,3)= ([5,5,5,5,5,5,8,8,8,8,8,8,12,12,12,12,12,12]);
                    results_loadrate.treadmill{n}{m}(:,4)=([BWperweight(1:6,m);BWperweight(1:6,m);BWperweight(1:6,m)]);
                    results_loadrate.treadmill{n}{m}(:,5)=([m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m,m]); 
                end
            end
        end
    end
    
%     A= results_loadrate.treadmill_SW2{m}(:,1:3);
%     R = corrcoef(A);        % Correlation coefficiant 
%     display(R);
%     try
%         mld=fitlm(results_loadrate.treadmill_SW2{m}(:,2:3),results_loadrate.treadmill_SW2{m}(:,1));   % Fit linear regresion model for two variables 
%     catch
%         display(['fitting error for participant ' , num2str(m)])
%     end
%     i=i+1; % Participant counter
%     A= results_loadrate.treadmill_SW2{m}(:,1:3);
%     R = corrcoef(A);
%     display(i)
%     display(mld)
%             scatter3 (results_loadrate.treadmill_SW2{m}(1:6,3),results_loadrate.treadmill_SW2{m}(1:6,1),results_loadrate.treadmill_SW2{m}(1:6,2),'g')        % 3D scatter plots for 5km/h, forceplate data and smartphone jerk for each participant 
%             hold on
%             scatter3(results_loadrate.treadmill_SW2{m}(7:12,3),results_loadrate.treadmill_SW2{m}(7:12,1),results_loadrate.treadmill_SW2{m}(7:12,2),'r')      % 3D scatter plots for 8km/h, forceplate data and smartphone jerk for each participant
%             hold on
%             scatter3(results_loadrate.treadmill_SW2{m}(13:18,3),results_loadrate.treadmill_SW2{m}(13:18,1),results_loadrate.treadmill_SW2{m}(13:18,2),'b')   % 3D scatter plots for 12km/h, forceplate data and smartphone jerk for each participant
%         title(['Jerk of Smartphone between the sholder baldes and force plate,  P' num2str(participant(m))])
%         xlabel('Speed [m/s]')
%         ylabel('Jerk from Ground reaction force by force plate [N/s]')
%         zlabel('Jerk from smartphone between sholder baldes [m/s^3]')
%         legend ('5km/h','8km/h','12km/h','Location','northwest')
%         grid on
%         hold on
%         filename= (['jerk_SP2_FP_speed' num2str(participant(m)) '.pdf']);
%         print(filename,'-dpdf')
%         grid on
end
end 
