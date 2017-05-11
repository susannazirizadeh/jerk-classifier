%% Categorinzing data into low, medium and high load rate
% 1. Define low, medium and high load rate
% 2. Creat pie-charts for every single activty 
% 3. Creat Histogram with different categories
% 4. Creat a bar chart to visualize different load rate within different activties 
% 4. Test set, exluded participant actvity should be predicted with amount load rate estimate 
%% 1. Define low, medium and high load rate
load featurematrix_loadrate
figure
hist(featurematrix_loadrate(:,1),1000);
title('Histogram of whole data set')
xlabel('Load rate value')
ylabel('Density')
% low= featurematrix_loadrate(find(featurematrix_loadrate(:,1)<1.5e+7),1);
% med= featurematrix_loadrate(find(featurematrix_loadrate(:,1)>1.5e+7 & featurematrix_loadrate(:,1)<2.5e+7),1);
% high= featurematrix_loadrate(find(featurematrix_loadrate(:,1)>2.5e+7),1);
low= featurematrix_loadrate(find(featurematrix_loadrate(:,1)<5.8253e+3),1);
med= featurematrix_loadrate(find(featurematrix_loadrate(:,1)>5.8253e+3 & featurematrix_loadrate(:,1)<9.08e+3),1);
high= featurematrix_loadrate(find(featurematrix_loadrate(:,1)>2.5e+7),1);
 lower=5.8253e+6;
 upper=9.08e+6;
length(low);
length(med);
length(high);

%% 2. Creat pie-charts for every single activty
figure;
 featurematrix_loadrate=featurematrix_loadrate(find(featurematrix_loadrate(:,1)>0.1e+7),:);
walk=featurematrix_loadrate(find(featurematrix_loadrate(:,11)==1),1);
low_walk=walk(find(walk<lower),1);
med_walk=walk(find(walk>lower & walk<upper),1);
high_walk=walk(find(walk(:,1)>upper),1);
X=[length(low_walk) length(med_walk) length(high_walk)];
labels = {'Low','Medium','High'};
ax1 = subplot(2,3,1);
pie(ax1,X,labels)
title(ax1,'Walk');

jog=featurematrix_loadrate(find(featurematrix_loadrate(:,11)==2),1);
low_jog=jog(find(jog<1.5e+7),1);
med_jog=jog(find(jog>lower & jog<upper),1);
high_jog=jog(find(jog(:,1)>upper),1);
Y=[length(low_jog) length(med_jog) length(high_jog)];
labels = {'Low','Medium','High'};
ax2 = subplot(2,3,2);
pie(ax2,Y,labels)
title(ax2,'Jog');

run=featurematrix_loadrate(find(featurematrix_loadrate(:,11)==3),1);
low_run=run(find(run<lower),1);
med_run=run(find(run>lower & run<upper),1);
high_run=run(find(run(:,1)>upper),1);
Z=[length(low_run) length(med_run) length(high_run)];
labels = {'Low','Medium','High'};
ax3 = subplot(2,3,3);
pie(ax3,Z,labels)
title(ax3,'Run');

slow_stairs=featurematrix_loadrate(find(featurematrix_loadrate(:,11)==4),1);
low_slow_stairs=slow_stairs(find(slow_stairs<lower),1);
med_slow_stairs=slow_stairs(find(slow_stairs>lower & slow_stairs<upper),1);
high_slow_stairs=slow_stairs(find(slow_stairs(:,1)>upper),1);
A=[length(low_slow_stairs) length(med_slow_stairs) length(high_slow_stairs)];
labels = {'Low','Medium','High'};
ax4 = subplot(2,3,4);
pie(ax4,A,labels)
title(ax4,'Slow stairs');

fast_stairs=featurematrix_loadrate(find(featurematrix_loadrate(:,11)==5),1);
low_fast_stairs=fast_stairs(find(fast_stairs<lower),1);
med_fast_stairs=fast_stairs(find(fast_stairs>lower & fast_stairs<upper),1);
high_fast_stairs=fast_stairs(find(fast_stairs(:,1)>upper),1);
B=[length(low_fast_stairs) length(med_fast_stairs) length(high_fast_stairs)];
labels = {'Low','Medium','High'};
ax5 = subplot(2,3,5);
pie(ax5,B,labels)
title(ax5,'Fast stairs');

%% 3. Creat Histogram with different categorie
figure;
bins = 100; 
subplot(3,1,1)
histogram(walk,bins)
xlim([0 5e+7])
ylim([0 100])

subplot(3,1,2)
histogram(jog,bins)
xlim([0 5e+7])
ylim([0 100])

subplot(3,1,3)
histogram(run,bins)
xlim([0 5e+7])
ylim([0 100])

%% Bar for all participants
figure;
y=[length(low_walk) length(med_walk) length(high_walk);...
    length(low_jog) length(med_jog) length(high_jog);...
    length(low_run) length(med_run) length(high_run);...
    length(low_slow_stairs) length(med_slow_stairs) length(high_slow_stairs);...
    length(low_fast_stairs) length(med_fast_stairs) length(high_fast_stairs)];
bar(y,'stacked');
name = {'Walking';'Jogging';'Running';'Stairs slow';'Stairs fast'};
set(gca,'xticklabel',name);
legend('Low load rate','Medium load rate','High load rate');

%% Excluding first participants to test classifier running on him
 load featurematrix
featurematrix=featurematrix(find(featurematrix(:,21)<4),:);
for participant=[1:4 6:12]
    % participant=2;
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
    figure;
    walk_part=Xtest(find(Xtest(:,21)==1),1);
    low_walk_part=walk_part(find(walk_part<lower),1);
    med_walk_part=walk_part(find(walk_part>lower & walk_part<upper),1);
    high_walk_part=walk_part(find(walk_part(:,1)>upper),1);
    X=[length(low_walk_part) length(med_walk_part) length(high_walk_part)];
    
    jog_part=Xtest(find(Xtest(:,21)==2),1);
    low_jog_part=jog_part(find(jog_part<lower),1);
    med_jog_part=jog_part(find(jog_part>lower & jog_part<upper),1);
    high_jog_part=jog_part(find(jog_part(:,1)>upper),1);
    Y=[length(low_jog_part) length(med_jog_part) length(high_jog_part)];
    
    run_part=Xtest(find(Xtest(:,21)==3),1);
    low_run_part=run_part(find(run_part<lower),1);
    med_run_part=run_part(find(run_part>lower & run_part<upper),1);
    high_run_part=run_part(find(run_part(:,1)>upper),1);
    Z=[length(low_run_part) length(med_run_part) length(high_run_part)];
    
    slow_stairs_part=Xtest(find(Xtest(:,21)==4),1);
    low_slow_stairs_part=slow_stairs_part(find(slow_stairs_part<lower),1);
    med_slow_stairs_part=slow_stairs_part(find(slow_stairs_part>lower & slow_stairs_part<upper),1);
    high_slow_stairs_part=slow_stairs_part(find(slow_stairs_part(:,1)>upper),1);
    A=[length(low_slow_stairs_part) length(med_slow_stairs_part) length(high_slow_stairs_part)];
    
    fast_stairs_part=Xtest(find(Xtest(:,21)==5),1);
    low_fast_stairs_part=fast_stairs_part(find(fast_stairs_part<lower),1);
    med_fast_stairs_part=fast_stairs_part(find(fast_stairs_part>lower & fast_stairs_part<2.56e+7),1);
    high_fast_stairs_part=fast_stairs_part(find(fast_stairs_part(:,1)>upper),1);
    B=[length(low_fast_stairs_part) length(med_fast_stairs_part) length(high_fast_stairs_part)];
    
    y=[X;Y;Z];%;A;B;];
    ax1 = subplot(2,1,1);
    bar(ax1,y,'stacked');
    name = {'Walking';'Jogging';'Running'};%;'Stairs slow';'Stairs fast'};
    set(gca,'xticklabel',name);
    ylabel('Density')
    ylim([0 300])
    legend('Low load rate','Medium load rate','High load rate');
    title(['True activty, Participant ',num2str(participant)]);
    
    % Categorize in within predicted activity
    walk_part=Xtest(find(Xtest(:,25)==1),1);
    low_walk_part=walk_part(find(walk_part<lower),1);
    med_walk_part=walk_part(find(walk_part>lower & walk_part<upper),1);
    high_walk_part=walk_part(find(walk_part(:,1)>upper),1);
    X=[length(low_walk_part) length(med_walk_part) length(high_walk_part)];
    
    jog_part=Xtest(find(Xtest(:,25)==2),1);
    low_jog_part=jog_part(find(jog_part<lower),1);
    med_jog_part=jog_part(find(jog_part>lower & jog_part<upper),1);
    high_jog_part=jog_part(find(jog_part(:,1)>upper),1);
    Y=[length(low_jog_part) length(med_jog_part) length(high_jog_part)];
    
    run_part=Xtest(find(Xtest(:,25)==3),1);
    low_run_part=run_part(find(run_part<lower),1);
    med_run_part=run_part(find(run_part>lower & run_part<upper),1);
    high_run_part=run_part(find(run_part(:,1)>upper),1);
    Z=[length(low_run_part) length(med_run_part) length(high_run_part)];
    
    slow_stairs_part=Xtest(find(Xtest(:,25)==4),1);
    low_slow_stairs_part=slow_stairs_part(find(slow_stairs_part<lower),1);
    med_slow_stairs_part=slow_stairs_part(find(slow_stairs_part>lower & slow_stairs_part<upper),1);
    high_slow_stairs_part=slow_stairs_part(find(slow_stairs_part(:,1)>upper),1);
    A=[length(low_slow_stairs_part) length(med_slow_stairs_part) length(high_slow_stairs_part)];
    
    fast_stairs_part=Xtest(find(Xtest(:,25)==5),1);
    low_fast_stairs_part=fast_stairs_part(find(fast_stairs_part<lower),1);
    med_fast_stairs_part=fast_stairs_part(find(fast_stairs_part>lower & fast_stairs_part<upper),1);
    high_fast_stairs_part=fast_stairs_part(find(fast_stairs_part(:,1)>upper),1);
    B=[length(low_fast_stairs_part) length(med_fast_stairs_part) length(high_fast_stairs_part)];
    
    y=[X;Y;Z];%;A;B;];
    ax2 = subplot(2,1,2);
    bar(ax2,y,'stacked');
    name = {'Walking';'Jogging';'Running'};%;'Stairs slow';'Stairs fast'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
    ylim([0 300])
    legend('Low load rate','Medium load rate','High load rate');
    title(['Predicted running speed, Participant ',num2str(participant)]);
    filename= (['Running_Participant',num2str(participant),'.pdf']);
    print(filename,'-dpdf')
end

%% Excluding first participants to test classifier with incline and stairs
 load featurematrix
featurematrix=featurematrix(find(featurematrix(:,22)>3),:);
% featurematrix=featurematrix(find(featurematrix(:,21)==5),:);
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
        'ClassNames', [4; 5; 6; 7]);
    Xtest=featurematrix(find(featurematrix(:,24)==participant),:);    % test data for validation
    inputTable_test = array2table(Xtest, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});
    predictors_test = inputTable_test(:, predictorNames);
    response_test = inputTable_test.condition;
    label= predict(classificationSVM,inputTable_test);      % testing data
    
    Xtest(:,25)=label;
    
    % Categorize in within true actvity
    figure;
%     asphalt_part=Xtest(find(Xtest(:,22)==1),1);
%     low_asphalt_part=asphalt_part(find(asphalt_part<1.5e+7),1);
%     med_asphalt_part=asphalt_part(find(asphalt_part>1.5e+7 & asphalt_part<2.56e+7),1);
%     high_asphalt_part=asphalt_part(find(asphalt_part(:,1)>2.5e+7),1);
%     X=[length(low_asphalt_part) length(med_asphalt_part) length(high_asphalt_part)];
%     
%     grass_part=Xtest(find(Xtest(:,22)==2),1);
%     low_grass_part=grass_part(find(grass_part<1.5e+7),1);
%     med_grass_part=grass_part(find(grass_part>1.5e+7 & grass_part<2.56e+7),1);
%     high_grass_part=grass_part(find(grass_part(:,1)>2.5e+7),1);
%     Y=[length(low_grass_part) length(med_grass_part) length(high_grass_part)];
%     
%     soil_part=Xtest(find(Xtest(:,22)==3),1);
%     low_soil_part=soil_part(find(soil_part<1.5e+7),1);
%     med_soil_part=soil_part(find(soil_part>1.5e+7 & soil_part<2.56e+7),1);
%     high_soil_part=soil_part(find(soil_part(:,1)>2.5e+7),1);
%     Z=[length(low_soil_part) length(med_soil_part) length(high_soil_part)];
    
    inclineup_part=Xtest(find(Xtest(:,22)==4),1);
    low_inclineup_part=inclineup_part(find(inclineup_part<1.5e+7),1);
    med_inclineup_part=inclineup_part(find(inclineup_part>1.5e+7 & inclineup_part<2.56e+7),1);
    high_inclineup_part=inclineup_part(find(inclineup_part(:,1)>2.5e+7),1);
    A=[length(low_inclineup_part) length(med_inclineup_part) length(high_inclineup_part)];
    
    inclinedown_part=Xtest(find(Xtest(:,22)==5),1);
    low_inclinedown_part=inclinedown_part(find(inclinedown_part<1.5e+7),1);
    med_inclinedown_part=inclinedown_part(find(inclinedown_part>1.5e+7 & inclinedown_part<2.56e+7),1);
    high_inclinedown_part=inclinedown_part(find(inclinedown_part(:,1)>2.5e+7),1);
    B=[length(low_inclinedown_part) length(med_inclinedown_part) length(high_inclinedown_part)];
    
    stairsup_part=Xtest(find(Xtest(:,22)==6),1);
    low_stairsup_part=stairsup_part(find(stairsup_part<1.5e+7),1);
    med_stairsup_part=stairsup_part(find(stairsup_part>1.5e+7 & stairsup_part<2.56e+7),1);
    high_stairsup_part=stairsup_part(find(stairsup_part(:,1)>2.5e+7),1);
    C=[length(low_stairsup_part) length(med_stairsup_part) length(high_stairsup_part)];
    
    stairsdown_part=Xtest(find(Xtest(:,22)==7),1);
    low_stairsdown_part=stairsdown_part(find(stairsdown_part<1.5e+7),1);
    med_stairsdown_part=stairsdown_part(find(stairsdown_part>1.5e+7 & stairsdown_part<2.56e+7),1);
    high_stairsdown_part=stairsdown_part(find(stairsdown_part(:,1)>2.5e+7),1);
    D=[length(low_stairsdown_part) length(med_stairsdown_part) length(high_stairsdown_part)];
    
    y=[A;B;C;D];%[X;Y;Z]
    ax1 = subplot(2,1,1);
    bar(ax1,y,'stacked');
    name = {'inclineup';'inclinedown';'stairsup';'stairsdown'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
    ylim([0 50])
    legend('Low load rate','Medium load rate','High load rate');
    title(['True incline and stairs, Participant ',num2str(participant)]);
    
    % Categorize in within predicted activity
%     asphalt_part=Xtest(find(Xtest(:,25)==1),1);
%     low_asphalt_part=asphalt_part(find(asphalt_part<1.5e+7),1);
%     med_asphalt_part=asphalt_part(find(asphalt_part>1.5e+7 & asphalt_part<2.56e+7),1);
%     high_asphalt_part=asphalt_part(find(asphalt_part(:,1)>2.5e+7),1);
%     X=[length(low_asphalt_part) length(med_asphalt_part) length(high_asphalt_part)];
%     
%     grass_part=Xtest(find(Xtest(:,25)==2),1);
%     low_grass_part=grass_part(find(grass_part<1.5e+7),1);
%     med_grass_part=grass_part(find(grass_part>1.5e+7 & grass_part<2.56e+7),1);
%     high_grass_part=grass_part(find(grass_part(:,1)>2.5e+7),1);
%     Y=[length(low_grass_part) length(med_grass_part) length(high_grass_part)];
%     
%     soil_part=Xtest(find(Xtest(:,25)==3),1);
%     low_soil_part=soil_part(find(soil_part<1.5e+7),1);
%     med_soil_part=soil_part(find(soil_part>1.5e+7 & soil_part<2.56e+7),1);
%     high_soil_part=soil_part(find(soil_part(:,1)>2.5e+7),1);
%     Z=[length(low_soil_part) length(med_soil_part) length(high_soil_part)];
    
    inclineup_part=Xtest(find(Xtest(:,25)==4),1);
    low_inclineup_part=inclineup_part(find(inclineup_part<1.5e+7),1);
    med_inclineup_part=inclineup_part(find(inclineup_part>1.5e+7 & inclineup_part<2.56e+7),1);
    high_inclineup_part=inclineup_part(find(inclineup_part(:,1)>2.5e+7),1);
    A=[length(low_inclineup_part) length(med_inclineup_part) length(high_inclineup_part)];
    
    inclinedown_part=Xtest(find(Xtest(:,25)==5),1);
    low_inclinedown_part=inclinedown_part(find(inclinedown_part<1.5e+7),1);
    med_inclinedown_part=inclinedown_part(find(inclinedown_part>1.5e+7 & inclinedown_part<2.56e+7),1);
    high_inclinedown_part=inclinedown_part(find(inclinedown_part(:,1)>2.5e+7),1);
    B=[length(low_inclinedown_part) length(med_inclinedown_part) length(high_inclinedown_part)];
    
    stairsup_part=Xtest(find(Xtest(:,25)==6),1);
    low_stairsup_part=stairsup_part(find(stairsup_part<1.5e+7),1);
    med_stairsup_part=stairsup_part(find(stairsup_part>1.5e+7 & stairsup_part<2.56e+7),1);
    high_stairsup_part=stairsup_part(find(stairsup_part(:,1)>2.5e+7),1);
    C=[length(low_stairsup_part) length(med_stairsup_part) length(high_stairsup_part)];
    
    stairsdown_part=Xtest(find(Xtest(:,25)==7),1);
    low_stairsdown_part=stairsdown_part(find(stairsdown_part<1.5e+7),1);
    med_stairsdown_part=stairsdown_part(find(stairsdown_part>1.5e+7 & stairsdown_part<2.56e+7),1);
    high_stairsdown_part=stairsdown_part(find(stairsdown_part(:,1)>2.5e+7),1);
    D=[length(low_stairsdown_part) length(med_stairsdown_part) length(high_stairsdown_part)];
        
    y=[A;B;C;D];%[X;Y;Z];
    ax2 = subplot(2,1,2);
    bar(ax2,y,'stacked');
    name = {'inlcineup';'inclinedown';'stairsup';'stairsdown'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
    ylim([0 50])
    legend('Low load rate','Medium load rate','High load rate');
    title(['Prediced incline and stairs, Participant ',num2str(participant)]); 
    filename= (['Stairs_Participant',num2str(participant),'.pdf']);
    print(filename,'-dpdf')
end

%% Excluding first participants to test classifier for terrain

 load featurematrix
% featurematrix=featurematrix(find(featurematrix(:,22)<4),:);
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
    
    % Categorize in within true actvity
    figure;
    asphalt_part=Xtest(find(Xtest(:,22)==1),1);
    low_asphalt_part=asphalt_part(find(asphalt_part<1.5e+7),1);
    med_asphalt_part=asphalt_part(find(asphalt_part>1.5e+7 & asphalt_part<2.56e+7),1);
    high_asphalt_part=asphalt_part(find(asphalt_part(:,1)>2.5e+7),1);
    X=[length(low_asphalt_part) length(med_asphalt_part) length(high_asphalt_part)];
    
    grass_part=Xtest(find(Xtest(:,22)==2),1);
    low_grass_part=grass_part(find(grass_part<1.5e+7),1);
    med_grass_part=grass_part(find(grass_part>1.5e+7 & grass_part<2.56e+7),1);
    high_grass_part=grass_part(find(grass_part(:,1)>2.5e+7),1);
    Y=[length(low_grass_part) length(med_grass_part) length(high_grass_part)];
    
    soil_part=Xtest(find(Xtest(:,22)==3),1);
    low_soil_part=soil_part(find(soil_part<1.5e+7),1);
    med_soil_part=soil_part(find(soil_part>1.5e+7 & soil_part<2.56e+7),1);
    high_soil_part=soil_part(find(soil_part(:,1)>2.5e+7),1);
    Z=[length(low_soil_part) length(med_soil_part) length(high_soil_part)];
    
    inclineup_part=Xtest(find(Xtest(:,22)==4),1);
    low_inclineup_part=inclineup_part(find(inclineup_part<1.5e+7),1);
    med_inclineup_part=inclineup_part(find(inclineup_part>1.5e+7 & inclineup_part<2.56e+7),1);
    high_inclineup_part=inclineup_part(find(inclineup_part(:,1)>2.5e+7),1);
    A=[length(low_inclineup_part) length(med_inclineup_part) length(high_inclineup_part)];
    
    inclinedown_part=Xtest(find(Xtest(:,22)==5),1);
    low_inclinedown_part=inclinedown_part(find(inclinedown_part<1.5e+7),1);
    med_inclinedown_part=inclinedown_part(find(inclinedown_part>1.5e+7 & inclinedown_part<2.56e+7),1);
    high_inclinedown_part=inclinedown_part(find(inclinedown_part(:,1)>2.5e+7),1);
    B=[length(low_inclinedown_part) length(med_inclinedown_part) length(high_inclinedown_part)];
    
    stairsup_part=Xtest(find(Xtest(:,22)==6),1);
    low_stairsup_part=stairsup_part(find(stairsup_part<1.5e+7),1);
    med_stairsup_part=stairsup_part(find(stairsup_part>1.5e+7 & stairsup_part<2.56e+7),1);
    high_stairsup_part=stairsup_part(find(stairsup_part(:,1)>2.5e+7),1);
    C=[length(low_stairsup_part) length(med_stairsup_part) length(high_stairsup_part)];
    
    stairsdown_part=Xtest(find(Xtest(:,22)==7),1);
    low_stairsdown_part=stairsdown_part(find(stairsdown_part<1.5e+7),1);
    med_stairsdown_part=stairsdown_part(find(stairsdown_part>1.5e+7 & stairsdown_part<2.56e+7),1);
    high_stairsdown_part=stairsdown_part(find(stairsdown_part(:,1)>2.5e+7),1);
    D=[length(low_stairsdown_part) length(med_stairsdown_part) length(high_stairsdown_part)];
    
    y=[X;Y;Z];%;A;B;C;D];
    ax1 = subplot(2,1,1);
    bar(ax1,y,'stacked');
    name = {'asphal';'grass';'gravel path';'inlcineup';'inclinedown';'stairsup';'stairsdown'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%     ylim([0 320])
    legend('Low load rate','Medium load rate','High load rate');
    title(['True terrain, Participant ',num2str(participant)]);
    
    % Categorize in within predicted activity
    asphalt_part=Xtest(find(Xtest(:,25)==1),1);
    low_asphalt_part=asphalt_part(find(asphalt_part<1.5e+7),1);
    med_asphalt_part=asphalt_part(find(asphalt_part>1.5e+7 & asphalt_part<2.56e+7),1);
    high_asphalt_part=asphalt_part(find(asphalt_part(:,1)>2.5e+7),1);
    X=[length(low_asphalt_part) length(med_asphalt_part) length(high_asphalt_part)];
    
    grass_part=Xtest(find(Xtest(:,25)==2),1);
    low_grass_part=grass_part(find(grass_part<1.5e+7),1);
    med_grass_part=grass_part(find(grass_part>1.5e+7 & grass_part<2.56e+7),1);
    high_grass_part=grass_part(find(grass_part(:,1)>2.5e+7),1);
    Y=[length(low_grass_part) length(med_grass_part) length(high_grass_part)];
    
    soil_part=Xtest(find(Xtest(:,25)==3),1);
    low_soil_part=soil_part(find(soil_part<1.5e+7),1);
    med_soil_part=soil_part(find(soil_part>1.5e+7 & soil_part<2.56e+7),1);
    high_soil_part=soil_part(find(soil_part(:,1)>2.5e+7),1);
    Z=[length(low_soil_part) length(med_soil_part) length(high_soil_part)];
    
    inclineup_part=Xtest(find(Xtest(:,25)==4),1);
    low_inclineup_part=inclineup_part(find(inclineup_part<1.5e+7),1);
    med_inclineup_part=inclineup_part(find(inclineup_part>1.5e+7 & inclineup_part<2.56e+7),1);
    high_inclineup_part=inclineup_part(find(inclineup_part(:,1)>2.5e+7),1);
    A=[length(low_inclineup_part) length(med_inclineup_part) length(high_inclineup_part)];
    
    inclinedown_part=Xtest(find(Xtest(:,25)==5),1);
    low_inclinedown_part=inclinedown_part(find(inclinedown_part<1.5e+7),1);
    med_inclinedown_part=inclinedown_part(find(inclinedown_part>1.5e+7 & inclinedown_part<2.56e+7),1);
    high_inclinedown_part=inclinedown_part(find(inclinedown_part(:,1)>2.5e+7),1);
    B=[length(low_inclinedown_part) length(med_inclinedown_part) length(high_inclinedown_part)];
    
    stairsup_part=Xtest(find(Xtest(:,25)==6),1);
    low_stairsup_part=stairsup_part(find(stairsup_part<1.5e+7),1);
    med_stairsup_part=stairsup_part(find(stairsup_part>1.5e+7 & stairsup_part<2.56e+7),1);
    high_stairsup_part=stairsup_part(find(stairsup_part(:,1)>2.5e+7),1);
    C=[length(low_stairsup_part) length(med_stairsup_part) length(high_stairsup_part)];
    
    stairsdown_part=Xtest(find(Xtest(:,25)==7),1);
    low_stairsdown_part=stairsdown_part(find(stairsdown_part<1.5e+7),1);
    med_stairsdown_part=stairsdown_part(find(stairsdown_part>1.5e+7 & stairsdown_part<2.56e+7),1);
    high_stairsdown_part=stairsdown_part(find(stairsdown_part(:,1)>2.5e+7),1);
    D=[length(low_stairsdown_part) length(med_stairsdown_part) length(high_stairsdown_part)];
        
    y=[X;Y;Z];%;A;B;C;D];
    ax2 = subplot(2,1,2);
    bar(ax2,y,'stacked');
    name = {'asphal';'grass';'gravel path';'inlcineup';'inclinedown';'stairsup';'stairsdown'};
    set(gca,'xticklabel',name);
    ylabel('Denisty')
%     ylim([0 320])
    legend('Low load rate','Medium load rate','High load rate');
    title(['Prediced terrain, Participant ',num2str(participant)]); 
    filename= (['Terrain_Participant',num2str(participant),'.pdf']);
    print(filename,'-dpdf')
end