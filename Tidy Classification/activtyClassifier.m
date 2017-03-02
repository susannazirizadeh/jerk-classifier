function [accuracy] = activtyClassifier(trainingData)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
for i=1:100
    participant = randi([1,11],1,1);
X=trainingData(find(trainingData(:,24)~=participant),:);

inputTable = array2table(X, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});

predictorNames = {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'condition', 'weight', 'ID'};
predictors = inputTable(:, predictorNames);
response = inputTable.speed;

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
    'ClassNames', [1; 2; 3; 4; 5]);

trainedClassifier.ClassificationSVM = classificationSVM;

Xtest=trainingData(find(trainingData(:,24)==participant),:);
inputTable_test = array2table(Xtest, 'VariableNames', {'mean_loadrate', 'max_loadrate', 'min_loadrate', 'var_loadrate', 'STD_loadrate', 'RMS_loadrate', 'mean_f_loadrate', 'dom_f_loadrate', 'energy_loadrate', 'entropy_loadrate', 'mean_load', 'max_load', 'min_load', 'var_load', 'STD_load', 'RMS_load', 'mean_f_load', 'dom_f_load', 'energy_load', 'entropy_load', 'speed', 'condition', 'weight', 'ID'});
predictors_test = inputTable_test(:, predictorNames);
response_test = inputTable_test.condition;

label= predict(trainedClassifier.ClassificationSVM,inputTable_test);
true=find(label==response_test);
error=(find((label==response_test)==0));
accuracy(i,1)=length(error)/length(label);

end 

end

