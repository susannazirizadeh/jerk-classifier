 %% Preparing acceleration data for classification
 % 1. PSD estimate for cut-off frequency
 % 2. Filter data with band-pass filter
 % 3. Feature extraction of 'Load rate'
 %      3.1 Time-domain 
 %      3.2 Frequency-domain
 % 4. Feature extraction of acc
 %      4.1 Time-domain 
 %      4.2 Frequency-domain
 % 5. Feature matrix
load raw_int
partic= cellstr(['P1 ';'P2 ';'P3 ';'P4 ';'P5 ';'P6 ';'P7 ';'P8 ';'P9 ';'P10';'P11';'P12']);
device  = cellstr(['SP1';'SW1';'GPS']);
speed = cellstr(['5km/h ';'8km/h ';'12km/h';'slow  ';'fast  ']);
con= cellstr(['asphalt    ';'grass      ';'soil       ';'inlcineup  ';'inclinedown';'stairsup   ';'stairsdown ']);
weight= [67.1; 79.4; 63.2; 77.1; 63.5; 72.7; 65.5; 84.8; 70.5; 77.5; 70.6; 62.7]; %Weights of each participants
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
%% 2. Filter data with band pass filter cut of 0.5Hz and 10Hz
% Bandpass filter for cascade cell array
[ raw_filt.outdoor ] = cascade( @allocation_empty,@bandpass,raw_int.outdoor,0,0,0,0);

%%   3. Feature extraction of 'Load rate' window size= 4s
 %      3.1 Time-domain (mean, variance, correlation, min, max, STD, RMS) %  3.2 Frequency-domain (FFT, main F, max, F, energy, entropy)
[ features.loadrate ] = cascade( @allocation_empty,@features_loadrate,raw_filt.outdoor,400,100,500,50);
[ features.jerk ] = cascade( @allocation_empty,@features_jerk,raw_filt.outdoor, 400,100,500,50); 
%%   4. Feature extraction of 'Load' window size= 4s
 %      3.1 Time-domain (mean, variance, correlation, min, max, STD, RMS) %  3.2 Frequency-domain (FFT, main F, max, F, energy, entropy)
[ features.load ] = cascade( @allocation_empty,@features_load,raw_filt.outdoor, 400,100,500,50);
[ features.acc ] = cascade( @allocation_empty,@features_acc,raw_filt.outdoor, 400,100,500,50);  
%%  5. Feature matrix
[ featurematrix ] = matrixmaker( features.loadrate);

