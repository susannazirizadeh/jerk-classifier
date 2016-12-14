%% Bootstrapping the LR_FP data and LR_SP data 
% 1. Bootstrap data
% 2. Identify data of the bootam matrix
% 3. Model a linear mixed regression model with bootam model
% 4. Cross-validate the bootstrapped data 1000 times 
% 5. Plot histogram of every models mean
% 6. Calculate the convidance interval 95% of the model 
%% 1. Boot straping data
load results_loadrate
for button=1:4
    % C is excluding data for 5,8,12km/h of P1 and 5km/h of P2
    C=([results_loadrate.treadmill{button}{2}(:,7:end);results_loadrate.treadmill{button}{3}(:,:);results_loadrate.treadmill{button}{4}(:,:);results_loadrate.treadmill{button}{5}(:,:);results_loadrate.treadmill{button}{6}(:,:);results_loadrate.treadmill{button}{7}(:,:);results_loadrate.treadmill{button}{8}(:,:);results_loadrate.treadmill{button}{9}(:,:);results_loadrate.treadmill{button}{10}(:,:);results_loadrate.treadmill{button}{11}(:,:);results_loadrate.treadmill{button}{12}(:,:)]);
    [bootstat,bootsam] = bootstrp(1000,@corr,C(:,1),C(:,1)); % bootstrapping data with correletion and data points
    for nboot=1:1000 %bootstrapping number, how often should the experiment be repetead
        for crossval= 1:1000
            bootsam_cross{crossval}=bootsam;
            exclude=randi([0 length(C)],1,1);
            temp=find(bootsam_cross{crossval}(:,nboot));
            bootsam_cross2{crossval}(:,nboot)=bootsam_cross{crossval}(find(bootsam_cross{crossval}(temp,nboot)~= exclude),nboot);
            j=1;
            for n=1:length(C)% how often within an experiment should be re-drawed
                j=j+1;
                bootsmodel{crossval}{nboot}(j,2:6)=C(bootsam_cross2{crossval}(n,nboot),2:6); % 2. Identify data of bootam matrix
                bootsmodel{crossval}{nboot}(j,1)=bootsam_cross2{crossval}(n,nboot);% Including bootsam data in first colume
            end
        end
    end
    for nboot=1:1000
       for crossval= 1:1000 
        tbl{crossval}= table(bootsmodel{crossval}{nboot}(:,1),bootsmodel{crossval}{nboot}(:,2),bootsmodel{crossval}{nboot}(:,3),bootsmodel{crossval}{nboot}(:,4),bootsmodel{crossval}{nboot}(:,5),bootsmodel{crossval}{nboot}(:,6),'VariableNames',{'IndexBootstrap','ForceRateFP','JerkSmartphone','Speed','BW','Participant'});
        lme1=  fitlme(tbl{crossval},'ForceRateFP~JerkSmartphone+(1|Participant)+(JerkSmartphone-1|Participant)');  % Mixed model with random effect intercept and coefficient
        lme2=  fitlme(tbl{crossval},'ForceRateFP~JerkSmartphone+(1|Participant)');   % Mixed model with random effect intercept
        lme3=  fitlme(tbl{crossval},'ForceRateFP~JerkSmartphone');
        F1=predict(lme1,tbl{crossval});
        F2=predict(lme2,tbl{crossval});
        F3=predict(lme3,tbl{crossval});
        for  n=1:size(tbl{crossval})
            sum1_1(n,1)=(tbl.ForceRateFP(n,1) -F1(n,1)).^2;
            sum1_2(n,1)=(tbl.ForceRateFP(n,1) - nanmean(tbl.ForceRateFP(:,1))).^2;
            sum2_1(n,1)=(tbl.ForceRateFP(n,1) -F2(n,1)).^2;
            sum2_2(n,1)=(tbl.ForceRateFP(n,1) - nanmean(tbl.ForceRateFP(:,1))).^2;
            sum3_1(n,1)=(tbl.ForceRateFP(n,1) -F3(n,1)).^2;
            sum3_2(n,1)=(tbl.ForceRateFP(n,1) - nanmean(tbl.ForceRateFP(:,1))).^2;
        end
        stats{button}{crossval}(nboot,1)=  1 - (nansum(sum1_1)/nansum(sum1_2));
        stats{button}{crossval}(nboot,2)=  1 - (nansum(sum2_1)/nansum(sum2_2));
        stats{button}{crossval}(nboot,3)=  1 - (nansum(sum3_1)/nansum(sum3_2));
       end 
    end
    for crossval= 1:1000
    pd1{button}{crossval}= fitdist(stats{button}{crossval}(:,1),'Normal');
    pd2{button}{crossval}= fitdist(stats{button}{crossval}(:,2),'Normal');
    pd3{button}{crossval}= fitdist(stats{button}{crossval}(:,2),'Normal');
    ci_1{button}{crossval} = paramci(pd1{button}{crossval});
    ci_2{button}{crossval}= paramci(pd2{button}{crossval});
    ci_3{button}{crossval} = paramci(pd3{button}{crossval});
    end 
    
end