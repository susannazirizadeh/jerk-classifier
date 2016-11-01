%% Transforming raw_int into aload
% m= participants
% n= device
% o= speed
% p= gravity
load raw_int
%% Allocat aload.treadmill
aload.treadmill= cell(1,12);
for m= 1:12
    aload.treadmill{m}= cell(1,5);
    for n=1:5
        aload.treadmill{m}{n}= cell(1,3);
        for o=1:3
            aload.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                aload.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end
%% Transform raw_int into jerk in gravity direction
for m= 1:12
    for n=1:4%5
        if isempty(raw_int.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty( raw_int.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        disp('working')
                        if isempty( raw_int.treadmill{m}{n}{o}{p}) ~= 1
%                             for q=2:4
                                %                                 display(length(raw_int.treadmill{m}{n}{o}{p}))
                                clear aMeasured;
                                aMeasured = [raw_int.treadmill{m}{n}{o}{p}(:,2)'; raw_int.treadmill{m}{n}{o}{p}(:,4)'; raw_int.treadmill{m}{n}{o}{p}(:,3)']'; %switching the axes
                                [N, Wn] = buttord(0.005, 0.03, 5, 40); % for 200Hz data this has a 1Hz passband, 6Hz stopband, 5 db passband ripple and 40db stopband attenuation
                                [b, a] = butter(N, Wn, 'low');
                                
                                clear aMeasuredFiltered;
                                for i=1:3
                                    % apply low-pass filter to get gravity component
                                    aMeasuredFiltered(:,i) = filtfilt(b,a,aMeasured(:,i));
                                end
%                                 aload = zeros(length(aMeasured),3);
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
                                    
                                    %aload(i,:)=inv(R)*[0 0 -g]' - aMeasured(i,:)';
                                    aload.treadmill{m}{n}{o}{p}(i,2:4)=R\[0 0 -g]' - aMeasured(i,:)';
                                    aload.treadmill{m}{n}{o}{p}(i,1)=raw_int.treadmill{m}{n}{o}{p}(i,1);
                                end
%                             end
                        end
                    end
                end
            end
        end
    end
end


