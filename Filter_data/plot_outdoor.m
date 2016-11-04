%% Plot outdoor session
%% Transforming raw_int.outdoor into jerk_grf.outdoor with cutoff before 1000 and 1000 before end 
% m= participants   (12)
% n= device         (3)
% o= speed          (5)
% p= condition      (7) (asphalt,grass,soil,inlcineup, inclinedown, stairsup, stairs down)
load results_grf
partic= cellstr(['P1 ';'P2 ';'P3 ';'P4 ';'P5 ';'P6 ';'P7 ';'P8 ';'P9 ';'P10';'P11';'P12']);
device  = cellstr(['SP1';'SW1';'GPS']);
speed = cellstr(['5km/h ';'8km/h ';'12km/h';'slow  ';'fast  ']);
con= cellstr(['asphalt    ';'grass      ';'soil       ';'inlcineup  ';'inclinedown';'stairsup   ';'stairsdown ']);
%% Per weight
weight= [67.1 79.4 63.2 77.1 63.5 72.7 65.5 84.8 70.5 77.5 70.6 62.7]; %Weights of each participants
%% Display the mean of the jerk per weight
% condition; asphalt=1, grass=2, soil=3, inclineup=4, inclinedown= 5, stairsup=6, stairsdown=7
for n=1%:2%length(device)
        figure;
        subplot(2,3,1)
        for m=1:length(partic)
            plot(results_grf.outdoor{n}{m}(1:5,3),results_grf.outdoor{n}{m}(1:5,1),'o')
            title(['Calculated load during outdoor session, ' device{n} ' 5km/h '])
            xlabel('Different ground typs')
            ylabel('Jerk [m/s^3]')
            %             legend ('5km/h','8km/h','12km/h','Location','southeast')
            grid on
            hold on
        end
        
        subplot(2,3,2)
        for m=1:length(partic)
            plot(results_grf.outdoor{n}{m}(6:10,3),results_grf.outdoor{n}{m}(6:10,1),'o')
            title(['Calculated load during outdoor session, ' device{n} ' 8km/h '])
            xlabel('Different ground typs')
            ylabel('Jerk [m/s^3]')
            %             legend ('5km/h','8km/h','12km/h','Location','southeast')
            grid on
            hold on
        end
        
        subplot(2,3,3)
        for m=1:length(partic)
            plot(results_grf.outdoor{n}{m}(11:15,3),results_grf.outdoor{n}{m}(11:15,1),'o')
            title(['Calculated load during outdoor session, ' device{n} ' 12km/h '])
            xlabel('Different ground typs')
            ylabel('Jerk [m/s^3]')
            %             legend ('5km/h','8km/h','12km/h','Location','southeast')
            grid on
            hold on
        end
                subplot(2,3,4)
        for m=1:length(partic)
            plot(results_grf.outdoor{n}{m}(16:17,3),results_grf.outdoor{n}{m}(16:17,1),'o')
            title(['Calculated load during outdoor session, ' device{n} ' slow '])
            xlabel('Different ground typs')
            ylabel('Jerk [m/s^3]')
            %             legend ('5km/h','8km/h','12km/h','Location','southeast')
            grid on
            hold on
        end
                subplot(2,3,5)
        for m=1:length(partic)
            plot(results_grf.outdoor{n}{m}(18:19,3),results_grf.outdoor{n}{m}(18:19,1),'o')
            title(['Calculated load during outdoor session, ' device{n} ' fast '])
            xlabel('Different ground typs')
            ylabel('Jerk [m/s^3]')
            %             legend ('5km/h','8km/h','12km/h','Location','southeast')
            grid on
            hold on
        end
end

