%% This code will resample 1000 indexes of the original sample data and then cross validated it 1000 times
load results_loadrate
Looerror=zeros(1000,3);
for device= 1:4
    C=([results_loadrate.treadmill{device}{2}(7:end,:);results_loadrate.treadmill{device}{3}(:,:);results_loadrate.treadmill{device}{4}(:,:);results_loadrate.treadmill{device}{5}(:,:);results_loadrate.treadmill{device}{6}(:,:);results_loadrate.treadmill{device}{7}(:,:);results_loadrate.treadmill{device}{8}(:,:);results_loadrate.treadmill{device}{9}(:,:);results_loadrate.treadmill{device}{10}(:,:);results_loadrate.treadmill{device}{11}(:,:);results_loadrate.treadmill{device}{12}(:,:)]);
    n=250;
    bootindex{device}(:,:)=randi(length(C),n,1000);
    parfor nboot=1%:1000
        LOOerror(nboot,:)=loofun(C,bootindex{device}(:,nboot))
    end
    final_error(1,1)=sqrt(mean(LOOerror(:,1).^2))
    final_error(1,2)=sqrt(mean(LOOerror(:,2).^2))
    final_error(1,3)=sqrt(mean(LOOerror(:,3).^2))
end