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

C(:,1:6)=([results_loadrate.outdoor{1}{1}(:,:);results_loadrate.outdoor{1}{2}(:,:);results_loadrate.outdoor{1}{3}(:,:);results_loadrate.outdoor{1}{4}(:,:);results_loadrate.outdoor{1}{5}(:,:);results_loadrate.outdoor{1}{6}(:,:);results_loadrate.outdoor{1}{7}(:,:);results_loadrate.outdoor{1}{8}(:,:);results_loadrate.outdoor{1}{9}(:,:);results_loadrate.outdoor{1}{10}(:,:);results_loadrate.outdoor{1}{11}(:,:);results_loadrate.outdoor{1}{12}(:,:)]);
C(:,7)= ([results_loadrate.outdoor{2}{1}(:,1);results_loadrate.outdoor{2}{2}(:,1);results_loadrate.outdoor{2}{3}(:,1);results_loadrate.outdoor{2}{4}(:,1);results_loadrate.outdoor{2}{5}(:,1);results_loadrate.outdoor{2}{6}(:,1);results_loadrate.outdoor{2}{7}(:,1);results_loadrate.outdoor{2}{8}(:,1);results_loadrate.outdoor{2}{9}(:,1);results_loadrate.outdoor{2}{10}(:,1);results_loadrate.outdoor{2}{11}(:,1);results_loadrate.outdoor{2}{12}(:,1)]);
Cnew=C(find(C(:,6)),:);
%% Train SVM Classifier Using Custom Kernelfigure
X=[Cnew(:,6)];%,Cnew(:,2)];
Y=Cnew(:,1); 
MdlGau =fitrsvm(X,Y,'Standardize',true,'KernelFunction','gaussian');
yfit=predict(MdlGau,X)

%%