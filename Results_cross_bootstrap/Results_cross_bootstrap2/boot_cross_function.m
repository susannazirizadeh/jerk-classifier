%% This code will resample 1000 indexes of the original sample data and then cross validated it 1000 times
load results_loadrate
final_error=zeros(4,6);
tic
for device= 1:3%4
    LOOerror=zeros(1000,6);
    C=([results_loadrate.treadmill{device}{2}(7:end,:);results_loadrate.treadmill{device}{3}(:,:);results_loadrate.treadmill{device}{4}(:,:);results_loadrate.treadmill{device}{5}(:,:);results_loadrate.treadmill{device}{6}(:,:);results_loadrate.treadmill{device}{7}(:,:);results_loadrate.treadmill{device}{8}(:,:);results_loadrate.treadmill{device}{9}(:,:);results_loadrate.treadmill{device}{10}(:,:);results_loadrate.treadmill{device}{11}(:,:);results_loadrate.treadmill{device}{12}(:,:)]);
    n=250;
    bootindex{device}(:,:)=randi(length(C),n,1000);
    parfor nboot=1:1000
        LOOerror(nboot,:)=loofun(C,bootindex{device}(:,nboot))
        display(nboot)
    end
    final_error(device,1)=mean(LOOerror(:,1));   % Mean squard error linear regression model 1
    sorted=sort(LOOerror(:,1));                 % sorting the vector by the value
    final_error(device,2)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
    final_error(device,3)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
    
    final_error(device,4)=mean(LOOerror(:,2));  % Mean squard error linear regression model 2
    sorted=sort(LOOerror(:,2));                 % sorting the vector by the value
    final_error(device,5)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
    final_error(device,6)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
    
    final_error(device,7)=mean(LOOerror(:,3));  % Mean squard error linear regression model 3
    sorted=sort(LOOerror(:,3));                 % sorting the vector by the value
    final_error(device,8)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
    final_error(device,9)= sorted(975);         % confidence interval upper bound with 97,5% for 95%

    final_error(device,10)= mean(LOOerror(:,4));% R^2 value linear regression model 1
    sorted=sort(LOOerror(:,4));                 % sorting the vector by the value
    final_error(device,11)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
    final_error(device,12)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
    
    final_error(device,13)= mean(LOOerror(:,5));% R^2 value linear regression model 2
    sorted=sort(LOOerror(:,5));                 % sorting the vector by the value
    final_error(device,14)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
    final_error(device,15)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
    
    final_error(device,16)= mean(LOOerror(:,6));% R^2 value linear regression model 3
    sorted=sort(LOOerror(:,6));                 % sorting the vector by the value
    final_error(device,17)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
    final_error(device,18)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
    
    savefile=['device', num2str(device), '.mat'];
    save(savefile)
end
toc