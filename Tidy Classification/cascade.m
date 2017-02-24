function [ output ] = cascade( alloc,fun,input,extra1, extra2,cutoff1,cutoff2)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
weight= [67.1; 79.4; 63.2; 77.1; 63.5; 72.7; 65.5; 84.8; 70.5; 77.5; 70.6; 62.7];
output= cell(1,12);
[ output ] = alloc( output );

for m= 1:12 %Participants
    if isempty(input{m}) ~= 1
        for n=1:2%3 % Device
            if isempty(input{m}{n}) ~= 1
                for o=1:3   % Speed
                    if isempty( input{m}{n}{o}) ~= 1
                        for p=1:5  % Conditions
                            if isempty( input{m}{n}{o}{p}) ~= 1
                                [ output{m}{n}{o}{p}(:,:)] = fun(input{m}{n}{o}{p}(:,:),extra1,cutoff1,weight(m,1),m,o,p,80);
                            end
                        end
                    end
                end
                for o=4:5   % Speed
                    if isempty( input{m}{n}{o}) ~= 1
                        for p=6:7    % Conditions
                            if isempty( input{m}{n}{o}{p}) ~= 1
                                [ output{m}{n}{o}{p}(:,:)] = fun(input{m}{n}{o}{p}(:,:),extra2,cutoff2,weight(m,1),m,o,p,10);
                            end
                        end
                    end
                end
            end
        end
    end
end
end



