function [ cell_array_out ] = allocation_empty( cell_array_in )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

for m= 1:12
    cell_array_in{m}= cell(1,3);
    for n=1:3
        cell_array_in{m}{n}= cell(1,5);
        for o=1:5
            cell_array_in{m}{n}{o}= cell(1,7);
            for p=1:7
                cell_array_in{m}{n}{o}{p}= [];
            end
        end
    end
end

cell_array_out=cell_array_in;

end

