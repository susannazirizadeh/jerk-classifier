function [ LOOerror] = loofun( data,index )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for crossval=1:1000
    exclude(crossval,1)=randi(length(data),1,1);
    temp=index(find(index(:,1)~=exclude(crossval,1)),1);
    newindex(1:192,1)=temp(1:192,1);
    % Building the bootstraped and excluded data
    bootsmodel(1:length(data),:)=data(newindex(1:length(data),1),:);
    % Building three models
    tbl= table(bootsmodel(:,1),bootsmodel(:,2),bootsmodel(:,3),bootsmodel(:,4),bootsmodel(:,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
    lme1=  fitlme(tbl,'ForceRateFP~JerkSmartphone+(1|Participant)+(JerkSmartphone-1|Participant)');  % Mixed model with random effect intercept and coefficient
    lme2=  fitlme(tbl,'ForceRateFP~JerkSmartphone+(1|Participant)');   % Mixed model with random effect intercept
    lme3=  fitlme(tbl,'ForceRateFP~JerkSmartphone');
    % Predict the model
    F1=predict(lme1,tbl);
    F2=predict(lme2,tbl);
    F3=predict(lme3,tbl);
    % Mean squard error
    LOOerror(1,1)= nansum((tbl.ForceRateFP(1:size(tbl),1) -F1(1:size(tbl),1)).^2)/size(tbl,1);
    LOOerror(1,2)= nansum((tbl.ForceRateFP(1:size(tbl),1) -F2(1:size(tbl),1)).^2)/size(tbl,1);
    LOOerror(1,3)= nansum((tbl.ForceRateFP(1:size(tbl),1) -F3(1:size(tbl),1)).^2)/size(tbl,1);
    
end

end


