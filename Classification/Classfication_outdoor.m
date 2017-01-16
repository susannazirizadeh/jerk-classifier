%% Classification of activties of outdoor session using SVM 
% Optimize a Cross-Validated SVM Classifier Using Bayesian Optimization
% 1. Prepare Data For Classification
% 2. Prepare Cross-Validation
% 3. Prepare Variables for Bayesian Optimization
% 4. Objective Function
% 5. Optimize Classifier
% 6. Use the results to train a new, optimized SVM classifier(

% 7. Plot the classification boundaries
% 8. Evaluate Accuracy on New Data
 load results_loadrate
button=1;
C=([results_loadrate.outdoor{button}{1}(:,:);results_loadrate.outdoor{button}{2}(:,:);results_loadrate.outdoor{button}{3}(:,:);results_loadrate.outdoor{button}{4}(:,:);results_loadrate.outdoor{button}{5}(:,:);results_loadrate.outdoor{button}{6}(:,:);results_loadrate.outdoor{button}{7}(:,:);results_loadrate.outdoor{button}{8}(:,:);results_loadrate.outdoor{button}{9}(:,:);results_loadrate.outdoor{button}{10}(:,:);results_loadrate.outdoor{button}{11}(:,:);results_loadrate.outdoor{button}{12}(:,:)]);
%% Train SVM Classifier Using Custom Kernelfigure
X=[C(:,6)];%,C(:,2)];
Y=C(:,1); 
MdlGau =fitrsvm(X,Y,'Standardize',true,'KernelFunction','gaussian');
yfit=predict(MdlGau,X)

%%