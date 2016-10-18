
 load mjerk_xyz_int

%% Display the mean of the jerk per weight
speed = [5 8 12];
% device  = cellstr(['SP1';'SW1';'SP2';'SW2';'FP ']);
% figure;
%  for n= 1:length(device)
for o=1:length(speed)
    figure;
    mjerk_xyz_int1= NaN(6,12);
    mjerk_xyz_int2= NaN(6,12);
    for m= 2:12
        for p= 1:6
            if isempty( mjerk_xyz_int.treadmill{m}{3}{o}{p} ) ~= 1
                if isempty( mjerk_xyz_int.treadmill{m}{5}{o}{p} ) ~= 1
                    mjerk_xyz_int1(p,m)= mjerk_xyz_int.treadmill{m}{3}{o}{p};
                    mjerk_xyz_int2(p,m)= mjerk_xyz_int.treadmill{m}{5}{o}{p};
                end
            end
        end   
        
        try
            f=fit(mjerk_xyz_int2(:,m),mjerk_xyz_int1(:,m),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        display(f)
        plot (mjerk_xyz_int2(1:6,1:6),mjerk_xyz_int1(1:6,1:6),'*',mjerk_xyz_int2(1:6,7:12),mjerk_xyz_int1(1:6,7:12),'o')
        plot(f,'-');
        title(['Jerk of Smartphone between the sholder baldes and force plate, ' num2str(speed(o)) 'km/h'])
        xlabel('Ground reaction force by force plate [N]')
        ylabel('Jerk device [m/s^3]')
        legend ('Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','northwest')
        grid on
        hold on
        %    axis([10 100  0 300000])
        filename= (['jerk_SP2_FP_' num2str(speed(o)) 'km.pdf']);
        print(filename,'-dpdf')
    end
end
%  end

%% Display the mean of the jerk per weight
speed = [5 8 12];
device  = cellstr(['SP1';'SW1';'SP2';'SW2';'FP ']);
participant= [1 2 3 4 5 6 7 8 9 10 11 12];
for m=1:12
    results{m}= NaN(18,3);
end 
i=1;
for m= 1:12
    figure;
    for  p=1:6
        if isempty( mjerk_xyz_int.treadmill{m}{3}{1}{p} ) ~= 1
            if isempty( mjerk_xyz_int.treadmill{m}{3}{2}{p} ) ~= 1
                if isempty( mjerk_xyz_int.treadmill{m}{3}{3}{p} ) ~= 1         
                    results{m}(:,1)= cell2mat([mjerk_xyz_int.treadmill{m}{5}{1}(1:6)';mjerk_xyz_int.treadmill{m}{5}{2}(1:6)';mjerk_xyz_int.treadmill{m}{5}{3}(1:6)']);
                    results{m}(:,2)= cell2mat([mjerk_xyz_int.treadmill{m}{3}{1}(1:6)';mjerk_xyz_int.treadmill{m}{3}{2}(1:6)';mjerk_xyz_int.treadmill{m}{3}{3}(1:6)']);
                    results{m}(:,3)= ([5,5,5,5,5,5,8,8,8,8,8,8,12,12,12,12,12,12]);
                end
            end
        end
    end
    try
        mld=fitlm(results{m}(:,2:3),results{m}(:,1));
    catch
        display(['fitting error for participant ' , num2str(m)])
    end
    i=i+1;
    display(i)
    display(mld)
            scatter3 (results{m}(1:6,3),results{m}(1:6,1),results{m}(1:6,2),'g')
%             ,results{m}(7:12,3),results{m}(7:12,1),results{m}(7:12,2),'g',results{m}(13:18,3),results{m}(13:18,1),results{m}(13:18,2),'b')
        title(['Jerk of Smartphone between the sholder baldes and force plate,  P' num2str(participant(m))])
        xlabel('Speed [m/s]')
        ylabel('Ground reaction force by force plate [N]')
        zlabel('Jerk from smartphone between sholder baldes [m/s^3]')
        legend ('5km/h','8km/h','12km/h','Location','northwest')
        grid on
        hold on
        %    axis([10 100  0 300000])
        filename= (['jerk_SP2_FP_' num2str(speed(o)) 'km.pdf']);
        print(filename,'-dpdf')
        hold on
        grid on
end

% %% Display FP, jerk SP and speed
% speed = [5 8 12];
% % device  = cellstr(['SP1';'SW1';'SP2';'SW2';'FP ']);
% % figure;
% %  for n= 1:length(device)
% for o=1:length(speed)
%     figure;
%     mjerk_xyz_int1= NaN(6,12);
%     mjerk_xyz_int2= NaN(6,12);
%     for m= 2:12
%         for p= 1:6
%             if isempty( mjerk_xyz_int.treadmill{m}{3}{o}{p} ) ~= 1
%                 if isempty( mjerk_xyz_int.treadmill{m}{5}{o}{p} ) ~= 1
%                     mjerk_xyz_int1(p,m)= mjerk_xyz_int.treadmill{m}{3}{o}{p};
%                     mjerk_xyz_int2(p,m)= mjerk_xyz_int.treadmill{m}{5}{o}{p};
%                 end
%             end
%         end   
%         
%         try
%             f=fit(mjerk_xyz_int2(:,m),mjerk_xyz_int1(:,m),'poly1');
%         catch
%             display(['fitting error for participant ' , num2str(m)])
%         end
%         display(f)
%         plot (mjerk_xyz_int2(1:6,1:6),mjerk_xyz_int1(1:6,1:6),'*',mjerk_xyz_int2(1:6,7:12),mjerk_xyz_int1(1:6,7:12),'o')
%         plot(f,'-');
%         title(['Jerk of Smartphone between the sholder baldes and force plate, ' num2str(speed(o)) 'km/h'])
%         xlabel('Ground reaction force by force plate [N]')
%         ylabel('Jerk device [m/s^3]')
%         legend ('Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','northwest')
%         grid on
%         hold on
%         %    axis([10 100  0 300000])
%         filename= (['jerk_SP2_FP_' num2str(speed(o)) 'km.pdf']);
%         print(filename,'-dpdf')
%     end
% end
% %  end
