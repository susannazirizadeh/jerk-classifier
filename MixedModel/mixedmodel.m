%% Generating linear mixed model 
% 1.Plot each individual
% 2.Linear regression model with random effect and without random effect
% 3.Check significants of random effect
% 4.Compare fitlme with and without random effect
% 5. Generate the fitted conditional mean values for the model
% 6.Plot a histogram to visually confirm that the mean of the Pearson residuals is equal to 0
% 7.Plot the Pearson residuals versus the fitted values

load results_grf_all
button= 4; % Switch the button for 1= Smartphone1, 2= Smartwatch1, 3=Smartphone2, 4=Smartwatch2
 %% 1.Plot each individual 
%  device  = {'SP1' 'SW1' 'SP2' 'SW2'};
%  for n = 1:length(device)
%      filename = ['results_grf_' device{n}]    
f1_1=fit(results_grf{button}{1}(1:6,1),results_grf{button}{1}(1:6,2),'poly1');
f1_2=fit(results_grf{button}{1}(7:12,1),results_grf{button}{1}(7:12,2),'poly1');
f1_3=fit(results_grf{button}{1}(13:18,1),results_grf{button}{1}(13:18,2),'poly1');
f2_1=fit(results_grf{button}{2}(1:6,1),results_grf{button}{2}(1:6,2),'poly1');
f2_2=fit(results_grf{button}{2}(7:12,1),results_grf{button}{2}(7:12,2),'poly1');
f2_3=fit(results_grf{button}{2}(13:18,1),results_grf{button}{2}(13:18,2),'poly1');
 f3_1=fit(results_grf{button}{3}(1:6,1),results_grf{button}{3}(1:6,2),'poly1');
f3_2=fit(results_grf{button}{3}(7:12,1),results_grf{button}{3}(7:12,2),'poly1');
f3_3=fit(results_grf{button}{3}(13:18,1),results_grf{button}{3}(13:18,2),'poly1');
 f4_1=fit(results_grf{button}{4}(1:6,1),results_grf{button}{4}(1:6,2),'poly1');
f4_2=fit(results_grf{button}{4}(7:12,1),results_grf{button}{4}(7:12,2),'poly1');
f4_3=fit(results_grf{button}{4}(13:18,1),results_grf{button}{4}(13:18,2),'poly1');
f5_1=fit(results_grf{button}{5}(1:6,1),results_grf{button}{5}(1:6,2),'poly1');
f5_2=fit(results_grf{button}{5}(7:12,1),results_grf{button}{5}(7:12,2),'poly1');
f5_3=fit(results_grf{button}{5}(13:18,1),results_grf{button}{5}(13:18,2),'poly1');
f6_1=fit(results_grf{button}{6}(1:6,1),results_grf{button}{6}(1:6,2),'poly1');
f6_2=fit(results_grf{button}{6}(7:12,1),results_grf{button}{6}(7:12,2),'poly1');
f6_3=fit(results_grf{button}{6}(13:18,1),results_grf{button}{6}(13:18,2),'poly1');
f7_1=fit(results_grf{button}{7}(1:6,1),results_grf{button}{7}(1:6,2),'poly1');
f7_2=fit(results_grf{button}{7}(7:12,1),results_grf{button}{7}(7:12,2),'poly1');
f7_3=fit(results_grf{button}{7}(13:18,1),results_grf{button}{7}(13:18,2),'poly1');
f8_1=fit(results_grf{button}{8}(1:6,1),results_grf{button}{8}(1:6,2),'poly1');
f8_2=fit(results_grf{button}{8}(7:12,1),results_grf{button}{8}(7:12,2),'poly1');
f8_3=fit(results_grf{button}{8}(13:18,1),results_grf{button}{8}(13:18,2),'poly1');
  f9_1=fit(results_grf{button}{9}(1:6,1),results_grf{button}{9}(1:6,2),'poly1');
f9_2=fit(results_grf{button}{9}(7:12,1),results_grf{button}{9}(7:12,2),'poly1');
f9_3=fit(results_grf{button}{9}(13:18,1),results_grf{button}{9}(13:18,2),'poly1');
f10_1=fit(results_grf{button}{10}(1:6,1),results_grf{button}{10}(1:6,2),'poly1');
f10_2=fit(results_grf{button}{10}(7:12,1),results_grf{button}{10}(7:12,2),'poly1');
f10_3=fit(results_grf{button}{10}(13:18,1),results_grf{button}{10}(13:18,2),'poly1');
f11_1=fit(results_grf{button}{11}(1:6,1),results_grf{button}{10}(1:6,2),'poly1');
% f11_2=fit(results_grf{button}{11}(7:12,1),results_grf{button}{11}(7:12,2),'poly1');
f11_3=fit(results_grf{button}{11}(13:18,1),results_grf{button}{1}(13:18,2),'poly1');
f12_1=fit(results_grf{button}{12}(1:6,1),results_grf{button}{12}(1:6,2),'poly1');
% f12_2=fit(results_grf{button}{12}(7:12,1),results_grf{button}{12}(7:12,2),'poly1');
% f12_3=fit(results_grf{button}{12}(13:18,1),results_grf{button}{12}(13:18,2),'poly1');
 
 figure
subplot(3,4,1)
text(.75,1.25,'Smartphone jerk and ground reaction force')
plot(results_grf{button}{1}(1:6,1),results_grf{button}{1}(1:6,2),'*',results_grf{button}{1}(7:12,1),results_grf{button}{1}(7:12,2),'o',results_grf{button}{1}(13:18,1),results_grf{button}{1}(13:18,2),'p')
hold on 
plot(f1_1,'-');
plot(f1_2,'-');
plot(f1_3,'-');
title('Participants 1');
xlabel('Forceplate Data [N]');
ylabel('Jerk Data from smartphone [m/s^3]');
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,2)
plot(results_grf{button}{2}(1:6,1),results_grf{button}{2}(1:6,2),'*',results_grf{button}{2}(7:12,1),results_grf{button}{2}(7:12,2),'o',results_grf{button}{2}(13:18,1),results_grf{button}{2}(13:18,2),'p')
hold on 
plot(f2_1,'-');
plot(f2_2,'-');
plot(f2_3,'-');
title('Participants 2')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,3)
plot(results_grf{button}{3}(1:6,1),results_grf{button}{3}(1:6,2),'*',results_grf{button}{3}(7:12,1),results_grf{button}{3}(7:12,2),'o',results_grf{button}{3}(13:18,1),results_grf{button}{3}(13:18,2),'p')
hold on 
plot(f3_1,'-');
plot(f3_2,'-');
plot(f3_3,'-');
title('Participants 3')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,4)
plot(results_grf{button}{4}(1:6,1),results_grf{button}{4}(1:6,2),'*',results_grf{button}{4}(7:12,1),results_grf{button}{4}(7:12,2),'o',results_grf{button}{4}(13:18,1),results_grf{button}{4}(13:18,2),'p')
hold on 
plot(f4_1,'-');
plot(f4_2,'-');
plot(f4_3,'-');
title('Participants 4')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,5)
plot(results_grf{button}{5}(1:6,1),results_grf{button}{5}(1:6,2),'*',results_grf{button}{5}(7:12,1),results_grf{button}{5}(7:12,2),'o',results_grf{button}{5}(13:18,1),results_grf{button}{5}(13:18,2),'p')
hold on 
plot(f5_1,'-');
plot(f5_2,'-');
plot(f5_3,'-');
title('Participants 5')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,6)
plot(results_grf{button}{6}(1:6,1),results_grf{button}{6}(1:6,2),'*',results_grf{button}{6}(7:12,1),results_grf{button}{6}(7:12,2),'o',results_grf{button}{6}(13:18,1),results_grf{button}{6}(13:18,2),'p')
hold on 
plot(f6_1,'-');
plot(f6_2,'-');
plot(f6_3,'-');
title('Participants 6')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');


subplot(3,4,7)
plot(results_grf{button}{7}(1:6,1),results_grf{button}{7}(1:6,2),'*',results_grf{button}{7}(7:12,1),results_grf{button}{7}(7:12,2),'o',results_grf{button}{7}(13:18,1),results_grf{button}{7}(13:18,2),'p')
hold on 
plot(f7_1,'-');
plot(f7_2,'-');
plot(f7_3,'-');
title('Participants 7')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,8)
plot(results_grf{button}{8}(1:6,1),results_grf{button}{8}(1:6,2),'*',results_grf{button}{8}(7:12,1),results_grf{button}{8}(7:12,2),'o',results_grf{button}{8}(13:18,1),results_grf{button}{8}(13:18,2),'p')
hold on 
plot(f8_1,'-');
plot(f8_2,'-');
plot(f8_3,'-');
title('Participants 8')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,9)
plot(results_grf{button}{9}(1:6,1),results_grf{button}{9}(1:6,2),'*',results_grf{button}{9}(7:12,1),results_grf{button}{9}(7:12,2),'o',results_grf{button}{9}(13:18,1),results_grf{button}{9}(13:18,2),'p')
hold on 
plot(f9_1,'-');
plot(f9_2,'-');
plot(f9_3,'-');
title('Participants 9')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,10)
plot(results_grf{button}{10}(1:6,1),results_grf{button}{10}(1:6,2),'*',results_grf{button}{10}(7:12,1),results_grf{button}{10}(7:12,2),'o',results_grf{button}{10}(13:18,1),results_grf{button}{10}(13:18,2),'p')
hold on 
plot(f10_1,'-');
plot(f10_2,'-');
plot(f10_3,'-');
title('Participants 10')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,11)
plot(results_grf{button}{11}(1:6,1),results_grf{button}{11}(1:6,2),'*',results_grf{button}{11}(7:12,1),results_grf{button}{11}(7:12,2),'o',results_grf{button}{11}(13:18,1),results_grf{button}{11}(13:18,2),'p')
hold on 
plot(f11_1,'-');
% plot(f11_2,'-');
plot(f11_3,'-');
title('Participants 11')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

subplot(3,4,12)
plot(results_grf{button}{12}(1:6,1),results_grf{button}{12}(1:6,2),'*',results_grf{button}{12}(7:12,1),results_grf{button}{12}(7:12,2),'o',results_grf{button}{12}(13:18,1),results_grf{button}{12}(13:18,2),'p')
hold on 
plot(f12_1,'-');
% plot(f12_2,'-');
% plot(f12_3,'-');
title('Participants 12')
xlabel('Forceplate Data [N]')
ylabel('Jerk Data from smartphone [m/s^3]')
legend ('Data points 5km/h','Data points 8km/h','Data points 12km/h','Location','northwest');

filename= ('jerk_SP1_FP_each_SW2.pdf');
print(filename,'-dpdf')
 
%%  
% 1.Plot Forceplate data versus the jerk estimate

C=([results_grf{button}{1}(:,:);results_grf{button}{2}(:,:);results_grf{button}{3}(:,:);results_grf{button}{4}(:,:);results_grf{button}{5}(:,:);results_grf{button}{6}(:,:);results_grf{button}{7}(:,:);results_grf{button}{8}(:,:);results_grf{button}{9}(:,:);results_grf{button}{10}(:,:);results_grf{button}{11}(:,:);results_grf{button}{12}(:,:)]);
figure;
plot(C(:,2),C(:,1),'ro')
xlabel('Estimated Jerk from smartphone [m/s^3]')
ylabel('Forceplate Data [N]')

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

