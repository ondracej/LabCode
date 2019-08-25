% teager energy operator
% inputs: 
% x: input signal which is a vector or a matrix containing different channels of signal in its columns 
% N: different number of shifts used in multitapper Teager operator: N
% could be a scaler or a vector of values for shifting the signal for TEO.
% If its a vector the function output is the average of TEO signals for
% these different values of shift, for example the average of TEO with 2
% and 5 shifts.
function [y] = teager(x,N)
z=0;
for n=1:length(N)
z= z + circshift(x,N(n),1).*circshift(x,-N(n),1);
end
y=x.^2 - z/length(N);
end

