%% Creat a SVM 
% Optimize a Cross-Validated SVM Classifier Using Bayesian Optimization
% 1. Prepare Data For Classification
% 2. Prepare Cross-Validation
% 3. Prepare Variables for Bayesian Optimization
% 4. Objective Function
% 5. Optimize Classifier
% 6. Use the results to train a new, optimized SVM classifier(

% 7. Plot the classification boundaries
% 8. Evaluate Accuracy on New Data
load results_jerkpos
button=3;
C=([results_jerkpos.treadmill{button}{1}(:,:);results_jerkpos.treadmill{button}{2}(:,:);results_jerkpos.treadmill{button}{3}(:,:);results_jerkpos.treadmill{button}{4}(:,:);results_jerkpos.treadmill{button}{5}(:,:);results_jerkpos.treadmill{button}{6}(:,:);results_jerkpos.treadmill{button}{7}(:,:);results_jerkpos.treadmill{button}{8}(:,:);results_jerkpos.treadmill{button}{9}(:,:);results_jerkpos.treadmill{button}{10}(:,:);results_jerkpos.treadmill{button}{11}(:,:);results_jerkpos.treadmill{button}{12}(:,:)]);
%% Train SVM Classifier Using Custom Kernelfigure
X=[C(:,1)];%,C(:,2)];
Y=C(:,2); 
MdlGau =fitrsvm(X,Y,'Standardize',true,'KernelFunction','gaussian');
yfit=predict(MdlGau,X)

%%


