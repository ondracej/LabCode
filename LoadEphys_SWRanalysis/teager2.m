% Unbalanced Teager energy operator
% inputs: 
% x: input signal which is a vector or a matrix containing different channels of signal in its !!COLUMNS!! 
% N1, N2: different number of shifts used in multitapper Teager operator: N
% N1 for previous sample, N2 for future sample

function [y] = teager2(x,N1,N2)
y=x.^2 - circshift(x,N1,1).*circshift(x,-N2,1);
end

