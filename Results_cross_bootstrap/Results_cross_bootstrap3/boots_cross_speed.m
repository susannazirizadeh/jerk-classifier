%% This code will resample 1000 indexes of the original sample data and then cross validated it 1000 times
load results_loadrate
final_error1=zeros(4,12);
final_error2=zeros(4,12);
final_error3=zeros(4,12);
speed= cellstr(['5km/h ';'8km/h ';'12km/h']);
tic
for device= 1:4
        C5=([results_loadrate.treadmill{device}{3}(1:6,:);results_loadrate.treadmill{device}{4}(1:6,:);results_loadrate.treadmill{device}{5}(1:6,:);results_loadrate.treadmill{device}{6}(1:6,:);results_loadrate.treadmill{device}{7}(1:6,:);results_loadrate.treadmill{device}{8}(1:6,:);results_loadrate.treadmill{device}{9}(1:6,:);results_loadrate.treadmill{device}{10}(1:6,:);results_loadrate.treadmill{device}{11}(1:6,:);results_loadrate.treadmill{device}{12}(1:6,:)]);
        C8=([results_loadrate.treadmill{device}{2}(7:12,:);results_loadrate.treadmill{device}{3}(7:12,:);results_loadrate.treadmill{device}{4}(7:12,:);results_loadrate.treadmill{device}{5}(7:12,:);results_loadrate.treadmill{device}{6}(7:12,:);results_loadrate.treadmill{device}{7}(7:12,:);results_loadrate.treadmill{device}{8}(7:12,:);results_loadrate.treadmill{device}{9}(7:12,:);results_loadrate.treadmill{device}{10}(7:12,:);results_loadrate.treadmill{device}{11}(7:12,:);results_loadrate.treadmill{device}{12}(7:12,:)]);
        C12=([results_loadrate.treadmill{device}{2}(13:18,:);results_loadrate.treadmill{device}{3}(13:18,:);results_loadrate.treadmill{device}{4}(13:18,:);results_loadrate.treadmill{device}{5}(13:18,:);results_loadrate.treadmill{device}{6}(13:18,:);results_loadrate.treadmill{device}{7}(13:18,:);results_loadrate.treadmill{device}{8}(13:18,:);results_loadrate.treadmill{device}{9}(13:18,:);results_loadrate.treadmill{device}{10}(13:18,:);results_loadrate.treadmill{device}{11}(13:18,:);results_loadrate.treadmill{device}{12}(13:18,:)]);
        LOOerror1=zeros(1000,6);
        LOOerror2=zeros(1000,6);
        LOOerror3=zeros(1000,6);
        n=250;
        bootindex{device}{o}(:,:)=randi(length(C{o}),n,1000);
        parfor nboot=1:1000
            LOOerror1(nboot,:)=loofun(C5,bootindex{device}{1}(:,nboot))
            display(nboot)
            LOOerror2(nboot,:)=loofun(C8,bootindex{device}{2}(:,nboot))
            display(nboot)
            LOOerror3(nboot,:)=loofun(C12,bootindex{device}{3}(:,nboot))
            display(nboot)
        end
        % 5km/h 
        final_error1(device,1)=mean(LOOerror1(:,1));   % Mean squard error linear regression model 1
        sorted=sort(LOOerror1(:,1));                 % sorting the vector by the value
        final_error1(device,2)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
        final_error1(device,3)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
        
        final_error1(device,4)=mean(LOOerror1(:,2));  % Mean squard error linear regression model 2
        sorted=sort(LOOerror1(:,2));                 % sorting the vector by the value
        final_error1(device,5)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
        final_error1(device,6)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
        
        final_error1(device,7)=mean(LOOerror1(:,3));  % Mean squard error linear regression model 3
        sorted=sort(LOOerror1(:,3));                 % sorting the vector by the value
        final_error1(device,8)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
        final_error1(device,9)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
        
        final_error1(device,10)= mean(LOOerror1(:,4));% R^2 value linear regression model 1
        sorted=sort(LOOerror1(:,4));                 % sorting the vector by the value
        final_error1(device,11)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
        final_error1(device,12)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
        
        final_error1(device,13)= mean(LOOerror1(:,5));% R^2 value linear regression model 2
        sorted=sort(LOOerror1(:,5));                 % sorting the vector by the value
        final_error1(device,14)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
        final_error1(device,15)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
        
        final_error1(device,16)= mean(LOOerror1(:,6));% R^2 value linear regression model 3
        sorted=sort(LOOerror1(:,6));                 % sorting the vector by the value
        final_error1(device,17)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
        final_error1(device,18)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
        
        % 8km/h
                final_error2(device,1)=mean(LOOerror2(:,1));   % Mean squard error linear regression model 1
        sorted=sort(LOOerror2(:,1));                 % sorting the vector by the value
        final_error2(device,2)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
        final_error2(device,3)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
        
        final_error2(device,4)=mean(LOOerror2(:,2));  % Mean squard error linear regression model 2
        sorted=sort(LOOerror2(:,2));                 % sorting the vector by the value
        final_error2(device,5)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
        final_error2(device,6)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
        
        final_error2(device,7)=mean(LOOerror2(:,3));  % Mean squard error linear regression model 3
        sorted=sort(LOOerror2(:,3));                 % sorting the vector by the value
        final_error2(device,8)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
        final_error2(device,9)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
        
        final_error2(device,10)= mean(LOOerror2(:,4));% R^2 value linear regression model 1
        sorted=sort(LOOerror2(:,4));                 % sorting the vector by the value
        final_error2(device,11)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
        final_error2(device,12)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
        
        final_error2(device,13)= mean(LOOerror2(:,5));% R^2 value linear regression model 2
        sorted=sort(LOOerror2(:,5));                 % sorting the vector by the value
        final_error2(device,14)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
        final_error2(device,15)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
        
        final_error2(device,16)= mean(LOOerror2(:,6));% R^2 value linear regression model 3
        sorted=sort(LOOerror2(:,6));                 % sorting the vector by the value
        final_error2(device,17)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
        final_error2(device,18)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
        
        % 12km/h
                final_error3(device,1)=mean(LOOerror3(:,1));   % Mean squard error linear regression model 1
        sorted=sort(LOOerror3(:,1));                 % sorting the vector by the value
        final_error3(device,2)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
        final_error3(device,3)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
        
        final_error3(device,4)=mean(LOOerror3(:,2));  % Mean squard error linear regression model 2
        sorted=sort(LOOerror3(:,2));                 % sorting the vector by the value
        final_error3(device,5)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
        final_error3(device,6)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
        
        final_error3(device,7)=mean(LOOerror3(:,3));  % Mean squard error linear regression model 3
        sorted=sort(LOOerror3(:,3));                 % sorting the vector by the value
        final_error3(device,8)= sorted(25);          % confidence interval lower bound with 2,5% for 95%
        final_error3(device,9)= sorted(975);         % confidence interval upper bound with 97,5% for 95%
        
        final_error3(device,10)= mean(LOOerror3(:,4));% R^2 value linear regression model 1
        sorted=sort(LOOerror3(:,4));                 % sorting the vector by the value
        final_error3(device,11)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
        final_error3(device,12)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
        
        final_error3(device,13)= mean(LOOerror3(:,5));% R^2 value linear regression model 2
        sorted=sort(LOOerror3(:,5));                 % sorting the vector by the value
        final_error3(device,14)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
        final_error3(device,15)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
        
        final_error3(device,16)= mean(LOOerror3(:,6));% R^2 value linear regression model 3
        sorted=sort(LOOerror3(:,6));                 % sorting the vector by the value
        final_error3(device,17)= sorted(25);         % confidence interval lower bound with 2,5% for 95%
        final_error3(device,18)= sorted(975);        % confidence interval upper bound with 97,5% for 95%
        
        savefile=['device', num2str(device), '.mat'];
        save(savefile)
end
toc