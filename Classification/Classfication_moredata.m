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

C1=([results.jerk_pos{1}{1}(:,:);results.jerk_pos{1}{2}(:,:);results.jerk_pos{1}{3}(:,:);results.jerk_pos{1}{4}(:,:);results.jerk_pos{1}{5}(:,:);results.jerk_pos{1}{6}(:,:);results.jerk_pos{1}{7}(:,:);results.jerk_pos{1}{8}(:,:);results.jerk_pos{1}{9}(:,:);results.jerk_pos{1}{10}(:,:);results.jerk_pos{1}{11}(:,:);results.jerk_pos{1}{12}(:,:)]);
C2=([results.jerk_all{1}{1}(:,:);results.jerk_all{1}{2}(:,:);results.jerk_all{1}{3}(:,:);results.jerk_all{1}{4}(:,:);results.jerk_all{1}{5}(:,:);results.jerk_all{1}{6}(:,:);results.jerk_all{1}{7}(:,:);results.jerk_all{1}{8}(:,:);results.jerk_all{1}{9}(:,:);results.jerk_all{1}{10}(:,:);results.jerk_all{1}{11}(:,:);results.jerk_all{1}{12}(:,:)]);
C3=([results.acc_pos{1}{1}(:,:);results.acc_pos{1}{2}(:,:);results.acc_pos{1}{3}(:,:);results.acc_pos{1}{4}(:,:);results.acc_pos{1}{5}(:,:);results.acc_pos{1}{6}(:,:);results.acc_pos{1}{7}(:,:);results.acc_pos{1}{8}(:,:);results.acc_pos{1}{9}(:,:);results.acc_pos{1}{10}(:,:);results.acc_pos{1}{11}(:,:);results.acc_pos{1}{12}(:,:)]);
C4=([results.acc_all{1}{1}(:,:);results.acc_all{1}{2}(:,:);results.acc_all{1}{3}(:,:);results.acc_all{1}{4}(:,:);results.acc_all{1}{5}(:,:);results.acc_all{1}{6}(:,:);results.acc_all{1}{7}(:,:);results.acc_all{1}{8}(:,:);results.acc_all{1}{9}(:,:);results.acc_all{1}{10}(:,:);results.acc_all{1}{11}(:,:);results.acc_all{1}{12}(:,:)]);

C_all=[C1(:,1),C2(:,1),C3(:,1),C4(:,1),C1(:,2),C1(:,3),C1(:,4)];

% 1.colum: jerk_pos (Jerk if y direction is positiv)
% 2.colum: jerk_all (Jerk for all cases)
% 3.colum: acc_pos (Acceleration if y direction is positiv)
% 4.colum: acc_all (Acceleration for all cases) 
% 5.colum: speed classes
% 6.colum: terrain classes
% 7.colum: weight of participant 

%% Classification each individual 

C1=[results.jerk_pos{1}{1}(:,1),results.jerk_all{1}{1}(:,1),results.acc_pos{1}{1}(:,1),results.acc_all{1}{1}(:,:)];
C2=[results.jerk_pos{1}{2}(:,1),results.jerk_all{1}{2}(:,1),results.acc_pos{1}{2}(:,1),results.acc_all{1}{2}(:,:)];
C3=[results.jerk_pos{1}{3}(:,1),results.jerk_all{1}{3}(:,1),results.acc_pos{1}{3}(:,1),results.acc_all{1}{3}(:,:)];
C4=[results.jerk_pos{1}{4}(:,1),results.jerk_all{1}{4}(:,1),results.acc_pos{1}{4}(:,1),results.acc_all{1}{4}(:,:)];
C5=[results.jerk_pos{1}{5}(:,1),results.jerk_all{1}{5}(:,1),results.acc_pos{1}{5}(:,1),results.acc_all{1}{5}(:,:)];
C6=[results.jerk_pos{1}{6}(:,1),results.jerk_all{1}{6}(:,1),results.acc_pos{1}{6}(:,1),results.acc_all{1}{6}(:,:)];
C7=[results.jerk_pos{1}{7}(:,1),results.jerk_all{1}{7}(:,1),results.acc_pos{1}{7}(:,1),results.acc_all{1}{7}(:,:)];
C8=[results.jerk_pos{1}{8}(:,1),results.jerk_all{1}{8}(:,1),results.acc_pos{1}{8}(:,1),results.acc_all{1}{8}(:,:)];
C9=[results.jerk_pos{1}{9}(:,1),results.jerk_all{1}{9}(:,1),results.acc_pos{1}{9}(:,1),results.acc_all{1}{9}(:,:)];
C10=[results.jerk_pos{1}{10}(:,1),results.jerk_all{1}{10}(:,1),results.acc_pos{1}{10}(:,1),results.acc_all{1}{10}(:,:)];
C11=[results.jerk_pos{1}{11}(:,1),results.jerk_all{1}{11}(:,1),results.acc_pos{1}{11}(:,1),results.acc_all{1}{11}(:,:)];
C12=[results.jerk_pos{1}{12}(:,1),results.jerk_all{1}{12}(:,1),results.acc_pos{1}{12}(:,1),results.acc_all{1}{12}(:,:)];
