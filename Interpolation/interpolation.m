%% Interpolate the data which is missing
% m= participants
% n= device
% o= speed
% p= gravity

clear all
load raw_data
load raw_int

% mean(j(find(j>0)))

%% Transfer into j_xyz part 2
% Allocat jerk_xyz_data.treadmill
raw_zero.treadmill= cell(1,12);
for m= 1:12
    raw_zero.treadmill{m}= cell(1,5);
    for n=1:5
    raw_zero.treadmill{m}{n}= cell(1,3);
        for o=1:3
        raw_zero.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                raw_zero.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end

raw_nans.treadmill= cell(1,12);
for m= 1:12
    raw_nans.treadmill{m}= cell(1,5);
    for n=1:5
    raw_nans.treadmill{m}{n}= cell(1,3);
        for o=1:3
        raw_nans.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                raw_nans.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end
raw_int.treadmill= cell(1,12);
for m= 1:12
    raw_int.treadmill{m}= cell(1,5);
    for n=1:5
    raw_int.treadmill{m}{n}= cell(1,3);
        for o=1:3
        raw_int.treadmill{m}{n}{o}= cell(1,6);
            for p=1:6
                raw_int.treadmill{m}{n}{o}{p}= [];
            end
        end
    end
end


%% Exclude repeted values
for m= 1:12
    for n=1:4%5
        if isempty(raw_data.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty( raw_data.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty( raw_data.treadmill{m}{n}{o}{p}) ~= 1
                            j=1;k=1;
                            for i=2:length(raw_data.treadmill{m}{n}{o}{p}(:,2))
                                if raw_data.treadmill{m}{n}{o}{p}(i,2)~=raw_data.treadmill{m}{n}{o}{p}(i-1,2) % creating two vectors for interpolation
                                    raw_zero.treadmill{m}{n}{o}{p}(j,:)= raw_data.treadmill{m}{n}{o}{p}(i,:); % raw_zero has all the data points included which are not repeted
                                    j=j+1;
                                else
                                    raw_nans.treadmill{m}{n}{o}{p}(k,1)= raw_data.treadmill{m}{n}{o}{p}(i,1); % raw_nans has all the data points included which are
                                    k=k+1;
                                end
                            end
                            clear xq; clear x; clear v1; clear v2 ;clear v3 ; clear v1q; clear v2q; clear v3q;
                            if isempty( raw_nans.treadmill{m}{n}{o}{p}) ~= 1
                                x= raw_zero.treadmill{m}{n}{o}{p}(:,1); %Linear Interpolation
                                v1= raw_zero.treadmill{m}{n}{o}{p}(:,2);
                                v2= raw_zero.treadmill{m}{n}{o}{p}(:,3);
                                v3= raw_zero.treadmill{m}{n}{o}{p}(:,4);
                                xq= raw_nans.treadmill{m}{n}{o}{p}(:,1);
                                vq1 = interp1(x,v1,xq);
                                vq2 = interp1(x,v2,xq);
                                vq3 = interp1(x,v3,xq);
                            end
                            j=1;
                            for i=2:length(raw_data.treadmill{m}{n}{o}{p}(:,2))
                                if raw_data.treadmill{m}{n}{o}{p}(i,2)~=raw_data.treadmill{m}{n}{o}{p}(i-1,2)
                                    raw_int.treadmill{m}{n}{o}{p}(i,2:4)= raw_data.treadmill{m}{n}{o}{p}(i,2:4);
                                else
                                    raw_int.treadmill{m}{n}{o}{p}(i,2)= vq1(j);
                                    raw_int.treadmill{m}{n}{o}{p}(i,3)= vq2(j);
                                    raw_int.treadmill{m}{n}{o}{p}(i,4)= vq3(j);
                                    j=j+1;
                                end
                            end
                            raw_int.treadmill{m}{n}{o}{p}(:,1)= raw_data.treadmill{m}{n}{o}{p}(:,1);
                            %                             clear xqnew; clear xnew; clear v1new; clear v2new;clear  v3new ; clear v1qnew; clear v2qnew; clear v3qnew
                            %                             % Interpolating to get same sampling frequenzy
                            %                             % like force plate data
                            %                             if isempty( raw_int.treadmill{m}{n}{o}{p}) ~= 1
                            %                                 xqnew=zeros(length(raw_int.treadmill{m}{n}{o}{p}(:,2)-2),1);
                            %                                 for i=1:length(raw_int.treadmill{m}{n}{o}{p}(:,2))-1
                            %                                     xqnew(i,1)=(raw_int.treadmill{m}{n}{o}{p}(i,1)+raw_int.treadmill{m}{n}{o}{p}(i+1,1))/2;
                            %                                     %                                 xqnew(i+1,1)=((raw_int.treadmill{m}{n}{o}{p}(i,1)+raw_int.treadmill{m}{n}{o}{p}(i+1,1))/2) + (raw_int.treadmill{m}{n}{o}{p}(i + 1,1)-raw_int.treadmill{m}{n}{o}{p}(i,1)) ;
                            %
                            %                                 end
                            %                                 xnew= raw_int.treadmill{m}{n}{o}{p}(:,1);
                            %                                 v1new= raw_int.treadmill{m}{n}{o}{p}(:,2);
                            %                                 v2new= raw_int.treadmill{m}{n}{o}{p}(:,3);
                            %                                 v3new= raw_int.treadmill{m}{n}{o}{p}(:,4);
                            %                                 vq1new = interp1(xnew,v1new,xqnew);
                            %                                 vq2new = interp1(xnew,v2new,xqnew);
                            %                                 vq3new = interp1(xnew,v3new,xqnew);
                            %                             end
                            
                        end
                        
                    end
                end
                
            end
        end
    end
end


%% Correct forceplate data 

for m= 1:12 
    if isempty(raw_data.treadmill{m}{5}) ~= 1
        for o=1:3
            if isempty(raw_data.treadmill{m}{5}{o}) ~= 1
                for p=1:6
                    if isempty(raw_data.treadmill{m}{5}{o}{p}) ~= 1
                        raw_int.treadmill{m}{5}{o}{p}(:,:)=raw_data.treadmill{m}{5}{o}{p}(:,:);
                    end
                end
            end
            
        end
    end
end


