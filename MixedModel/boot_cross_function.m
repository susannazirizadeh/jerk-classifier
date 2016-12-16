%% This code will resample 1000 indexes of the original sample data and then cross validated it 1000 times
load results_loadrate
final_error=zeros(4,6);
for device= 1:4
    LOOerror=zeros(1000,3);
    C=([results_loadrate.treadmill{device}{2}(7:end,:);results_loadrate.treadmill{device}{3}(:,:);results_loadrate.treadmill{device}{4}(:,:);results_loadrate.treadmill{device}{5}(:,:);results_loadrate.treadmill{device}{6}(:,:);results_loadrate.treadmill{device}{7}(:,:);results_loadrate.treadmill{device}{8}(:,:);results_loadrate.treadmill{device}{9}(:,:);results_loadrate.treadmill{device}{10}(:,:);results_loadrate.treadmill{device}{11}(:,:);results_loadrate.treadmill{device}{12}(:,:)]);
    n=250;
    bootindex{device}(:,:)=randi(length(C),n,1000);
    parfor nboot=1:1000
        LOOerror(nboot,:)=loofun(C,bootindex{device}(:,nboot))
        display(nboot)
    end
    final_error(device,1)=sqrt(mean(LOOerror(:,1).^2));
    final_error(device,2)=sqrt(mean(LOOerror(:,2).^2));
    final_error(device,3)=sqrt(mean(LOOerror(:,3).^2));
    final_error(device,4)= mean(LOOerror(:,4));
    final_error(device,5)= mean(LOOerror(:,5));
    final_error(device,6)= mean(LOOerror(:,6));
end
