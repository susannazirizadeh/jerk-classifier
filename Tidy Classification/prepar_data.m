%% Preparing acceleration data for classification
% 1. PSD estimate for cut-off frequency
% 2. Filter data with band-pass filter
% 3. Feature extraction of 'Load rate' (Time-domain & Frequency-domain)
% 4. Feature extraction of acc, (Time-domain & Frequency-domain)
% 5. Feature matrix
% 6. SVM classifier activity (walking, jogging, running,incline up, incline down, stairs up, stairs down)
% 7. SVM classifier for terrains (asphalt, grass, stony/muddy path)
% load raw_int
% partic= cellstr(['P1 ';'P2 ';'P3 ';'P4 ';'P5 ';'P6 ';'P7 ';'P8 ';'P9 ';'P10';'P11';'P12']);
% device  = cellstr(['SP1';'SW1';'GPS']);
% speed = cellstr(['5km/h ';'8km/h ';'12km/h';'slow  ';'fast  ']);
% con= cellstr(['asphalt    ';'grass      ';'soil       ';'inlcineup  ';'inclinedown';'stairsup   ';'stairsdown ']);
% weight= [67.1; 79.4; 63.2; 77.1; 63.5; 72.7; 65.5; 84.8; 70.5; 77.5; 70.6; 62.7]; %Weights of each participants
%% 1. PSD estimate for cut-off frequency (Welch's PSD estimate)
%  for i=6:7
% x= raw_int.outdoor{2}{1}{4}{i}(:,2);
% t= raw_int.outdoor{2}{1}{4}{i}(:,1);
% fs= 99;
%  m=360; %in sec
% [P,f]=pwelch(x,hanning(m),m/2,m,fs);
% figure; hold on;
% semilogy(f,P);
%  end

% decided cut-off filter 0.5 Hz and 10Hz
%% 2. Filter data with band pass filter cut of 0.5Hz and 15Hz
% Bandpass filter for cascade cell array
% [ raw_filt.outdoor ] = cascade( @allocation_empty,@bandpass,raw_int.outdoor,0,0,0,0);

%%   3. Feature extraction of 'Load rate' window size= 4s
%      3.1 Time-domain (mean, variance, correlation, min, max, STD, RMS) %  3.2 Frequency-domain (FFT, main F, max, F, energy, entropy)
% [ features.loadrate ] = cascade( @allocation_empty,@features_loadrate,raw_int.outdoor,700,100,1000,50);
% [ features.jerk ] = cascade( @allocation_empty,@features_jerk,raw_filt.outdoor, 400,100,500,50);

%%   4. Feature extraction of 'Load' window size= 4s
%      3.1 Time-domain (mean, variance, correlation, min, max, STD, RMS) %  3.2 Frequency-domain (FFT, main F, max, F, energy, entropy)
% [ features.load ] = cascade( @allocation_empty,@features_load,raw_int.outdoor, 700,100,1000,50);
% [ features.acc ] = cascade( @allocation_empty,@features_acc,raw_filt.outdoor, 400,100,500,50);

%%  5. Feature matrix
% [ featurematrix_loadrate ] = matrixmaker( features.loadrate);
% [ featurematrix_load ] = matrixmaker( features.load);
% featurematrix(:,1:10)= featurematrix_loadrate(:,1:10);
% featurematrix(:,11:24)= featurematrix_load(:,1:14);
 

%% 6.SVM classifier activity (walking, jogging, running, incline up, incline down, stairs up, stairs down)
% Trained and tested data, Random participants was excluded for validation, then cross-validation with 100 repeats
tic
activity_matrix=featurematrix;%(find(featurematrix(:,21)<4),:); % just running on different terrains included
[accuracyActivty] = activityClassifier(activity_matrix);
final_accuracy_ac=mean(accuracyActivty(find(accuracyActivty),1));
x=sort(accuracyActivty);
upperCV_ac=x(84,1);
lowerCV_ac=x(16,1);

[accuracyActivty1] = activityClassifier1(activity_matrix); % mean load, RMS load, energy load, entropy load
final_accuracy_ac1=mean(accuracyActivty1(find(accuracyActivty1),1));
x=sort(accuracyActivty1);
upperCV_ac1=x(84,1);
lowerCV_ac1=x(16,1);

[accuracyActivty2] = activityClassifier2(activity_matrix); % mean load, RMS load, energy load, entropy load, weight
final_accuracy_ac2=mean(accuracyActivty2(find(accuracyActivty2),1));
x=sort(accuracyActivty2);
upperCV_ac2=x(84,1);
lowerCV_ac2=x(16,1);

[accuracyActivty3] = activityClassifier3(activity_matrix); % mean load, RMS load, energy load, entropy load, weight, condition
final_accuracy_ac3=mean(accuracyActivty3(find(accuracyActivty3),1));
x=sort(accuracyActivty3);
upperCV_ac3=x(84,1);
lowerCV_ac3=x(16,1);

[accuracyActivty4] = activityClassifier4(activity_matrix); % mean load rate, RMS load rate, energy load rate, entropy load rate
final_accuracy_ac4=mean(accuracyActivty4(find(accuracyActivty4),1));
x=sort(accuracyActivty4);
upperCV_ac4=x(84,1);
lowerCV_ac4=x(16,1);

[accuracyActivty5] = activityClassifier5(activity_matrix); % mean load rate, RMS load rate, energy load rate, entropy load rate, weight
final_accuracy_ac5=mean(accuracyActivty5(find(accuracyActivty5),1));
x=sort(accuracyActivty5);
upperCV_ac5=x(84,1);
lowerCV_ac5=x(16,1);

[accuracyActivty6] = activityClassifier6(activity_matrix); % mean load rate, RMS load rate, energy load rate, entropy load rate, weight, condition
final_accuracy_ac6=mean(accuracyActivty6(find(accuracyActivty6),1));
x=sort(accuracyActivty6);
upperCV_ac6=x(84,1);
lowerCV_ac6=x(16,1);

%% 7. SVM classifier for terrains (asphalt, grass, stony/muddy path)
% Trained and tested data, Random participant was excluded for validation, then cross-validation with 100 repeats
terrain_matrix=featurematrix; %(find(featurematrix(:,22)<4),:); % just running on different terrains included
[accuracyTerrain] = terrainClassifier(terrain_matrix);  %all features
final_accuracy_te=mean(accuracyTerrain(find(accuracyTerrain),1));
x=sort(accuracyTerrain);
upperCV_te=x(84,1);    % upper convident interval
lowerCV_te=x(16,1);     % lower convident interval

[accuracyTerrain1] = terrainClassifier1(featurematrix); % mean load, RMS load, energy load, entropy load
final_accuracy_te1=mean(accuracyTerrain1(find(accuracyTerrain1),1));
x=sort(accuracyTerrain1);
upperCV_te1=x(84,1);
lowerCV_te1=x(16,1);

[accuracyTerrain2] = terrainClassifier2(featurematrix); % mean load, RMS load, energy load, entropy load, weight
final_accuracy_te2=mean(accuracyTerrain2(find(accuracyTerrain2),1));
x=sort(accuracyTerrain2);
upperCV_te2=x(84,1);
lowerCV_te2=x(16,1);

[accuracyTerrain3] = terrainClassifier3(featurematrix); % mean load, RMS load, energy load, entropy load, weight, condition
final_accuracy_te3=mean(accuracyTerrain3(find(accuracyTerrain3),1));
x=sort(accuracyTerrain3);
upperCV_te3=x(84,1);
lowerCV_te3=x(16,1);

[accuracyTerrain4] = terrainClassifier4(featurematrix); % mean load rate, RMS load rate, energy load rate, entropy load rate
final_accuracy_te4=mean(accuracyTerrain4(find(accuracyTerrain4),1));
x=sort(accuracyTerrain4);
upperCV_te4=x(84,1);
lowerCV_te4=x(16,1);

[accuracyTerrain5] = terrainClassifier5(featurematrix); % mean load rate, RMS load rate, energy load rate, entropy load rate, weight
final_accuracy_te5=mean(accuracyTerrain5(find(accuracyTerrain5),1));
x=sort(accuracyTerrain5);
upperCV_te5=x(84,1);
lowerCV_te5=x(16,1);

[accuracyTerrain6] = terrainClassifier6(featurematrix); % mean load rate, RMS load rate, energy load rate, entropy load rate, weight, condition
final_accuracy_te6=mean(accuracyTerrain6(find(accuracyTerrain6),1));
x=sort(accuracyTerrain6);
upperCV_te6=x(84,1);
lowerCV_te6=x(16,1);

%% Results
results=zeros(7,6);
results(1,1)=final_accuracy_ac;
results(1,2)=lowerCV_ac;
results(1,3)=upperCV_ac;
results(1,4)=final_accuracy_te;
results(1,5)=lowerCV_te;
results(1,6)=upperCV_te;

results(2,1)=final_accuracy_ac1;
results(2,2)=lowerCV_ac1;
results(2,3)=upperCV_ac1;
results(2,4)=final_accuracy_te1;
results(2,5)=lowerCV_te1;
results(2,6)=upperCV_te1;

results(3,1)=final_accuracy_ac2;
results(3,2)=lowerCV_ac2;
results(3,3)=upperCV_ac2;
results(3,4)=final_accuracy_te2;
results(3,5)=lowerCV_te2;
results(3,6)=upperCV_te2;

results(4,1)=final_accuracy_ac3;
results(4,2)=lowerCV_ac3;
results(4,3)=upperCV_ac3;
results(4,4)=final_accuracy_te3;
results(4,5)=lowerCV_te3;
results(4,6)=upperCV_te3;

results(5,1)=final_accuracy_ac4;
results(5,2)=lowerCV_ac4;
results(5,3)=upperCV_ac4;
results(5,4)=final_accuracy_te4;
results(5,5)=lowerCV_te4;
results(5,6)=upperCV_te4;

results(6,1)=final_accuracy_ac5;
results(6,2)=lowerCV_ac5;
results(6,3)=upperCV_ac5;
results(6,4)=final_accuracy_te5;
results(6,5)=lowerCV_te5;
results(6,6)=upperCV_te5;

results(7,1)=final_accuracy_ac6;
results(7,2)=lowerCV_ac6;
results(7,3)=upperCV_ac6;
results(7,4)=final_accuracy_te6;
results(7,5)=lowerCV_te6;
results(7,6)=upperCV_te6;

results_table_smartphone = array2table(results, 'VariableNames', {'accurancy_activity','low_CV_activty','up_CV_activty','accurancy_terrain','low_CV_terrain','up_CV_terrain'});
toc

%% Windo size choice
w2s(1,1)=9889.27;
w2s(1,2)=73;

w3s(1,1)=1564.85;
w3s(1,2)=76;

w4s(1,1)=976.52;
w4s(1,2)=76;

w5s(1,1)=684.23;
w5s(1,2)=77;

w6s(1,1)=560.69;
w6s(1,2)=76;

w7s(1,1)=425.47;
w7s(1,2)=78;

w8s(1,1)=366.95;
w8s(1,2)=77;

% ----------------

w2st(1,1)=9889.27;
w2st(1,2)=63;

w3st(1,1)=1564.85;
w3st(1,2)=64;

w4st(1,1)=976.52;
w4st(1,2)=61;

w5st(1,1)=685.64;
w5st(1,2)=63;

w6st(1,1)=560.36;
w6st(1,2)=61;

w7st(1,1)=425.47;
w7st(1,2)=60;

w8st(1,1)=366.95;
w8st(1,2)=59;

figure
semilogx(w2s(:,1),w2s(:,2),'g*',w3s(1,1),w3s(1,2),'r*', w4s(1,1),w4s(1,2),'b*', w5s(1,1),w5s(1,2),'c*',w6s(1,1),w6s(1,2),'m*',w7s(1,1),w7s(1,2),'k*',w8s(1,1),w8s(1,2),'ko','LineWidth',2,'MarkerSize',10);
legend('Window size 2s','Window size 3s','Window size 4s','Window size 5s','Window size 6s','Window size 7s','Window size 8s');
ylim([70 80])
grid on
title('Activity Window size');
xlabel('Computing time [s]');
ylabel('Accuracy of classifier [%]');
filename= ('Activity_window.pdf');
print(filename,'-dpdf')

figure
semilogx(w2st(:,1),w2st(:,2),'g*',w3st(1,1),w3st(1,2),'r*', w4st(1,1),w4st(1,2),'b*', w5st(1,1),w5st(1,2),'c*',w6st(1,1),w6st(1,2),'m*',w7st(1,1),w7st(1,2),'k*',w8st(1,1),w8st(1,2),'ko','LineWidth',2,'MarkerSize',10);
legend('Window size 2s','Window size 3s','Window size 4s','Window size 5s','Window size 6s','Window size 7s','Window size 8s');
ylim([55 67])
grid on
title('Terrain Window size');
xlabel('Computing time [s]');
ylabel('Accuracy of classifier [%]');
filename= ('Terrain_window.pdf');
print(filename,'-dpdf')