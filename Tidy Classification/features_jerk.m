function [ output ] = features_jerk( input,win,cutoff, weight,m,o,p,distance)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
[temp,fs]=jerk_all(input(cutoff:end-cutoff,1:4));
output=NaN(1,14);
for i= 1:win/2:length(temp)
    if i+win < length(temp) % Windowing, window length= 500 data points (4 seconds) with 50% overlapping
        % Time -domain features
        output((i + (win/2)-1) / (win/2),1)= nanmean(temp(i:i+(win-1),1)); % mean of 500 data points
        
        output((i + (win/2)-1) / (win/2),2)= max(temp(i:i+(win-1),1));    % max value
        
        output((i + (win/2)-1) / (win/2),3)= min(temp(i:i+(win-1),1));    % min value
        
        output((i + (win/2)-1) / (win/2),4)= var(temp(i:i+(win-1),1));    % variance of the vector
        
        output((i + (win/2)-1) / (win/2),5)= std(temp(i:i+(win-1),1));    % standard deviation
        output((i + (win/2)-1) / (win/2),6)= rms(temp(i:i+(win-1),1));
        % frequency domain features
        t=([0:win-1]/fs)';
        [pks,locs] = findpeaks(temp(i:i+(win-1),1),t,'MinPeakDistance',t(distance));
        output((i + (win/2)-1) / (win/2),7)=mean(diff(locs)/fs);

        output((i + (win/2)-1) / (win/2),8)= mode(diff(locs)/fs);
        
        Xf = fft(temp(i:i+(win-1),1)); % compute the FFT (using the Fast Fourier Transform)
        output((i + (win/2)-1) / (win/2),9) = sum(abs(Xf).^2) / length(Xf); %Energy
        
        [counts,binCenters] = hist(temp(i:i+(win-1)),100);
        binWidth = diff(binCenters);
        binWidth = [binWidth(end),binWidth]; % Replicate last bin width for first, which is indeterminate.
        nz = counts>0; % Index to non-zero bins
        frequency = counts(nz)/sum(counts(nz));
        output((i + (win/2)-1) / (win/2),10)= -sum(frequency.*log(frequency./binWidth(nz)));
        
        output((i + (win/2)-1) / (win/2),11)= o; % speed
        
        output((i + (win/2)-1) / (win/2),12)= p; % condition
        
        output((i + (win/2)-1) / (win/2),13)= weight; %weight of participant
        
        output((i + (win/2)-1) / (win/2),14)= m; % participant ID
    end
end

end

