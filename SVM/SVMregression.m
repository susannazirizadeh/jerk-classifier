%% Creat a SVM Regression model
load results
C=([results{1}(:,:);results{2}(:,:);results{3}(:,:);results{4}(:,:);results{5}(:,:);results{6}(:,:);results{7}(:,:);results{8}(:,:);results{9}(:,:);results{10}(:,:);results{11}(:,:)]);
%% Example for SVM regression
X=[C(25:end,1)];%,C(:,2)];
Y=C(25:end,2);
MdlGau =fitrsvm(X,Y,'Standardize',true,'KernelFunction','gaussian');
compactMdlLin=compact(MdlLin);
yfit=predict(MdlGau,X)


%% 
MdlLin = fitrsvm(X,Y,'Standardize',true,'KFold',5);
MdlGau = fitrsvm(X,Y,'KernelFunction','gaussian','KernelScale','auto','Standardize',true,'KFold',5);
mseLin = kfoldLoss(MdlLin);
mseGau = kfoldLoss(MdlGau);



compactMdlLin=compact(MdlLin);

%%
figure;
scatter(X,Y)

