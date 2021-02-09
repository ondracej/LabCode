function [val] = iplv(x,y)
% this function computes the imaginary phase lock value which is a
% volume-conductance resilient measure of assosiation between two EEG
% signals x and y
theta1=angle(hilbert(x));
theta2=angle(hilbert(y));

val=abs(mean(exp(1i*(theta2-theta1))));

end

