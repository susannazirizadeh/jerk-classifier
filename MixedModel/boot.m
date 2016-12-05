%% Bootstrapping the LR_FP data and LR_SP data 
% 1. Bootstrap data
% 2. Identify data of the bootam matrix
% 3. Model a linear mixed regression model with bootam model
% 4. Plot histogram of every models mean
% 5. Calculate the convidance interval 95% of the model 
%% 1. Boot straping data
load results_loadrate
for button=1:4
    C=([results_loadrate.treadmill{button}{2}(:,7:end);results_loadrate.treadmill{button}{3}(:,:);results_loadrate.treadmill{button}{4}(:,:);results_loadrate.treadmill{button}{5}(:,:);results_loadrate.treadmill{button}{6}(:,:);results_loadrate.treadmill{button}{7}(:,:);results_loadrate.treadmill{button}{8}(:,:);results_loadrate.treadmill{button}{9}(:,:);results_loadrate.treadmill{button}{10}(:,:);results_loadrate.treadmill{button}{11}(:,:);results_loadrate.treadmill{button}{12}(:,:)]);
    [bootstat,bootsam] = bootstrp(1000,@corr,C(:,1),C(:,1));
    for nboot=1:1000
        j=1;
        for n=1:length(C)
            j=j+1;
            bootsmodel{nboot}(j,1:5)=C(bootsam(n,nboot),1:5);
            
        end
    end
    for nboot=1:1000
        tbl= table(bootsmodel{nboot}(:,1),bootsmodel{nboot}(:,2),bootsmodel{nboot}(:,3),bootsmodel{nboot}(:,4),bootsmodel{nboot}(:,5),'VariableNames',{'ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
        lme1=  fitlme(tbl,'ForceRateFP~JerkSmartphone+(1|Participant)+(JerkSmartphone-1|Participant)');  % Mixed model with random effect intercept and coefficient
        lme2=  fitlme(tbl,'ForceRateFP~JerkSmartphone+(1|Participant)');   % Mixed model with random effect intercept
        lme3=  fitlme(tbl,'ForceRateFP~JerkSmartphone');
        F1=predict(lme1,tbl);
        F2=predict(lme2,tbl);
        F3=predict(lme3,tbl);
        for  n=1:size(tbl)
            sum1_1(n,1)=(tbl.ForceRateFP(n,1) -F1(n,1)).^2;
            sum1_2(n,1)=(tbl.ForceRateFP(n,1) - nanmean(tbl.ForceRateFP(:,1))).^2;
            sum2_1(n,1)=(tbl.ForceRateFP(n,1) -F2(n,1)).^2;
            sum2_2(n,1)=(tbl.ForceRateFP(n,1) - nanmean(tbl.ForceRateFP(:,1))).^2;
            sum3_1(n,1)=(tbl.ForceRateFP(n,1) -F3(n,1)).^2;
            sum3_2(n,1)=(tbl.ForceRateFP(n,1) - nanmean(tbl.ForceRateFP(:,1))).^2;
        end
        stats{button}(nboot,1)=  1 - (nansum(sum1_1)/nansum(sum1_2));
        stats{button}(nboot,2)=  1 - (nansum(sum2_1)/nansum(sum2_2));
        stats{button}(nboot,3)=  1 - (nansum(sum3_1)/nansum(sum3_2));
    end
    pd1{button}= fitdist(stats{button}(:,1),'Normal');
    pd2{button}= fitdist(stats{button}(:,2),'Normal');
    pd3{button}= fitdist(stats{button}(:,2),'Normal');
    ci_1{button} = paramci(pd1{button});
    ci_2{button}= paramci(pd2{button});
    ci_3{button} = paramci(pd3{button});
end