%% Transfroming electrical Force plate data into mechanical force [N]
load raw_int

%%
for m= 1:12
    if isempty(raw_int.treadmill{m}{5}) ~= 1
        for o=1:3
            if isempty( raw_int.treadmill{m}{5}{o}) ~= 1
                for p=1:6
                    if isempty( raw_int.treadmill{m}{5}{o}{p}) ~= 1
                        raw_int.treadmill{m}{5}{o}{p}(:,6)=ForceCalc(raw_int.treadmill{m}{5}{o}{p}(:,2:5));
                    end
                end
            end
        end
    end
end

