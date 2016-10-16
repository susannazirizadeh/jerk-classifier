%% Per weight
 load mjerk_xyz_int
weight= [73.815 87.34 69.69 85.1 70.4 80.5 72.37 93.49 78.2 85.8 78.1 73.1];

BWper=[ 0.2 0.5 0.7 0.8 0.9 1.0];

% BWweight= weight* BWper;

for i=1:6
    for j=1:12
    BWperweight(i,j)=weight(j)*BWper(i);
    end 
end

%% Display the mean of the jerk per weight
speed = [5 8 12];
device  = cellstr(['SP1';'SW1';'SP2';'SW2';'FP ']);
% figure;
%  for n= 1:length(device)
for o=1:length(speed)
    figure;
    mjerk_xyz_int1= NaN(6,12);
    mjerk_xyz_int2= NaN(6,12);
    for m= 2:12
        for p= 1:6
            if isempty( mjerk_xyz_int.treadmill{m}{3}{o}{p} ) ~= 1
                if isempty( mjerk_xyz_int.treadmill{m}{5}{o}{p} ) ~= 1
                    mjerk_xyz_int1(p,m)= mjerk_xyz_int.treadmill{m}{3}{o}{p};
                    mjerk_xyz_int2(p,m)= mjerk_xyz_int.treadmill{m}{5}{o}{p};
                end
            end
        end   
        
        try
            f=fit(mjerk_xyz_int2(:,m),mjerk_xyz_int1(:,m),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        
        plot (mjerk_xyz_int2(1:6,1:6),mjerk_xyz_int1(1:6,1:6),'*',mjerk_xyz_int2(1:6,7:12),mjerk_xyz_int1(1:6,7:12),'o')
        plot(f);
        title(['Jerk of Smartphone on the hip and force plate, ' num2str(speed(o)) 'km/h'])
        xlabel('Jerk force plate [N]')
        ylabel('Jerk device [m/s^3]')
        legend ('Participant 1','Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','southeast')
        grid on
        hold on
        %    axis([10 100  0 300000])
        filename= (['jerk_SP1_FP_' num2str(speed(o)) 'km.pdf']);
        print(filename,'-dpdf')
    end
end
%  end

%% Display thefitted line 
speed = [5 8 12];
device  = cellstr(['SP1';'SW1';'SP2';'SW2';'FP ']);
% figure;
%  for n= 1:length(device)
for o=1:length(speed)
    figure;
    for m= 2:12
        
        try
            f=fit(mjerk_xyz_int2(:,m),mjerk_xyz_int1(:,m),'poly1');
        catch
            display(['fitting error for participant ' , num2str(m)])
        end
        
        plot (mjerk_xyz_int2(1:6,1:6),mjerk_xyz_int1(1:6,1:6),'*',mjerk_xyz_int2(1:6,7:12),mjerk_xyz_int1(1:6,7:12),'o')
        plot(f);
        %          plot (f,mjerk_xyz_int2(1:6,1:6),mjerk_xyz_int1(1:6,1:6),'*',f,mjerk_xyz_int2(1:6,7:12),mjerk_xyz_int1(1:6,7:12),'o')
        title(['Jerk of Smartphone on the hip and force plate, ' num2str(speed(o)) 'km/h'])
        xlabel('Jerk force plate [N]')
        ylabel('Jerk device [m/s^3]')
        legend ('Participant 1','Participate 2','Participate 3','Participate 4','Participate 5','Participate 6','Participate 7','Participate 8','Participate 9','Participate 10','Participate 11','Participate 12','Location','southeast')
        grid on
        hold on
        %    axis([10 100  0 300000])
        filename= (['jerk_SP1_FP_' num2str(speed(o)) 'km.pdf']);
        print(filename,'-dpdf')
    end
end
%  end
%%
Xtotal=NaN(72,3);
Ytotal=NaN(72,3);
for o=1:3
X= NaN(6,12);
Y= NaN(6,12);

for m=1:12
    for p=1:6
        if isempty( mjerk_xyz_int.treadmill{m}{3}{o}{p} ) ~= 1
            if isempty( mjerk_xyz_int.treadmill{m}{5}{o}{p} ) ~= 1
                X(p,m)=mjerk_xyz_int.treadmill{m}{5}{o}{p};
                Y(p,m)=mjerk_xyz_int.treadmill{m}{3}{o}{p};

            end
        end
    end
end
                Xtotal(:,o)=[X(:,1);X(:,2);X(:,3);X(:,4);X(:,5);X(:,6);X(:,7);X(:,8);X(:,9);X(:,10);X(:,11);X(:,12)];
                Ytotal(:,o)=[Y(:,1);Y(:,2);Y(:,3);Y(:,4);Y(:,5);Y(:,6);Y(:,7);Y(:,8);Y(:,9);Y(:,10);Y(:,11);Y(:,12)];
end



