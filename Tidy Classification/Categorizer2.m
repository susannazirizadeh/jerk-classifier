 load featurematrix_loadrate
figure
hist(featurematrix_loadrate(:,1),1000);
title('Histogram of whole data set')
xlabel('Load rate value')
ylabel('Density')
%%
 lower=2.7682e+03;
 upper=5.6314e+03;
% low= featurematrix_loadrate(find(featurematrix_loadrate(:,1)<1.5e+7),1);
% med= featurematrix_loadrate(find(featurematrix_loadrate(:,1)>1.5e+7 & featurematrix_loadrate(:,1)<upper),1);
% high= featurematrix_loadrate(find(featurematrix_loadrate(:,1)>upper),1);
low= featurematrix_loadrate(find(featurematrix_loadrate(:,1)<lower),1);
med= featurematrix_loadrate(find(featurematrix_loadrate(:,1)>lower & featurematrix_loadrate(:,1)<upper),1);
high= featurematrix_loadrate(find(featurematrix_loadrate(:,1)>upper),1);
length(low);
length(med);
length(high);


%% All participnat in one plot
X_new_true=[];
X_new_test=[];
Y_new_true=[];
Y_new_test=[];
Z_new_true=[];
Z_new_test=[];
 load featurematrix
featurematrix=featurematrix(find(featurematrix(:,21)<4),:);
for participant=[1:4 6:12]
    Xtrain=featurematrix(find(featurematrix(:,24)~=participant),:); % Training data % excluding random participants from data set for validation
    inputTable = array2table(Xtrain, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});
    predictorNames = {'mean_loadrate', 'RMS_loadrate', 'energy_loadrate', 'entropy_loadrate'};
    predictors = inputTable(:, predictorNames);
    response = inputTable.speed;
    template = templateSVM(...
        'KernelFunction', 'gaussian', ...
        'PolynomialOrder', [], ...
        'KernelScale', 1.2, ...
        'BoxConstraint', 1, ...
        'Standardize', true);
    classificationSVM = fitcecoc(...        Classifier
        predictors, ...
        response, ...
        'Learners', template, ...
        'Coding', 'onevsone', ...
        'ClassNames', [1; 2; 3; 4; 5]);
    
    Xtest=featurematrix(find(featurematrix(:,24)==participant),:);    % test data for validation
    inputTable_test = array2table(Xtest, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});
    predictors_test = inputTable_test(:, predictorNames);
    response_test = inputTable_test.speed;
    label= predict(classificationSVM,inputTable_test);      % testing data
    
    Xtest(:,25)=label;
    
    % Categorize in within true actvity
    walk_part=Xtest(find(Xtest(:,21)==1),1);
    low_walk_part=walk_part(find(walk_part<lower),1);
    med_walk_part=walk_part(find(walk_part>lower & walk_part<upper),1);
    high_walk_part=walk_part(find(walk_part(:,1)>upper),1);
    X1=[length(low_walk_part) length(med_walk_part) length(high_walk_part)];
    X_new_true=[X_new_true;X1];
    
    jog_part=Xtest(find(Xtest(:,21)==2),1);
    low_jog_part=jog_part(find(jog_part<lower),1);
    med_jog_part=jog_part(find(jog_part>lower & jog_part<upper),1);
    high_jog_part=jog_part(find(jog_part(:,1)>upper),1);
    Y1=[length(low_jog_part) length(med_jog_part) length(high_jog_part)];
    Y_new_true=[Y_new_true;Y1];
    
    run_part=Xtest(find(Xtest(:,21)==3),1);
    low_run_part=run_part(find(run_part<lower),1);
    med_run_part=run_part(find(run_part>lower & run_part<upper),1);
    high_run_part=run_part(find(run_part(:,1)>upper),1);
    Z1=[length(low_run_part) length(med_run_part) length(high_run_part)];
    Z_new_true=[Z_new_true;Z1];
    
    % Categorize in within predicted activity
    walk_test=Xtest(find(Xtest(:,25)==1),1);
    low_walk_test=walk_test(find(walk_test<lower),1);
    med_walk_test=walk_test(find(walk_test>lower & walk_test<upper),1);
    high_walk_test=walk_test(find(walk_test(:,1)>upper),1);
    X2=[length(low_walk_test) length(med_walk_test) length(high_walk_test)];
    X_new_test=[X_new_test;X2];
    
    jog_part=Xtest(find(Xtest(:,25)==2),1);
    low_jog_part=jog_part(find(jog_part<lower),1);
    med_jog_part=jog_part(find(jog_part>lower & jog_part<upper),1);
    high_jog_part=jog_part(find(jog_part(:,1)>upper),1);
    Y2=[length(low_jog_part) length(med_jog_part) length(high_jog_part)];
    Y_new_test=[Y_new_test;Y2];

    run_part=Xtest(find(Xtest(:,25)==3),1);
    low_run_part=run_part(find(run_part<lower),1);
    med_run_part=run_part(find(run_part>lower & run_part<upper),1);
    high_run_part=run_part(find(run_part(:,1)>upper),1);
    Z2=[length(low_run_part) length(med_run_part) length(high_run_part)];
    Z_new_test=[Z_new_test;Z2];

end
figure;
    y1=[X_new_true;Y_new_true;Z_new_true];
    ax1 = subplot(2,1,1);
    bar(ax1,y1,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    ylabel('Density')
     ylim([0 350])
    legend('Low','Recommended','Intense');
    title('True activty');
    
    y2=[X_new_test;Y_new_true;Z_new_true];
    ax2 = subplot(2,1,2);
    bar(ax2,y2,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
     ylim([0 350])
    legend('Low','Recommended','Intense');
    title('Predicted running speed');
    filename= ('Running_Participant.pdf');
    print(filename,'-dpdf')
    
    %% All participnat in three plots, just predicted
X_new_true=[];
X_new_test=[];
Y_new_true=[];
Y_new_test=[];
Z_new_true=[];
Z_new_test=[];
 load featurematrix
featurematrix=featurematrix(find(featurematrix(:,21)<4),:);
for participant=[1:4 6:12]
    Xtrain=featurematrix(find(featurematrix(:,24)~=participant),:); % Training data % excluding random participants from data set for validation
    inputTable = array2table(Xtrain, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});
    predictorNames = {'mean_loadrate', 'RMS_loadrate', 'energy_loadrate', 'entropy_loadrate'};
    predictors = inputTable(:, predictorNames);
    response = inputTable.speed;
    template = templateSVM(...
        'KernelFunction', 'gaussian', ...
        'PolynomialOrder', [], ...
        'KernelScale', 1.2, ...
        'BoxConstraint', 1, ...
        'Standardize', true);
    classificationSVM = fitcecoc(...        Classifier
        predictors, ...
        response, ...
        'Learners', template, ...
        'Coding', 'onevsone', ...
        'ClassNames', [1; 2; 3; 4; 5]);
    
    Xtest=featurematrix(find(featurematrix(:,24)==participant),:);    % test data for validation
    inputTable_test = array2table(Xtest, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});
    predictors_test = inputTable_test(:, predictorNames);
    response_test = inputTable_test.speed;
    label= predict(classificationSVM,inputTable_test);      % testing data
    
    Xtest(:,25)=label;
    
    % Categorize in within true actvity
    walk_part=Xtest(find(Xtest(:,21)==1),1);
    low_walk_part=walk_part(find(walk_part<lower),1);
    med_walk_part=walk_part(find(walk_part>lower & walk_part<upper),1);
    high_walk_part=walk_part(find(walk_part(:,1)>upper),1);
    X1=[length(low_walk_part) length(med_walk_part) length(high_walk_part)];
    X_new_true=[X_new_true;X1];
    
    jog_part=Xtest(find(Xtest(:,21)==2),1);
    low_jog_part=jog_part(find(jog_part<lower),1);
    med_jog_part=jog_part(find(jog_part>lower & jog_part<upper),1);
    high_jog_part=jog_part(find(jog_part(:,1)>upper),1);
    Y1=[length(low_jog_part) length(med_jog_part) length(high_jog_part)];
    Y_new_true=[Y_new_true;Y1];
    
    run_part=Xtest(find(Xtest(:,21)==3),1);
    low_run_part=run_part(find(run_part<lower),1);
    med_run_part=run_part(find(run_part>lower & run_part<upper),1);
    high_run_part=run_part(find(run_part(:,1)>upper),1);
    Z1=[length(low_run_part) length(med_run_part) length(high_run_part)];
    Z_new_true=[Z_new_true;Z1];
    
    
    % Categorize in within predicted activity
    walk_test=Xtest(find(Xtest(:,25)==1),1);
    low_walk_test=walk_test(find(walk_test<lower),1);
    med_walk_test=walk_test(find(walk_test>lower & walk_test<upper),1);
    high_walk_test=walk_test(find(walk_test(:,1)>upper),1);
    X2=[length(low_walk_test) length(med_walk_test) length(high_walk_test)];
    X_new_test=[X_new_test;X2];
    
    jog_part=Xtest(find(Xtest(:,25)==2),1);
    low_jog_part=jog_part(find(jog_part<lower),1);
    med_jog_part=jog_part(find(jog_part>lower & jog_part<upper),1);
    high_jog_part=jog_part(find(jog_part(:,1)>upper),1);
    Y2=[length(low_jog_part) length(med_jog_part) length(high_jog_part)];
    Y_new_test=[Y_new_test;Y2];

    run_part=Xtest(find(Xtest(:,25)==3),1);
    low_run_part=run_part(find(run_part<lower),1);
    med_run_part=run_part(find(run_part>lower & run_part<upper),1);
    high_run_part=run_part(find(run_part(:,1)>upper),1);
    Z2=[length(low_run_part) length(med_run_part) length(high_run_part)];
    Z_new_test=[Z_new_test;Z2];

end
figure;
    y1=X_new_true;
    ax1 = subplot(3,2,1);
    bar(ax1,y1,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
     set(gca,'xticklabel',name);
    ylabel('Density')
     ylim([0 350])
    legend('Low','Recommended','Intense');
    title('True walking');
    
    y2=Y_new_true;
    ax2 = subplot(3,2,3);
    bar(ax2,y2,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%       ylim([0 200])
    title('True jogging');
    
    y3=Z_new_true;
    ax3 = subplot(3,2,5);
    bar(ax3,y3,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%      ylim([0 80])
    title('True running');
    
     y4=X_new_test;
    ax4 = subplot(3,2,2);
    bar(ax4,y4,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
     set(gca,'xticklabel',name);
    ylabel('Density')
     ylim([0 350])
    legend('Low','Recommended','Intense');
    title('Predicted walking');
    
    y5=Y_new_test;
    ax5 = subplot(3,2,4);
    bar(ax5,y5,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%       ylim([0 200])
    title('Predicted jogging');
    
    y6=Z_new_test;
    ax6 = subplot(3,2,6);
    bar(ax6,y6,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%      ylim([0 80])
    title('Predicted running');
    
    filename= ('Running_Participant.pdf');
    print(filename,'-dpdf')
    
    %% all participants included, terrain 
    
    X_new_true=[];
X_new_test=[];
Y_new_true=[];
Y_new_test=[];
Z_new_true=[];
Z_new_test=[];
 load featurematrix
featurematrix=featurematrix(find(featurematrix(:,21)<4),:);
for participant=[1:4 6:12]
    Xtrain=featurematrix(find(featurematrix(:,24)~=participant),:); % Training data % excluding random participants from data set for validation
    inputTable = array2table(Xtrain, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});   
    predictorNames =  {'max_load','STD_load','mean_f_load', 'dom_f_load', 'weight'};
    predictors = inputTable(:, predictorNames);
    response = inputTable.condition;
    
    template = templateSVM(...
        'KernelFunction', 'gaussian', ...
        'PolynomialOrder', [], ...
        'KernelScale', 1.2, ...
        'BoxConstraint', 1, ...
        'Standardize', true);
    classificationSVM = fitcecoc(...        Classifier
        predictors, ...
        response, ...
        'Learners', template, ...
        'Coding', 'onevsone', ...
        'ClassNames', [1; 2; 3; 4;5; 6;7]);
    Xtest=featurematrix(find(featurematrix(:,24)==participant),:);    % test data for validation
    inputTable_test = array2table(Xtest, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});
    predictors_test = inputTable_test(:, predictorNames);
    response_test = inputTable_test.condition;
    label= predict(classificationSVM,inputTable_test);      % testing data  
    Xtest(:,25)=label;
    
    % Categorize in within true terrain
    asphalt_part=Xtest(find(Xtest(:,22)==1),1);
    low_asphalt_part=asphalt_part(find(asphalt_part<lower),1);
    med_asphalt_part=asphalt_part(find(asphalt_part>lower & asphalt_part<upper),1);
    high_asphalt_part=asphalt_part(find(asphalt_part(:,1)>upper),1);
    X1=[length(low_asphalt_part) length(med_asphalt_part) length(high_asphalt_part)];
    X_new_true=[X_new_true;X1];
    
    grass_part=Xtest(find(Xtest(:,22)==2),1);
    low_grass_part=grass_part(find(grass_part<lower),1);
    med_grass_part=grass_part(find(grass_part>lower & grass_part<upper),1);
    high_grass_part=grass_part(find(grass_part(:,1)>upper),1);
    Y1=[length(low_grass_part) length(med_grass_part) length(high_grass_part)];
    Y_new_true=[Y_new_true;Y1];
    
    soil_part=Xtest(find(Xtest(:,22)==3),1);
    low_soil_part=soil_part(find(soil_part<lower),1);
    med_soil_part=soil_part(find(soil_part>lower & soil_part<upper),1);
    high_soil_part=soil_part(find(soil_part(:,1)>upper),1);
    Z1=[length(low_soil_part) length(med_soil_part) length(high_soil_part)];
    Z_new_true=[Z_new_true;Z1];
    
    % Categorize in within predicted terrain
    asphalt_part=Xtest(find(Xtest(:,25)==1),1);
    low_asphalt_part=asphalt_part(find(asphalt_part<lower),1);
    med_asphalt_part=asphalt_part(find(asphalt_part>lower & asphalt_part<upper),1);
    high_asphalt_part=asphalt_part(find(asphalt_part(:,1)>upper),1);
    X2=[length(low_asphalt_part) length(med_asphalt_part) length(high_asphalt_part)];
    X_new_test=[X_new_test;X2];
    
    grass_part=Xtest(find(Xtest(:,25)==2),1);
    low_grass_part=grass_part(find(grass_part<lower),1);
    med_grass_part=grass_part(find(grass_part>lower & grass_part<upper),1);
    high_grass_part=grass_part(find(grass_part(:,1)>upper),1);
    Y2=[length(low_grass_part) length(med_grass_part) length(high_grass_part)];
    Y_new_test=[Y_new_test;Y2];
     
    soil_part=Xtest(find(Xtest(:,25)==3),1);
    low_soil_part=soil_part(find(soil_part<lower),1);
    med_soil_part=soil_part(find(soil_part>lower & soil_part<upper),1);
    high_soil_part=soil_part(find(soil_part(:,1)>upper),1);
    Z2=[length(low_soil_part) length(med_soil_part) length(high_soil_part)];
    Z_new_test=[Z_new_test;Z2];
end
figure;
    y1=X_new_true;
    ax1 = subplot(3,2,1);
    bar(ax1,y1,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
     set(gca,'xticklabel',name);
    ylabel('Density')
%      ylim([0 350])
    legend('Low','Recommended','Intense');
    title('True asphalt');
    
    y2=Y_new_true;
    ax2 = subplot(3,2,3);
    bar(ax2,y2,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%       ylim([0 200])
    title('True grass');
    
    y3=Z_new_true;
    ax3 = subplot(3,2,5);
    bar(ax3,y3,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%      ylim([0 80])
    title('True gravel path');
    
     y4=X_new_test;
    ax4 = subplot(3,2,2);
    bar(ax4,y4,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
     set(gca,'xticklabel',name);
    ylabel('Density')
     ylim([0 350])
    legend('Low','Recommended','Intense');
    title('Predicted asphalt');
    
    y5=Y_new_test;
    ax5 = subplot(3,2,4);
    bar(ax5,y5,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%       ylim([0 200])
    title('Predicted grass');
    
    y6=Z_new_test;
    ax6 = subplot(3,2,6);
    bar(ax6,y6,'stacked');
     name = {'P1';'P2';'P3';'P4';'P5';'P6';'P7';'P8';'P9';'P10';'P11'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%      ylim([0 80])
    title('Predicted gravel path');
    
    filename= ('Running_Participant.pdf');
    print(filename,'-dpdf')