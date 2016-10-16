%% Correlate smartphone and force plate
% load aload 
% load mjerk_xyz_int_int
speed = [5 8 12];
%device  = cellstr(['SP1';'SW1';'SP2';'SW2';'FP ']);

% for n= 1:5%length(device)
    for o=1:length(speed)
        result1= NaN(6,12);
        result2= NaN(6,12);
        for m=3:12

            for p= 1:6
                if isempty( mjerk_xyz_int.treadmill{m}{3}{3}{p} ) ~= 1
                    if isempty( mjerk_xyz_int.treadmill{m}{5}{3}{p} ) ~= 1
                        result1(p,m)= mjerk_xyz_int.treadmill{m}{3}{o}{p};
                        result2(p,m)= mjerk_xyz_int.treadmill{m}{5}{o}{p};
                    end
                end
            end
            %         end
            figure;
            plot (result2(1:6,1:6),result1(1:6,1:6),'*-',result2(1:6,7:12),result1(1:6,7:12),'o-')
            title(['Calculated load rate of device vs. force plate in gravity direction, ' num2str(speed(o)) 'km/h'])
            %         title(['Calculated load rate of device vs. force plate in gravity direction, 12km/h'])
            xlabel('Jerk device [m/s^3]')
            ylabel('Jerk force plate [m/s^3]')
            legend ('Participant 1','Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','southeast')
            grid on
            hold on
            
            %    axis([10 100  0 300000])
            filename= (['correlate_jerk_grav_' num2str(speed(o)) 'km.pdf']);
            % filename= (['correlate_jerk_grav_12km.pdf']);
            print(filename,'-dpdf')
        end
    end
% end 


%%
figure
Rsq=zeros(11,1);
for m=1:11
    x= result2(1:6,m);
    y= result1(1:6,m);
    b1 = x\y;
    yCalc1 = b1*x;yCalc1 = b1*x;
    
    hold on
    scatter(x,y)
%              plot(x,yCalc1)
    title('Calculated load rate of device vs. force plate in gravity direction 12 km/h, SP2 and FP')
    xlabel('Jerk device [m/s^3]')
    ylabel('Jerk force plate [m/s^3]')
    legend ('Participant 1','Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Location','southeast')
%                 legend ('Participant 1','Line 1','Participate 2','Line 2','Participate 3','Line 3','Participate 4','Line 4','Participate 5','Line 5','Participate 6','Line 6','Participate 7','Line 7','Participate 8','Line 8','Participate 9','Line 9','Participate 10','Line 10','Participate 11','Line 11','Location','southeast')
    grid on
    Rsq(m,1)= 1 - sum((y - yCalc1).^2)/sum((y - mean(y)).^2);
    
end
        

%% Linear regression 
% Allocat results
result.treadmill= cell(1,5);
for n= 1:5
    result.treadmill{n}= cell(1,3);
    for o=1:3
       result.treadmill{n}{o}= []; 
       for m= 1:12
           for p=1:6
             result.treadmill{n}{o}=NaN(p,m);  
           end 
       end 
       
    end 
    
end 

for m=2:12
    for n= 1:5%length(device)
        if isempty(mjerk_xyz_int.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty(mjerk_xyz_int.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty(mjerk_xyz_int.treadmill{m}{n}{o}{p}) ~= 1
                            result.treadmill{n}{o}(p,m)= mjerk_xyz_int.treadmill{m}{n}{o}{p};
                        end 
                    end 
                end
            end
        end
    end
end

%%
for n=1:5
    for o= 1:3
            results_merg{n}= NaN(72,o);
    end 
end
for n=1:5
    for o= 1:3
            results_merg{n}(:,o)= [result.treadmill{n}{o}(:,1);result.treadmill{n}{o}(:,2);result.treadmill{n}{o}(:,3);result.treadmill{n}{o}(:,4);result.treadmill{n}{o}(:,5);result.treadmill{n}{o}(:,6);result.treadmill{n}{o}(:,7);result.treadmill{n}{o}(:,8);result.treadmill{n}{o}(:,9);result.treadmill{n}{o}(:,10);result.treadmill{n}{o}(:,11);result.treadmill{n}{o}(:,12)];
    end
end
                
%% Plots for linear regression
figure
scatter(results_merg{3}(:,3),results_merg{5}(:,3));
title('Calculated load rate of device vs. force plate in gravity direction 12 km/h, SP2 and FP')
xlabel('Jerk device [m/s^3]')
ylabel('Jerk force plate [m/s^3]')
grid on
filename= ('correlate_jerk_grav_12km_SP2.pdf');
print(filename,'-dpdf')

%%
j=1;
for i=1:length(results_merg{3}(:,2))
    if  isnan (results_merg{3}(i,2))
    else
        res_new1(j,1)=results_merg{3}(i,2);
        j=j+1;
    end 
end 

j=1;
for i=1:length(results_merg{5}(:,2))
    if  isnan (results_merg{5}(i,2))
    else
        res_new2(j,1)=results_merg{5}(i,2);
        j=j+1;
    end 
end 

R=corrcoef(res_new1(:,1),res_new2(:,1))