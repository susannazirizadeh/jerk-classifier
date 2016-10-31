%% Creat a SVM Regression model
load results
C=([results{1}(:,:);results{2}(:,:);results{3}(:,:);results{4}(:,:);results{5}(:,:);results{6}(:,:);results{7}(:,:);results{8}(:,:);results{9}(:,:);results{10}(:,:);results{11}(:,:)]);
%% Example for SVM regression
X=[C(:,2),C(:,4)];
Y=C(:,1);
MdlGau =fitrsvm(X,Y,'Standardize',true,'KernelFunction','gaussian');
compactMdlLin=compact(MdlGau);
yfit=predict(MdlGau,X);

%% 
Mdl= fitrsvm(X,Y); 
compactMdl=compact(Mdl);
MdlLin = fitrsvm(X,Y,'Standardize',true,'KFold',5);
MdlGau = fitrsvm(X,Y,'KernelFunction','gaussian','KernelScale','auto','Standardize',true,'KFold',5);
mseLin = kfoldLoss(MdlLin);
mseGau = kfoldLoss(MdlGau);
L = resubLoss(Mdl);
lossMSE= loss(Mdl,X,Y);
lossEI = loss(Mdl,X,Y,'LossFun','epsiloninsensitive');

%%
figure;
scatter3(X(:,1),X(:,2),Y)
 xlabel('Jerk data of smartphone between sholder baldes [m/s^3]')
 ylabel('Bodyweight [kg]')
 zlabel('Forceplate data [N]')