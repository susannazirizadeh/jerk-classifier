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
load results
C=([results{1}(:,:);results{2}(:,:);results{3}(:,:);results{4}(:,:);results{5}(:,:);results{6}(:,:);results{7}(:,:);results{8}(:,:);results{9}(:,:);results{10}(:,:);results{11}(:,:)]);
%% Train SVM Classifier Using Custom Kernelfigure
X=[C(:,1)];%,C(:,2)];
Y=C(:,2);
MdlGau =fitrsvm(X,Y,'Standardize',true,'KernelFunction','gaussian');
yfit=predict(MdlGau,X)

%%


