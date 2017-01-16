%% This code will resample 1000 indexes of the original sample data and then cross validated it 1000 times
load results_loadrate
final_error=zeros(4,6);
tic
for device= 1:4
    LOOerror=zeros(1000,6);
    C=([results_loadrate.treadmill{device}{2}(7:end,:);results_loadrate.treadmill{device}{3}(:,:);results_loadrate.treadmill{device}{4}(:,:);results_loadrate.treadmill{device}{5}(:,:);results_loadrate.treadmill{device}{6}(:,:);results_loadrate.treadmill{device}{7}(:,:);results_loadrate.treadmill{device}{8}(:,:);results_loadrate.treadmill{device}{9}(:,:);results_loadrate.treadmill{device}{10}(:,:);results_loadrate.treadmill{device}{11}(:,:);results_loadrate.treadmill{device}{12}(:,:)]);
    n=250;
    bootindex{device}(:,:)=randi(length(C),n,1000);
    parfor nboot=1:1000
        LOOerror(nboot,:)=loofun(C,bootindex{device}(:,nboot))
        display(nboot)
    end
    final_error(device,1)=sqrt(mean(LOOerror(:,1).^2)); % Mean squard error linear regression model 1
    final_error(device,2)=sqrt(mean(LOOerror(:,2).^2));% Mean squard error linear regression model 2
    final_error(device,3)=sqrt(mean(LOOerror(:,3).^2));% Mean squard error linear regression model 3
    final_error(device,4)= mean(LOOerror(:,4));%R^2 value linear regression model 1
    final_error(device,7)= mean(LOOerror(:,5));%R^2 value linear regression model 2
    final_error(device,10)= mean(LOOerror(:,6));%R^2 value linear regression model 3
    
    SEM = std(LOOerror(:,4))/sqrt(length(LOOerror(:,4)));   % Standard Error
    ts = tinv([0.025  0.975],length(LOOerror(:,4))-1);      % T-Score
    CI1 = mean(LOOerror(:,4)) + ts*SEM;
    final_error(device,5)=CI1(1,1);
    final_error(device,6)=CI1(1,2);
    
    SEM = std(LOOerror(:,5))/sqrt(length(LOOerror(:,5)));   % Standard Error
    ts = tinv([0.025  0.975],length(LOOerror(:,5))-1);      % T-Score
    CI2 = mean(LOOerror(:,5)) + ts*SEM;
    final_error(device,8)=CI2(1,1);
    final_error(device,9)=CI2(1,2);
    
    SEM = std(LOOerror(:,6))/sqrt(length(LOOerror(:,6)));   % Standard Error
    ts = tinv([0.025  0.975],length(LOOerror(:,6))-1);      % T-Score
    CI3 = mean(LOOerror(:,6)) + ts*SEM;
    final_error(device,11)=CI3(1,1);
    final_error(device,12)=CI3(1,2);
end
toc