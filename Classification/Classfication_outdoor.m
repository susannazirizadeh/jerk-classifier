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
%  load results_loadrate

C1(:,1:8)=([results.jerk_pos{1}{1}(:,:);results.jerk_pos{1}{2}(:,:);results.jerk_pos{1}{3}(:,:);results.jerk_pos{1}{4}(:,:);results.jerk_pos{1}{5}(:,:);results.jerk_pos{1}{6}(:,:);results.jerk_pos{1}{7}(:,:);results.jerk_pos{1}{8}(:,:);results.jerk_pos{1}{9}(:,:);results.jerk_pos{1}{10}(:,:);results.jerk_pos{1}{11}(:,:);results.jerk_pos{1}{12}(:,:)]);
% C(:,7)= ([results.jerk_pos{2}{1}(:,1);results.jerk_pos{2}{2}(:,1);results.jerk_pos{2}{3}(:,1);results.jerk_pos{2}{4}(:,1);results.jerk_pos{2}{5}(:,1);results.jerk_pos{2}{6}(:,1);results.jerk_pos{2}{7}(:,1);results.jerk_pos{2}{8}(:,1);results.jerk_pos{2}{9}(:,1);results.jerk_pos{2}{10}(:,1);results.jerk_pos{2}{11}(:,1);results.jerk_pos{2}{12}(:,1)]);
a= find(C1(:,7)); 
C1new=C1(a,:);


%% Crearing matrix with all features
C_activty=[C1(:,1),C2(:,1),C3(:,1),C4(:,1),C1(:,8),C1(:,7),C1(:,3)]; 
% 1.colum: jerk_pos (Jerk if y direction is positiv)
% 2.colum: jerk_all (Jerk for all cases)
% 3.colum: acc_pos (Acceleration if y direction is positiv)
% 4.colum: acc_all (Acceleration for all cases) 
% 5.colum: frequency of the signal
% 6.colum: GPS of the activty
% 7.colum: Activty classes
C_terrain(:,1:7)=[C1(:,1),C2(:,1),C3(:,1),C4(:,1),C1(:,8),C1(:,7),C1(:,4)];
% 1.colum: jerk_pos (Jerk if y direction is positiv)
% 2.colum: jerk_all (Jerk for all cases)
% 3.colum: acc_pos (Acceleration if y direction is positiv)
% 4.colum: acc_all (Acceleration for all cases) 
% 5.colum: frequency of the signal
% 6.colum: GPS of the activty
% 7.colum: Terrain classes

%% Train SVM Classifier Using Custom Kernelfigure
% X=[Cnew(:,6)];%,Cnew(:,2)];
% Y=Cnew(:,1); 
% MdlGau =fitrsvm(X,Y,'Standardize',true,'KernelFunction','gaussian');
% yfit=predict(MdlGau,X); 

%%
