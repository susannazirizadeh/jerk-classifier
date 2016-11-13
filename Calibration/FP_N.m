%% Transfroming electrical Force plate data into mechanical force [N]
% load raw_int

%%
weight= [73.815 87.34 69.69 85.1 70.4 80.5 72.37 93.49 78.2 85.8 78.1 69.7]; %Weights of each participants
BWper=[ 0.2 0.5 0.7 0.8 0.9 1.0]; % Bodyweight percentages that they were running at
for i=1:6
    for j=1:12
        BWperweight(i,j)=weight(j)*BWper(i);
    end
end
%%
for m= 3:12
    if isempty(raw_int.treadmill{m}{5}) ~= 1
        for o= 1:3
            if isempty( raw_int.treadmill{m}{5}{o}) ~= 1
                for p=1:6
                    if isempty( raw_int.treadmill{m}{5}{o}{p}) ~= 1
                        raw_int.treadmill{m}{5}{o}{p}(:,6)=ForceCalc(raw_int.treadmill{m}{5}{o}{p}(:,2:5))./BWperweight(p,m);
                    end
                end
            end
        end
    end
end


for m= 1
    if isempty(raw_int.treadmill{m}{5}) ~= 1
        for o=1:3
            if isempty( raw_int.treadmill{m}{5}{o}) ~= 1
                for p=1:6
                    if isempty( raw_int.treadmill{m}{5}{o}{p}) ~= 1
                        raw_int.treadmill{m}{5}{o}{p}(:,6)=ForceCalc(raw_int.treadmill{m}{5}{o}{p}(:,2:5))./BWperweight(p,m);  
                        j=1;
                        for i=1:length(raw_int.treadmill{m}{5}{o}{p}(:,1))
                            if raw_int.treadmill{m}{5}{o}{p}(i,6)>0
                                for q=1:6
                                    raw_int.treadmill{m}{5}{o}{p}(j,q)= raw_int.treadmill{m}{5}{o}{p}(i,q);
                                end
                                j=j+1; 
                            end
                        end
                      raw_int.treadmill{m}{5}{o}{p}(j:i,:)=[];
                    end
                end
            end
        end
    end
end