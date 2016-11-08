%% Nonlinear Mixed-effects model
% 1. Enter and display data 
% 2. Use an anonymous function to specify a logistic growth model
% 3. Fit the model using nlmefit
load results_jerkpos
%% 1.Plot Forceplate data versus the jerk estimate
button=1;
C=([results_jerkpos.treadmill{button}{1}(:,:);results_jerkpos.treadmill{button}{2}(:,:);results_jerkpos.treadmill{button}{3}(:,:);results_jerkpos.treadmill{button}{4}(:,:);results_jerkpos.treadmill{button}{5}(:,:);results_jerkpos.treadmill{button}{6}(:,:);results_jerkpos.treadmill{button}{7}(:,:);results_jerkpos.treadmill{button}{8}(:,:);results_jerkpos.treadmill{button}{9}(:,:);results_jerkpos.treadmill{button}{10}(:,:);results_jerkpos.treadmill{button}{11}(:,:);results_jerkpos.treadmill{button}{12}(:,:)]);
figure;
plot(C(:,2),C(:,1),'ro')
title('{\bf Jerk smartphone vs jerk Forceplate}')
xlabel('Estimated Jerk from smartphone [m/s^3]')
ylabel('Forceplate Data [N]')
grid on
hold on
tbl= table(C(25:end,1),C(25:end,2),C(25:end,3),C(25:end,4),C(25:end,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
%% Use an anonymous function to specify a logistic growth model
model=@PHI(:,1).^2;