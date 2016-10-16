
t=raw_data.treadmill{1}{3}{1}{1}(3000:8000,1);
x=raw_data.treadmill{1}{3}{1}{1}(3000:8000,3); % change to acceleration in direction of gravity
plot(t,x)


tnew=t/10^3;
sps=round(1/mean(tnew(2:end,1)-tnew(1:end-1,1)));
n=length(tnew);
j=zeros(n,1);
j(2:end)=(x(2:end)-x(1:end-1))./(1/sps);

mean(j(find(j>0)))


figure
hold on
plot(t,raw_data.treadmill{1}{3}{1}{1}(3000:8000,2),'r')
plot(t,raw_data.treadmill{1}{3}{1}{1}(3000:8000,3),'g')
plot(t,raw_data.treadmill{1}{3}{1}{1}(3000:8000,4),'b')


X=mean(raw_data.treadmill{1}{3}{1}{1}(3000:8000,2))
Y=mean(raw_data.treadmill{1}{3}{1}{1}(3000:8000,3))
Z=mean(raw_data.treadmill{1}{3}{1}{1}(3000:8000,4))

sqrt(X^2+Y^2+Z^2)