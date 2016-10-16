clear all
close all
% sample file, where phone is in pocket walking betwen about line 700 and
% 2000 (sampled at 200Hz
 
load accelerationFASTEST.txt
% note that Android coordinates are (with 
% phone in portrait orientation:
% x - left to right across screen
% y - upwards
% z - out of screen
% we will switch z and y so that z points upwards and is roughly vertical
% when the on the back or hip
aMeasured = [accelerationFASTEST(:,2)'; accelerationFASTEST(:,4)'; accelerationFASTEST(:,3)']';
 
% Instead of using the mean, we will filter the data so rotations during
% walking are taken into account
% (NEED TO EDIT THIS DEPENDING ON FREQUENCY OF SENSOR DATA)
[N Wn] = buttord(0.005, 0.03, 5, 40); % for 200Hz data this has a 1Hz passband, 6Hz stopband, 5 db passband ripple and 40db stopband attenuation 
[b a] = butter(N, Wn, 'low');
 
for i=1:3
% apply low-pass filter to get gravity component
aMeasuredFiltered(:,i) = filtfilt(b,a,aMeasured(:,i));
end
% plot filtered data
figure
plot(aMeasuredFiltered)
hold on
% check norm is ~constant
plot(sqrt(sum(aMeasuredFiltered.^2,2)),'k--')
 
 
for i=1:length(aMeasured)
% estimate gravity from filtered acceleration
X = aMeasuredFiltered(i,1);
Y = aMeasuredFiltered(i,2);
Z = aMeasuredFiltered(i,3);
 
g = sqrt(X^2 + Y^2 + Z^2);
 
% find roation about x
phi(i) = atan2(Y,X);
% find roation about y
theta(i) = atan2(-X, sqrt(Y^2 + Z^2));
% no gravity change with rotation about z!)
 
% assemble rotation matrix
Rx = [1 0 0; 0 cos(phi(i)) sin(phi(i)); 0 -sin(phi(i)) cos(phi(i))];
Ry = [cos(theta(i)) 0 -sin(theta(i)); 0 1 0; sin(theta(i)) 0 cos(theta(i))];
R = Rx*Ry;
 
% remove gravity and transform accelerations to earth coordinate system
aLoad(i,:)=inv(R)*[0 0 -g]' - aMeasured(i,:)';
end
 
%plot measured data
figure
plot(aMeasured(:,1),'r')
hold on
plot(aMeasured(:,2),'g')
plot(aMeasured(:,3),'b')
 
% plot data with gravity removed and transformed to earth coordinate system
figure
plot(aLoad(:,1),'r')
hold on
plot(aLoad(:,2),'g')
plot(aLoad(:,3),'b')
 
% plot rotation angles
figure
plot(phi.*(180/pi),'r')
hold on
plot(theta.*(180/pi),'b')