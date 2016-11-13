%% Generating linear mixed model 
% 1.Plot each individual
% 2.Linear regression model with random effect and without random effect
% 3.Check significants of random effect
% 4.Compare fitlme with and without random effect
% 5. Generate the fitted conditional mean values for the model
% 6.Plot a histogram to visually confirm that the mean of the Pearson residuals is equal to 0
% 7.Plot the Pearson residuals versus the fitted values

load results_jerkpos
 %% 1.Plot each individual 
  device  = {'SP1' 'SW1' 'SP2' 'SW2'};
%  for n = 1:length(device)
%      filename = ['results_jerkpos.treadmill_' device{n}]  
for button= 1:4
    figure;
    for m= 1:12
        x1=log(results_jerkpos.treadmill{button}{m}(1:6,1)); y1=results_jerkpos.treadmill{button}{m}(1:6,2);idx = isfinite(x1) & isfinite(y1);
        try
            f1=fit(x1(idx),y1(idx),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        x2=log(results_jerkpos.treadmill{button}{m}(7:12,1)) ;y2=results_jerkpos.treadmill{button}{m}(7:12,2); idx = isfinite(x2) & isfinite(y2);
        try
            f2=fit(x2(idx),y2(idx),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        x3=log(results_jerkpos.treadmill{button}{m}(13:18,1)) ;y3=results_jerkpos.treadmill{button}{m}(13:18,2); idx = isfinite(x3) & isfinite(y3);
        try
            f3=fit(x3(idx),y3(idx),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        
        subplot(3,4,m)
        text(.75,1.25,'Smartphone jerk and ground reaction force jerk')
        plot(x1,y1,'*',x2,y2,'o',x3,y3,'p')
        hold on
        plot(f1,'-');
        plot(f2,'-');
        plot(f3,'-');
        title(['Participants ', num2str(m), device{button}] );
        xlabel('Jerk forceplate [m/s^3]');
        ylabel('Jerk smartphone [m/s^3]');
        legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');
    end
%     filename= (['jerk_pos_',device{button}, '.pdf']);
% print(filename,'-dpdf')
end

 
%%  Linear mixedmodel
% 1.Plot Forceplate data versus the jerk estimate
button=2;
C=([results_jerkpos.treadmill{button}{1}(:,:);results_jerkpos.treadmill{button}{2}(:,:);results_jerkpos.treadmill{button}{3}(:,:);results_jerkpos.treadmill{button}{4}(:,:);results_jerkpos.treadmill{button}{5}(:,:);results_jerkpos.treadmill{button}{6}(:,:);results_jerkpos.treadmill{button}{7}(:,:);results_jerkpos.treadmill{button}{8}(:,:);results_jerkpos.treadmill{button}{9}(:,:);results_jerkpos.treadmill{button}{10}(:,:);results_jerkpos.treadmill{button}{11}(:,:);results_jerkpos.treadmill{button}{12}(:,:)]);
C(:,1)=log(C(:,1));
figure;
plot(C(:,2),C(:,1),'ro')
xlabel('Jerk smartphone [m/s^3]')
ylabel('Jerk forceplate [m/s^3]');

% 2.Linear regression model with random effect and without random effect
tbl= table(C(25:end,1),C(25:end,2),C(25:end,3),C(25:end,4),C(25:end,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
lme1=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW+(1|Participant)+(JerkSmartphone-1|Participant)');  % Mixed model with random effect intercept and coefficient 
lme2=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW+(1|Participant)');   % Mixed model with random effect intercept 
lme3=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW');                       % Mixed model without random effect intercept

% 3.Check significants of random effect
[psi,dispersion,stats] = covarianceParameters(lme1);

% 4.Compare fitlme with and without random effect 
comp_res = compare(lme2,lme1,'CheckNesting',true);

% 5. Generate the fitted conditional mean values for the model 
mufit = fitted(lme1);
figure
scatter(tbl.JerkSmartphone,mufit)
title('Observed Values versus Fitted Values')
xlabel('Fitted Values')
ylabel('Observed Values')

% 6.Plot a histogram to visually confirm that the mean of the Pearson residuals is equal to 0
figure
plotResiduals(lme1,'histogram','ResidualType','Pearson')

% 7.Plot the Pearson residuals versus the fitted values
figure
plotResiduals(lme1,'fitted','ResidualType','Pearson')
%% Dynamic search for Outliers 
% Looking at the fit 
x= residuals(lme1);

figure;
F = fitted(lme1);
R = response(lme1);
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')

% Find the assumed outliers 
find(residuals(lme1) < -120);
find(residuals(lme1) >  120);

% Exclud the outliers
lme1=  fitlme(tbl,'ForceRateFP~JerkSmartphone^2+Speed+BW+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[ 64,66,100,102,157,163,168,169,37,43,61,62,63,97,103,109,110,115,164,166]);  % Mixed model with random effect intercept and coefficient 
lme2=  fitlme(tbl,'ForceRateFP~JerkSmartphone^2+Speed+BW+(1|Participant)','Exclude',[64,66,100,102,157,163,168,169,37,43,61,62,63,97,103,109,110,115,164,166]);   % Mixed model with random effect intercept 

% Compare the fit wihout outliers
figure;
F = fitted(lme1);
R = response(lme1);
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')

figure();
plotResiduals(lme1,'fitted')

%% Results
% SP1: 
% % Find the assumed outliers 
%find(residuals(lme1) < -170);
% find(residuals(lme1) >  170);
% %Exclud the outliers
% lme1=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[164,166,168]);  % Mixed model with random effect intercept and coefficient 
% lme2=  fitlme(tbl,'ForceRateFP~JerkSmartphone^2+Speed+BW+(1|Participant)','Exclude',[164,166,168]);   % Mixed model with random effect intercept 

%SW1:
% % Find the assumed outliers 
% find(residuals(lme1) < -140);
% find(residuals(lme1) >  140);
% 
% % Exclud the outliers
% lme1=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[139,151,164,166]);  % Mixed model with random effect intercept and coefficient 
% lme2=  fitlme(tbl,'ForceRateFP~JerkSmartphone^2+Speed+BW+(1|Participant)','Exclude',[139,151,164,166]);   % Mixed model with random effect intercept 

%SP2:
% % Find the assumed outliers 
% find(residuals(lme1) < -120);
% find(residuals(lme1) >  120);
% 
% % Exclud the outliers
% lme1=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[ 64,66,100,102,157,163,168,169,37,43,61,62,97,103,109,110,115,164,166]);  % Mixed model with random effect intercept and coefficient 
% lme2=  fitlme(tbl,'ForceRateFP~JerkSmartphone^2+Speed+BW+(1|Participant)','Exclude',[ 64,66,100,102,157,163,168,169,37,43,61,62,97,103,109,110,115,164,166]);   % Mixed model with random effect intercept 

%SW2:
% % Find the assumed outliers 
% find(residuals(lme1) < -120);
% find(residuals(lme1) >  120);
% 
% % Exclud the outliers
% lme1=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[ 64,66,100,102,157,163,168,169,37,43,61,62,63,97,103,109,110,115,164,166]);  % Mixed model with random effect intercept and coefficient 
% lme2=  fitlme(tbl,'ForceRateFP~JerkSmartphone^2+Speed+BW+(1|Participant)','Exclude',[ 64,66,100,102,157,163,168,169,37,43,61,62,97,103,109,110,115,164,166]);   % Mixed model with random effect intercept 
% 
%% Predict values
yfit=predict(lme2,tbl);

