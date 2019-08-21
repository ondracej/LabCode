% teager energy operator
% inputs: x: signal and number of delay samples
% N: different number of shifts used in multitapper Teager operator
function [y] = teager(x,N)
z=0;
for n=1:length(N)
z= z + circshift(x,N(n),1).*circshift(x,-N(n),1);
end
y=x.^2 - z/length(N);
end

