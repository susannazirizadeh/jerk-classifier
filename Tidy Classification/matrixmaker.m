function [ output ] = matrixmaker( input )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
output=input{1}{1}{1}{1};
for m= 1:12 %Participants
    if isempty(input{m}) ~= 1
        for n=1:2%3 % Device
            if isempty(input{m}{n}) ~= 1
                for o=1:3   % Speed
                    if isempty( input{m}{n}{o}) ~= 1
                        for p=2:5  % Conditions
                            if isempty( input{m}{n}{o}{p}) ~= 1
                                new_row=input{m}{n}{1}{1}(:,:);
                                output=[output;new_row];
                            end
                        end
                    end
                end
                for o=4:5   % Speed
                    if isempty( input{m}{n}{o}) ~= 1
                        for p=6:7    % Conditions
                            new_row=input{m}{n}{1}{1}(:,:);
                            output=[output;new_row];
                        end
                    end
                end
            end
        end
    end
end
end

