%% Shifting time to zero

load raw_data
for m= 1:12
    for n=1:4%5
        if isempty(raw_data.treadmill{m}{n}) ~= 1
            for o=1:3
                if isempty( raw_data.treadmill{m}{n}{o}) ~= 1
                    for p=1:6
                        if isempty( raw_data.treadmill{m}{n}{o}{p}) ~= 1  
                            raw_time.treadmill{m}{n}{o}{p}(:,1)=zeros(length(raw_data.treadmill{m}{n}{o}{p}(:,1)),1);
                            for i=1:length(raw_data.treadmill{m}{n}{o}{p}(:,1))
                                raw_time.treadmill{m}{n}{o}{p}(i,1)= raw_data.treadmill{m}{n}{o}{p}(i,1)-raw_data.treadmill{m}{n}{o}{p}(1,1);    
                            end
                            raw_data.treadmill{m}{n}{o}{p}(:,1)= raw_time.treadmill{m}{n}{o}{p}(:,1);
                        end
                    end
                end
            end
        end
    end
end
