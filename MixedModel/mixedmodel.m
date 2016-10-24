%% Generating linear mixed model 
% 1.Plot each individual
% 2.Linear regression model with random effect and without random effect
% 3.Check significants of random effect
% 4.Compare fitlme with and without random effect
% 5. Generate the fitted conditional mean values for the model
% 6.Plot a histogram to visually confirm that the mean of the Pearson residuals is equal to 0
% 7.Plot the Pearson residuals versus the fitted values
 load results 
 
 %% 1.Plot each individual 
     
 f1_1=fit(results{1}(1:6,1),results{1}(1:6,2),'poly1');
 f1_2=fit(results{1}(7:12,1),results{1}(7:12,2),'poly1');
 f1_3=fit(results{1}(13:18,1),results{1}(13:18,2),'poly1');
 f2_1=fit(results{2}(1:6,1),results{2}(1:6,2),'poly1');
  f2_2=fit(results{2}(7:12,1),results{2}(7:12,2),'poly1');
 f2_3=fit(results{2}(13:18,1),results{2}(13:18,2),'poly1');
 f3_1=fit(results{3}(1:6,1),results{3}(1:6,2),'poly1');
  f3_2=fit(results{3}(7:12,1),results{3}(7:12,2),'poly1');
 f3_3=fit(results{3}(13:18,1),results{3}(13:18,2),'poly1');
 %f4_1=fit(results{4}(1:6,1),results{4}(1:6,2),'poly1');
  f4_2=fit(results{4}(7:12,1),results{4}(7:12,2),'poly1');
 f4_3=fit(results{4}(13:18,1),results{4}(13:18,2),'poly1');
 f5_1=fit(results{5}(1:6,1),results{5}(1:6,2),'poly1');
  f5_2=fit(results{5}(7:12,1),results{5}(7:12,2),'poly1');
 f5_3=fit(results{5}(13:18,1),results{5}(13:18,2),'poly1');
 f6_1=fit(results{6}(1:6,1),results{6}(1:6,2),'poly1');
  f6_2=fit(results{6}(7:12,1),results{6}(7:12,2),'poly1');
 f6_3=fit(results{6}(13:18,1),results{6}(13:18,2),'poly1');
 f7_1=fit(results{7}(1:6,1),results{7}(1:6,2),'poly1');
  f7_2=fit(results{7}(7:12,1),results{7}(7:12,2),'poly1');
 f7_3=fit(results{7}(13:18,1),results{7}(13:18,2),'poly1');
 f8_1=fit(results{8}(1:6,1),results{8}(1:6,2),'poly1');
  f8_2=fit(results{8}(7:12,1),results{8}(7:12,2),'poly1');
 f8_3=fit(results{8}(13:18,1),results{8}(13:18,2),'poly1');
%  f9_1=fit(results{9}(1:6,1),results{9}(1:6,2),'poly1');
   f9_2=fit(results{9}(7:12,1),results{9}(7:12,2),'poly1');
 f9_3=fit(results{9}(13:18,1),results{9}(13:18,2),'poly1');
 f10_1=fit(results{10}(1:6,1),results{10}(1:6,2),'poly1');
   f10_2=fit(results{10}(7:12,1),results{10}(7:12,2),'poly1');
 f10_3=fit(results{10}(13:18,1),results{10}(13:18,2),'poly1');
 f11_1=fit(results{11}(1:6,1),results{10}(1:6,2),'poly1');
   f11_2=fit(results{11}(7:12,1),results{11}(7:12,2),'poly1');
 f11_3=fit(results{11}(13:18,1),results{1}(13:18,2),'poly1');
%  f12_1=fit(results{12}(1:6,1),results{12}(1:6,2),'poly1');
%    f12_2=fit(results{12}(7:12,1),results{12}(7:12,2),'poly1');
%  f12_3=fit(results{12}(13:18,1),results{12}(13:18,2),'poly1');
 
 figure
subplot(3,4,1)
text(.75,1.25,'Smartphone jerk and ground reaction force')
plot(results{1}(1:6,1),results{1}(1:6,2),'*',results{1}(7:12,1),results{1}(7:12,2),'o',results{1}(13:18,1),results{1}(13:18,2),'p')
hold on 
plot(f1_1,'-');
hold on
plot(f1_2,'-');
hold on
plot(f1_3,'-');
title('Participants 1')

subplot(3,4,2)
plot(results{2}(1:6,1),results{2}(1:6,2),'*',results{2}(7:12,1),results{2}(7:12,2),'o',results{2}(13:18,1),results{2}(13:18,2),'p')
hold on 
plot(f2_1,'-');
hold on
plot(f2_2,'-');
hold on
plot(f2_3,'-');
title('Participants 2')

subplot(3,4,3)
plot(results{3}(1:6,1),results{3}(1:6,2),'*',results{3}(7:12,1),results{3}(7:12,2),'o',results{3}(13:18,1),results{3}(13:18,2),'p')
hold on 
plot(f3_1,'-');
hold on
plot(f3_2,'-');
hold on
plot(f3_3,'-');
title('Participants 3')

subplot(3,4,4)
plot(results{4}(1:6,1),results{4}(1:6,2),'*',results{4}(7:12,1),results{4}(7:12,2),'o',results{4}(13:18,1),results{4}(13:18,2),'p')
hold on 
% plot(f4_1,'-');
% hold on
plot(f4_2,'-');
hold on
plot(f4_3,'-');
title('Participants 4')

subplot(3,4,5)
plot(results{5}(1:6,1),results{5}(1:6,2),'*',results{5}(7:12,1),results{5}(7:12,2),'o',results{5}(13:18,1),results{5}(13:18,2),'p')
hold on 
plot(f5_1,'-');
hold on
plot(f5_2,'-');
hold on
plot(f5_3,'-');
title('Participants 5')

subplot(3,4,6)
plot(results{6}(1:6,1),results{6}(1:6,2),'*',results{6}(7:12,1),results{6}(7:12,2),'o',results{6}(13:18,1),results{6}(13:18,2),'p')
hold on 
plot(f6_1,'-');
hold on
plot(f6_2,'-');
hold on
plot(f6_3,'-');
title('Participants 6')

subplot(3,4,7)
plot(results{7}(1:6,1),results{7}(1:6,2),'*',results{7}(7:12,1),results{7}(7:12,2),'o',results{7}(13:18,1),results{7}(13:18,2),'p')
hold on 
plot(f7_1,'-');
hold on
plot(f7_2,'-');
hold on
plot(f7_3,'-');
title('Participants 7')

subplot(3,4,8)
plot(results{8}(1:6,1),results{8}(1:6,2),'*',results{8}(7:12,1),results{8}(7:12,2),'o',results{8}(13:18,1),results{8}(13:18,2),'p')
hold on 
plot(f8_1,'-');
hold on
plot(f8_2,'-');
hold on
plot(f8_3,'-');
title('Participants 8')

subplot(3,4,9)
plot(results{9}(1:6,1),results{9}(1:6,2),'*',results{9}(7:12,1),results{9}(7:12,2),'o',results{9}(13:18,1),results{9}(13:18,2),'p')
hold on 
% plot(f9_1,'-');
% hold on
plot(f9_2,'-');
hold on
plot(f9_3,'-');
title('Participants 9')

subplot(3,4,10)
plot(results{10}(1:6,1),results{10}(1:6,2),'*',results{10}(7:12,1),results{10}(7:12,2),'o',results{10}(13:18,1),results{10}(13:18,2),'p')
hold on 
plot(f10_1,'-');
hold on
plot(f10_2,'-');
hold on
plot(f10_3,'-');
title('Participants 10')

subplot(3,4,11)
plot(results{11}(1:6,1),results{11}(1:6,2),'*',results{11}(7:12,1),results{11}(7:12,2),'o',results{11}(13:18,1),results{11}(13:18,2),'p')
hold on 
plot(f11_1,'-');
hold on
plot(f11_2,'-');
hold on
plot(f11_3,'-');
title('Participants 11')

subplot(3,4,12)
plot(results{12}(1:6,1),results{12}(1:6,2),'*',results{12}(7:12,1),results{12}(7:12,2),'o',results{12}(13:18,1),results{12}(13:18,2),'p')
% hold on 
% plot(f12_1,'-');
% hold on
% plot(f12_2,'-');
% hold on
% plot(f12_3,'-');
title('Participants 12')

filename= ('jerk_SP1_FP_each.pdf');
print(filename,'-dpdf')
 
 %% 2.Linear regression model with random effect and without random effect
C=([results{1}(:,:);results{2}(:,:);results{3}(:,:);results{4}(:,:);results{5}(:,:);results{6}(:,:);results{7}(:,:);results{8}(:,:);results{9}(:,:);results{10}(:,:);results{11}(:,:)]);
tbl= table(C(:,1),C(:,2),C(:,3),C(:,4),C(:,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
lme1=  fitlme(tbl,'JerkSmartphone~ForceRateFP+Speed+BW+(1|Participant)+(ForceRateFP-1|Participant)');  % Mixed model with random effect intercept and coefficient 
lme2=  fitlme(tbl,'JerkSmartphone~ForceRateFP+Speed+BW+(1|Participant)');       % Mixed model with random effect intercept 
lme3=  fitlme(tbl,'JerkSmartphone~ForceRateFP+Speed+BW');                       % Mixed model without random effect intercept

%% 3.Check significants of random effect
[psi,dispersion,stats] = covarianceParameters(lme1);
%% 4.Compare fitlme with and without random effect 
comp_res = compare(lme3,lme1,'CheckNesting',true);
%% 5. Generate the fitted conditional mean values for the model 
mufit = fitted(lme1);
figure
scatter(tbl.JerkSmartphone,mufit)
title('Observed Values versus Fitted Values')
xlabel('Fitted Values')
ylabel('Observed Values')
%% 6.Plot a histogram to visually confirm that the mean of the Pearson residuals is equal to 0
plotResiduals(lme1,'histogram','ResidualType','Pearson')
%% 7.Plot the Pearson residuals versus the fitted values
plotResiduals(lme1,'fitted','ResidualType','Pearson')