load featurematrix_loadrate
new=featurematrix_loadrate(find(featurematrix_loadrate(:,11)==1),:);
new_use=new(:,1);
new_use=new(find(new(:,1)<10e+3),1);

[f,xi]= ksdensity(new_use);
mloadrate=mean(new_use);
mf=mean(f);
maxf=max(f);
figure
plot(xi,f);
hold on
plot(mloadrate,f,'r.');
plot(3528,maxf,'b.');

%%
figure
histfit(new_use)
%% kstest
kstest((new_use-mean(new_use))/std(new_use))
%% Fit a normal distribution to the density distribution

pd = fitdist(new_use,'Normal')
x_values = -1000:11000/100:10000;
y = pdf(pd,x_values);
figure(1)
hold on
plot(x_values,y,'LineWidth',2);
%% Defining upper and lower bound
lower_bound=mean(new_use)-std(new_use);
upper_bound=mean(new_use)+std(new_use);