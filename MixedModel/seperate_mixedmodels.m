%% Plots and models for 
   % 1. JerkSP-BW
   % 2. JerkSP-Speed
   % 3. JerkSP-ForceFP
   % 4. JerkSP-JerkFP
% load results_loadrate
load results_loadrate
load results_jerk
 load results_grf
device  = {'SP1' 'SW1' 'SP2' 'SW2'};
 %% 1. Plots and model JerkSP-BW
% Plot
      figure;
 for button= 1:4

     for m=1:12
         x1=results_jerk.treadmill{button}{m}(1:6,4); y1=results_jerk.treadmill{button}{m}(1:6,2);idx = isfinite(x1) & isfinite(y1);
         try
             f1=fit(x1(idx),y1(idx),'poly1');
         catch
             display(['fitting error for participant ' , num2str(m)])
         end
         x2=results_jerk.treadmill{button}{m}(7:12,4) ;y2=results_jerk.treadmill{button}{m}(7:12,2); idx = isfinite(x2) & isfinite(y2);
         try
             f2=fit(x2(idx),y2(idx),'poly1');
         catch
             display(['fitting error for participant ' , num2str(m)])
         end
         x3=results_jerk.treadmill{button}{m}(13:18,4) ;y3=results_jerk.treadmill{button}{m}(13:18,2); idx = isfinite(x3) & isfinite(y3);
         try
             f3=fit(x3(idx),y3(idx),'poly1');
         catch
             display(['fitting error for participant ' , num2str(m)])
         end
         subplot(2,2,button)
         plot(x1,y1,'r*',x2,y2,'bo',x3,y3,'gd')
        hold on
        grid on
        plot(f1,'r-');
        plot(f2,'b-');
        plot(f3,'g-');
        title(['Smartphone jerk - Bodyweight ', device{button}] );
        xlabel('Bodyweight [kg]');
        ylabel('Jerk smartphone [m/s^3]');
        legend('walking 5km/h','running 8km/h', 'running 12km/h')
     end
     
 end
 % Linear model
 button=2;
C=([results_jerk.treadmill{button}{1}(:,:);results_jerk.treadmill{button}{2}(:,:);results_jerk.treadmill{button}{3}(:,:);results_jerk.treadmill{button}{4}(:,:);results_jerk.treadmill{button}{5}(:,:);results_jerk.treadmill{button}{6}(:,:);results_jerk.treadmill{button}{7}(:,:);results_jerk.treadmill{button}{8}(:,:);results_jerk.treadmill{button}{9}(:,:);results_jerk.treadmill{button}{10}(:,:);results_jerk.treadmill{button}{11}(:,:);results_jerk.treadmill{button}{12}(:,:)]);
%   C(:,1)=log(C(:,1));
tbl= table(C(25:end,1),C(25:end,2),C(25:end,3),C(25:end,4),C(25:end,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
lme1=  fitlme(tbl,'JerkSmartphone~BW+(1|Participant)+(BW-1|Participant)');  % Mixed model with random effect intercept and coefficient 
lme2=  fitlme(tbl,'JerkSmartphone~BW+(1|Participant)');   % Mixed model with random effect intercept 
lme3=  fitlme(tbl,'JerkSmartphone~BW');                       % Mixed model without random effect intercept
 
 %% 2. Plots and model JerkSP-Speed
 % Plot
       figure;
 for button= 1:4

     for m=1:12
         x1=results_jerk.treadmill{button}{m}(1:6,3); y1=results_jerk.treadmill{button}{m}(1:6,2);idx = isfinite(x1) & isfinite(y1);
         try
             f1=fit(x1(idx),y1(idx),'poly1');
         catch
             display(['fitting error for participant ' , num2str(m)])
         end
         x2=results_jerk.treadmill{button}{m}(7:12,3) ;y2=results_jerk.treadmill{button}{m}(7:12,2); idx = isfinite(x2) & isfinite(y2);
         try
             f2=fit(x2(idx),y2(idx),'poly1');
         catch
             display(['fitting error for participant ' , num2str(m)])
         end
         x3=results_jerk.treadmill{button}{m}(13:18,3) ;y3=results_jerk.treadmill{button}{m}(13:18,2); idx = isfinite(x3) & isfinite(y3);
         try
             f3=fit(x3(idx),y3(idx),'poly1');
         catch
             display(['fitting error for participant ' , num2str(m)])
         end
         subplot(2,2,button)
         plot(x1,y1,'r*',x2,y2,'bo',x3,y3,'gd')
        hold on
       grid on
%         plot(f1,'r-');
%         plot(f2,'b-');
%         plot(f3,'g-');
        title(['Smartphone jerk - Speed ', device{button}] );
        xlabel('Speed [km/h]');
        ylabel('Jerk smartphone [m/s^3]');
        legend('walking 5km/h','running 8km/h', 'running 12km/h')
     end
     
 end
 % Linear model
 button=1;
C=([results_jerk.treadmill{button}{1}(:,:);results_jerk.treadmill{button}{2}(:,:);results_jerk.treadmill{button}{3}(:,:);results_jerk.treadmill{button}{4}(:,:);results_jerk.treadmill{button}{5}(:,:);results_jerk.treadmill{button}{6}(:,:);results_jerk.treadmill{button}{7}(:,:);results_jerk.treadmill{button}{8}(:,:);results_jerk.treadmill{button}{9}(:,:);results_jerk.treadmill{button}{10}(:,:);results_jerk.treadmill{button}{11}(:,:);results_jerk.treadmill{button}{12}(:,:)]);
%   C(:,1)=log(C(:,1));
tbl= table(C(25:end,1),C(25:end,2),C(25:end,3),C(25:end,4),C(25:end,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
lme1=  fitlme(tbl,'JerkSmartphone~Speed+(1|Participant)+(Speed-1|Participant)');  % Mixed model with random effect intercept and coefficient 
lme2=  fitlme(tbl,'JerkSmartphone~Speed+(1|Participant)');   % Mixed model with random effect intercept 
lme3=  fitlme(tbl,'JerkSmartphone~Speed');                       % Mixed model without random effect intercept
 
 %% 3. Plots and model JerkSP-ForceFP
  % Plot
        figure;
 for button= 1:4

     for m=1:12
         x1=results_grf.treadmill{button}{m}(1:6,1); y1=results_jerk.treadmill{button}{m}(1:6,2);idx = isfinite(x1) & isfinite(y1);
         try
             f1=fit(x1(idx),y1(idx),'poly1');
         catch
             display(['fitting error for participant ' , num2str(m)])
         end
         x2=results_grf.treadmill{button}{m}(7:12,1) ;y2=results_jerk.treadmill{button}{m}(7:12,2); idx = isfinite(x2) & isfinite(y2);
         try
             f2=fit(x2(idx),y2(idx),'poly1');
         catch
             display(['fitting error for participant ' , num2str(m)])
         end
         x3=results_grf.treadmill{button}{m}(13:18,1) ;y3=results_jerk.treadmill{button}{m}(13:18,2); idx = isfinite(x3) & isfinite(y3);
         try
             f3=fit(x3(idx),y3(idx),'poly1');
         catch
             display(['fitting error for participant ' , num2str(m)])
         end
         subplot(2,2,button)
         plot(x1,y1,'r*',x2,y2,'bo',x3,y3,'gd')
        hold on
                grid on
%         plot(f1,'r-');
%         plot(f2,'b-');
%         plot(f3,'g-');
        title(['Smartphone jerk - Ground reaction forces ', device{button}] );
        xlabel('Ground reaction force [N]');
        ylabel('Jerk smartphone [m/s^3]');
        legend('walking 5km/h','running 8km/h', 'running 12km/h')
     end
     
 end
 % Linear model
 button=1;
C=([results_jerk.treadmill{button}{1}(:,:);results_jerk.treadmill{button}{2}(:,:);results_jerk.treadmill{button}{3}(:,:);results_jerk.treadmill{button}{4}(:,:);results_jerk.treadmill{button}{5}(:,:);results_jerk.treadmill{button}{6}(:,:);results_jerk.treadmill{button}{7}(:,:);results_jerk.treadmill{button}{8}(:,:);results_jerk.treadmill{button}{9}(:,:);results_jerk.treadmill{button}{10}(:,:);results_jerk.treadmill{button}{11}(:,:);results_jerk.treadmill{button}{12}(:,:)]);
C(:,1)= ([results_grf.treadmill{button}{1}(:,1);results_grf.treadmill{button}{2}(:,1);results_grf.treadmill{button}{3}(:,1);results_grf.treadmill{button}{4}(:,1);results_grf.treadmill{button}{5}(:,1);results_grf.treadmill{button}{6}(:,1);results_grf.treadmill{button}{7}(:,1);results_grf.treadmill{button}{8}(:,1);results_grf.treadmill{button}{9}(:,1);results_grf.treadmill{button}{10}(:,1);results_grf.treadmill{button}{11}(:,1);results_grf.treadmill{button}{12}(:,1)]);
%   C(:,1)=log(C(:,1));
tbl= table(C(25:end,1),C(25:end,2),C(25:end,3),C(25:end,4),C(25:end,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
lme1=  fitlme(tbl,'JerkSmartphone~ForceRateFP+(1|Participant)+(ForceRateFP-1|Participant)');  % Mixed model with random effect intercept and coefficient 
lme2=  fitlme(tbl,'JerkSmartphone~ForceRateFP+(1|Participant)');   % Mixed model with random effect intercept 
lme3=  fitlme(tbl,'JerkSmartphone~ForceRateFP');                       % Mixed model without random effect intercept
 
%% 5. Plots and model JerkSP-JerkFP
% Plot
figure;
for button= 1:4
    
    for m=1:12
        x1=log(results_jerk.treadmill{button}{m}(1:6,1)); y1=results_jerk.treadmill{button}{m}(1:6,2);idx = isfinite(x1) & isfinite(y1);
        try
            f1=fit(x1(idx),y1(idx),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        x2=log(results_jerk.treadmill{button}{m}(7:12,1)) ;y2=results_jerk.treadmill{button}{m}(7:12,2); idx = isfinite(x2) & isfinite(y2);
        try
            f2=fit(x2(idx),y2(idx),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        x3=log(results_jerk.treadmill{button}{m}(13:18,1)) ;y3=results_jerk.treadmill{button}{m}(13:18,2); idx = isfinite(x3) & isfinite(y3);
        try
            f3=fit(x3(idx),y3(idx),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        subplot(2,2,button)
        hold on
        grid on
        plot(x1,y1,'r*',x2,y2,'bo',x3,y3,'gd')
        plot(f1,'r-');
        plot(f2,'b-');
        plot(f3,'g-');
        title(['Smartphone jerk - Jerk from ground reaction force ', device{button}] );
        xlabel('Jerk from ground reaction force [m/s^3]');
        ylabel('Jerk smartphone [m/s^3]');
        legend('walking 5km/h','running 8km/h', 'running 12km/h')
    end
    
end
% Linear model
button=1;
C=([results_jerk.treadmill{button}{1}(:,:);results_jerk.treadmill{button}{2}(:,:);results_jerk.treadmill{button}{3}(:,:);results_jerk.treadmill{button}{4}(:,:);results_jerk.treadmill{button}{5}(:,:);results_jerk.treadmill{button}{6}(:,:);results_jerk.treadmill{button}{7}(:,:);results_jerk.treadmill{button}{8}(:,:);results_jerk.treadmill{button}{9}(:,:);results_jerk.treadmill{button}{10}(:,:);results_jerk.treadmill{button}{11}(:,:);results_jerk.treadmill{button}{12}(:,:)]);
C(:,1)=log(C(:,1));
tbl= table(C(25:end,1),C(25:end,2),C(25:end,3),C(25:end,4),C(25:end,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
lme1=  fitlme(tbl,'JerkSmartphone~ForceRateFP+(1|Participant)+(ForceRateFP-1|Participant)');  % Mixed model with random effect intercept and coefficient
lme2=  fitlme(tbl,'JerkSmartphone~ForceRateFP+(1|Participant)');   % Mixed model with random effect intercept
lme3=  fitlme(tbl,'JerkSmartphone~ForceRateFP');                       % Mixed model without random effect intercept
%% 5. Plots and model LoadrateSP-LoadrateFP
% Plot
figure;
for button= 1:4
    
    for m=1:12
        x1=log(results_loadrate.treadmill{button}{m}(1:6,1)); y1=results_loadrate.treadmill{button}{m}(1:6,2);idx = isfinite(x1) & isfinite(y1);
        try
            f1=fit(x1(idx),y1(idx),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        x2=log(results_loadrate.treadmill{button}{m}(7:12,1)) ;y2=results_loadrate.treadmill{button}{m}(7:12,2); idx = isfinite(x2) & isfinite(y2);
        try
            f2=fit(x2(idx),y2(idx),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        x3=log(results_loadrate.treadmill{button}{m}(13:18,1)) ;y3=results_loadrate.treadmill{button}{m}(13:18,2); idx = isfinite(x3) & isfinite(y3);
        try
            f3=fit(x3(idx),y3(idx),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        subplot(2,2,button)
        hold on
        grid on
        plot(x1,y1,'r*',x2,y2,'bo',x3,y3,'gd')
%         plot(f1,'r-');
%         plot(f2,'b-');
%         plot(f3,'g-');
        title(['Smartphone loadrate - Force plate load rate ', device{button}] );
        xlabel('Load rate from ground reaction force [m/s^3]');
        ylabel('Load rate smartphone [m/s^3]');
        legend('walking 5km/h','running 8km/h', 'running 12km/h')
    end
    
end
% Linear model
button=1;
C=([results_loadrate.treadmill{button}{1}(:,:);results_loadrate.treadmill{button}{2}(:,:);results_loadrate.treadmill{button}{3}(:,:);results_loadrate.treadmill{button}{4}(:,:);results_loadrate.treadmill{button}{5}(:,:);results_loadrate.treadmill{button}{6}(:,:);results_loadrate.treadmill{button}{7}(:,:);results_loadrate.treadmill{button}{8}(:,:);results_loadrate.treadmill{button}{9}(:,:);results_loadrate.treadmill{button}{10}(:,:);results_loadrate.treadmill{button}{11}(:,:);results_loadrate.treadmill{button}{12}(:,:)]);
C(:,1)=log(C(:,1));
tbl= table(C(25:end,1),C(25:end,2),C(25:end,3),C(25:end,4),C(25:end,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
lme1=  fitlme(tbl,'JerkSmartphone~ForceRateFP+(1|Participant)+(ForceRateFP-1|Participant)');  % Mixed model with random effect intercept and coefficient
lme2=  fitlme(tbl,'JerkSmartphone~ForceRateFP+(1|Participant)');   % Mixed model with random effect intercept
lme3=  fitlme(tbl,'JerkSmartphone~ForceRateFP');                       % Mixed model without random effect intercept