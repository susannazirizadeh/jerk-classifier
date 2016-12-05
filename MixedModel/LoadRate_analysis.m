%% Realtion of LoadrateSP-LoadrateFP 
load results_loadrate
device  = {'SP1' 'SW1' 'SP2' 'SW2'};
%% Plots 
  figure;
for button= 1:4
    
    for m=2:12
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

%% Linear model
% 2.Linear regression model with random effect and without random effect
button=1;
C=([results_loadrate.treadmill{button}{1}(:,:);results_loadrate.treadmill{button}{2}(:,:);results_loadrate.treadmill{button}{3}(:,:);results_loadrate.treadmill{button}{4}(:,:);results_loadrate.treadmill{button}{5}(:,:);results_loadrate.treadmill{button}{6}(:,:);results_loadrate.treadmill{button}{7}(:,:);results_loadrate.treadmill{button}{8}(:,:);results_loadrate.treadmill{button}{9}(:,:);results_loadrate.treadmill{button}{10}(:,:);results_loadrate.treadmill{button}{11}(:,:);results_loadrate.treadmill{button}{12}(:,:)]);
tbl= table(C(25:end,1),C(25:end,2),C(25:end,3),C(25:end,4),C(25:end,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
lme1=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW+(1|Participant)+(JerkSmartphone-1|Participant)');  % Mixed model with random effect intercept and coefficient 
lme2=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW+(1|Participant)');   % Mixed model with random effect intercept 
lme3=  fitlme(tbl,'ForceRateFP~JerkSmartphone+Speed+BW');                       % Mixed model without random effect intercept

C5=([results_loadrate.treadmill{button}{3}(1:5,:);results_loadrate.treadmill{button}{4}(1:5,:);results_loadrate.treadmill{button}{5}(1:5,:);results_loadrate.treadmill{button}{6}(1:5,:);results_loadrate.treadmill{button}{7}(1:5,:);results_loadrate.treadmill{button}{8}(1:5,:);results_loadrate.treadmill{button}{9}(1:5,:);results_loadrate.treadmill{button}{10}(1:5,:);results_loadrate.treadmill{button}{11}(1:5,:);results_loadrate.treadmill{button}{12}(1:5,:)]);
C8=([results_loadrate.treadmill{button}{2}(7:12,:);results_loadrate.treadmill{button}{3}(7:12,:);results_loadrate.treadmill{button}{4}(7:12,:);results_loadrate.treadmill{button}{5}(7:12,:);results_loadrate.treadmill{button}{6}(7:12,:);results_loadrate.treadmill{button}{7}(7:12,:);results_loadrate.treadmill{button}{8}(7:12,:);results_loadrate.treadmill{button}{9}(7:12,:);results_loadrate.treadmill{button}{10}(7:12,:);results_loadrate.treadmill{button}{11}(7:12,:);results_loadrate.treadmill{button}{12}(7:12,:)]);
C12=([results_loadrate.treadmill{button}{2}(13:18,:);results_loadrate.treadmill{button}{3}(13:18,:);results_loadrate.treadmill{button}{4}(13:18,:);results_loadrate.treadmill{button}{5}(13:18,:);results_loadrate.treadmill{button}{6}(13:18,:);results_loadrate.treadmill{button}{7}(13:18,:);results_loadrate.treadmill{button}{8}(13:18,:);results_loadrate.treadmill{button}{9}(13:18,:);results_loadrate.treadmill{button}{10}(13:18,:);results_loadrate.treadmill{button}{11}(13:18,:);results_loadrate.treadmill{button}{12}(13:18,:)]);
tbl5= table(C5(:,1),C5(:,2),C5(:,3),C5(:,4),C5(:,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
tbl8= table(C8(:,1),C8(:,2),C8(:,3),C8(:,4),C8(:,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
tbl12= table(C12(:,1),C12(:,2),C12(:,3),C12(:,4),C12(:,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
lme1_5=  fitlme(tbl5,'JerkSmartphone~ForceRateFP+(1|Participant)+(ForceRateFP-1|Participant)');  % Mixed model with random effect intercept and coefficient
lme2_5=  fitlme(tbl5,'JerkSmartphone~ForceRateFP+(1|Participant)');   % Mixed model with random effect intercept
lme3_5=  fitlme(tbl5,'JerkSmartphone~ForceRateFP');                       % Mixed model without random effect intercept

lme1_8=  fitlme(tbl8,'JerkSmartphone~ForceRateFP+(1|Participant)+(ForceRateFP-1|Participant)');  % Mixed model with random effect intercept and coefficient
lme2_8=  fitlme(tbl8,'JerkSmartphone~ForceRateFP+(1|Participant)');   % Mixed model with random effect intercept
lme3_8=  fitlme(tbl8,'JerkSmartphone~ForceRateFP');                       % Mixed model without random effect intercept

lme1_12=  fitlme(tbl12,'JerkSmartphone~ForceRateFP+(1|Participant)+(ForceRateFP-1|Participant)');  % Mixed model with random effect intercept and coefficient
lme2_12=  fitlme(tbl12,'JerkSmartphone~ForceRateFP+(1|Participant)');   % Mixed model with random effect intercept
lme3_12=  fitlme(tbl12,'JerkSmartphone~ForceRateFP');                       % Mixed model without random effect intercept
%% Dynamic search for Outliers for 5km/h
% Looking at the fit fro 
x= residuals(lme1_5);

% Plot the Pearson residuals versus the fitted values
figure;
plotResiduals(lme1_5,'fitted','ResidualType','Pearson');

figure;
F = fitted(lme1_5);
R = response(lme1_5);
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')

% Find the assumed outliers 
find(residuals(lme1_5) < -1500);
find(residuals(lme1_5) >  1500);

% Exclud the outliers
lme1_5=  fitlme(tbl5,'ForceRateFP~JerkSmartphone+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[21,31]);  % Mixed model with random effect intercept and coefficient 
lme2_5=  fitlme(tbl5,'ForceRateFP~JerkSmartphone+(1|Participant)','Exclude',[21,31]);   % Mixed model with random effect intercept 

% Compare the fit wihout outliers
figure;
F = fitted(lme1_5);
R = response(lme1_5);
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')

figure();
plotResiduals(lme1_5,'fitted')

%% Dynamic search for Outliers for 8km/h
% Looking at the fit fro 
x= residuals(lme1_8);

% Plot the Pearson residuals versus the fitted values
figure;
plotResiduals(lme1_8,'fitted','ResidualType','Pearson');

figure;
F = fitted(lme1_8);
R = response(lme1_8);
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')

% Find the assumed outliers 
find(residuals(lme1_8) < -7000);
find(residuals(lme1_8) >  7000);

% Exclud the outliers
lme1_8=  fitlme(tbl8,'ForceRateFP~JerkSmartphone+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[3,6,55]);  % Mixed model with random effect intercept and coefficient 
lme2_8=  fitlme(tbl8,'ForceRateFP~JerkSmartphone+(1|Participant)','Exclude',[3,6,55]);   % Mixed model with random effect intercept 

% Compare the fit wihout outliers
figure;
F = fitted(lme1_8);
R = response(lme1_8);
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')

figure();
plotResiduals(lme1_8,'fitted')

%% Dynamic search for Outliers for 12km/h
% Looking at the fit fro 
x= residuals(lme1_12);

% Plot the Pearson residuals versus the fitted values
figure;
plotResiduals(lme1_12,'fitted','ResidualType','Pearson');

figure;
F = fitted(lme1_12);
R = response(lme1_12);
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')

% Find the assumed outliers 
find(residuals(lme1_12) < -3000);
find(residuals(lme1_12) >  3000);

% Exclud the outliers
lme1_12=  fitlme(tbl12,'ForceRateFP~JerkSmartphone+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[19]);  % Mixed model with random effect intercept and coefficient 
lme2_12=  fitlme(tbl12,'ForceRateFP~JerkSmartphone+(1|Participant)','Exclude',[19]);   % Mixed model with random effect intercept 

% Compare the fit wihout outliers
figure;
F = fitted(lme1_12);
R = response(lme1_12);
plot(R,F,'rx')
xlabel('Response')
ylabel('Fitted')

figure();
plotResiduals(lme1_12,'fitted')

%% Leave-one-out Cross validation
error5=zeros(50,1);
sum5_1=zeros(50,1);
sum5_2=zeros(50,1);
for i=1:50
    lme1_5=  fitlme(tbl5,'ForceRateFP~JerkSmartphone+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[i]);
    F=predict(lme1_5,tbl5);
    error5(i,1)=(F(i,1)-tbl5.ForceRateFP(i,1)).^2;
    sum5_1(i,1)=(tbl5.ForceRateFP(i,1) -F(i,1)).^2;
    sum5_2(i,1)=(tbl5.ForceRateFP(i,1) - nanmean(tbl5.ForceRateFP(:,1))).^2;
end 

error8=zeros(66,1);
sum8_1=zeros(66,1);
sum8_2=zeros(66,1);
for i=1:66
    lme1_8=  fitlme(tbl8,'ForceRateFP~JerkSmartphone+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[i]);
    F=predict(lme1_8,tbl8);
    error8(i,1)=(F(i,1)-tbl8.ForceRateFP(i,1)).^2;
    sum8_1(i,1)=(tbl8.ForceRateFP(i,1) -F(i,1)).^2;
    sum8_2(i,1)=(tbl8.ForceRateFP(i,1) - nanmean(tbl8.ForceRateFP(:,1))).^2;
end 

error12=zeros(66,1);
sum12_1=zeros(66,1);
sum12_2=zeros(66,1);
for i=1:66
    lme1_12=  fitlme(tbl12,'ForceRateFP~JerkSmartphone+(1|Participant)+(JerkSmartphone-1|Participant)','Exclude',[i]);
    F=predict(lme1_12,tbl12);
    error12(i,1)=(F(i,1)-tbl12.ForceRateFP(i,1)).^2;
    sum12_1(i,1)=(tbl12.ForceRateFP(i,1) -F(i,1)).^2;
    sum12_2(i,1)=(tbl12.ForceRateFP(i,1) - nanmean(tbl12.ForceRateFP(:,1))).^2;
end 


%%
stats=zeros(3,5);
stats(1,1)= lme1_5.Rsquared.Ordinary;
stats(2,1)= lme1_8.Rsquared.Ordinary;
stats(3,1)= lme1_12.Rsquared.Ordinary;
stats(1,2)= lme1_5.MSE;
stats(2,2)= lme1_8.MSE;
stats(3,2)= lme1_12.MSE;
stats(1,3)=  1 - (nansum(sum5_1)/nansum(sum5_2));
stats(2,3)= 1 - (nansum(sum8_1)/nansum(sum8_2));
stats(3,3)= 1 - (nansum(sum12_1)/nansum(sum12_2));
stats(1,4)= nanmean(error5);
stats(2,4)= nanmean(error8);
stats(3,4)= nanmean(error12);
stats(1,5)= nanstd(error5);
stats(2,5)= nanstd(error8);
stats(3,5)= nanstd(error12);
