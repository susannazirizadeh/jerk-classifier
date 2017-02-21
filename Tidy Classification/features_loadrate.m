function [ output ] = features_loadrate( input,win,cutoff, weight)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
[temp,fs]=jerk_all(input(cutoff:end-cutoff,1:4));
output=NaN(20,11);
for i= 1:win/2:length(temp)
    if i+win < length(temp) % Windowing, window length= 500 data points (4 seconds) with 50% overlapping
        % Time -domain features
        output((i + (win/2)-1) / (win/2),1)= nanmean((temp(i:i+(win-1),1)).*weight); % mean of 500 data points
        output((i + (win/2)-1) / (win/2),2)= max((temp(i:i+(win-1),1)).*weight);
        output((i + (win/2)-1) / (win/2),3)= min((temp(i:i+(win-1),1)).*weight);
        output((i + (win/2)-1) / (win/2),4)= var((temp(i:i+(win-1),1)).*weight);
        output((i + (win/2)-1) / (win/2),5)= std((temp(i:i+(win-1),1)).*weight);
        output((i + (win/2)-1) / (win/2),6)= rms((temp(i:i+(win-1),1)).*weight);
        % frequency domain features
        t=([0:win-1]/fs)';
        [pks,locs] = findpeaks(temp(i:i+(win-1),1),t,'MinPeakDistance',t(50));
        output((i + (win/2)-1) / (win/2),7)=mean(diff(locs)/fs);
          output((i + (win/2)-1) / (win/2),8)=max(diff(locs)/fs);
         output((i + (win/2)-1) / (win/2),9)= mode(diff(locs)/fs);
%         output((i + (win/2)-1) / (win/2),10)= entropy((temp(i:i+(win-1),1)).*weight);
        %         output((i + (win/2)-1) / (win/2),11)=
    end
end

end

