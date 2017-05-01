function [accuracy,participant] = terrainClassifier(trainingData)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
accuracy=zeros(100,1);
for i=1:100  
    A=1:12;
    B=5;
    S = setdiff(A,B);
    participant = S(randi(numel(S),1,1)); % Random sample of participant excluding 5th participant, he didn't take part 
    X=trainingData(find(trainingData(:,24)~=participant),:); % excluding random participants from data set for validation
    temp=randi(length(X),length(X),1); 
    Xnew=X(temp,:);   %resampled vector 
    inputTable = array2table(Xnew, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});
    
    predictorNames = {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'weight', 'ID'};
    predictors = inputTable(:, predictorNames);
    response = inputTable.condition;
    
    % Train a classifier
    % This code specifies all the classifier options and trains the classifier.
    template = templateSVM(...
        'KernelFunction', 'gaussian', ...
        'PolynomialOrder', [], ...
        'KernelScale', 1.2, ...
        'BoxConstraint', 1, ...
        'Standardize', true);
    classificationSVM = fitcecoc(...
        predictors, ...
        response, ...
        'Learners', template, ...
        'Coding', 'onevsone', ...
        'ClassNames', [1; 2; 3]);%; 4; 5; 6 ;7]);
    
%         partitionedModel = crossval(classificationSVM, 'KFold', 11);
%     accuracy(i,1) = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
    Xtest=trainingData(find(trainingData(:,24)==participant),:);  % test data for validation 
    inputTable_test = array2table(Xtest, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});
    predictors_test = inputTable_test(:, predictorNames);
    response_test = inputTable_test.condition;
    
    label= predict(classificationSVM,inputTable_test);      % testing data
    wahr=(find((label==response_test)==1));                % errors in labeling
    accuracy(i,1)=length(wahr)/length(label);              % accuracy calculated from error and all data
end

end

