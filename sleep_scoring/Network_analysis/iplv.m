function [val] = iplv(A)
% this function computes the imaginary phase lock value (iPLV) between each pair
% of columns in ther matrix A. iPLV is a zero-lagged-interference free
% measure of assosiation between two signals wchich could be used as a
% volume-conductance resilient measure of connectivity between two EEG
% channels without a need for source separation

val=zeros(size(A,2),size(A,2)); % variable initiation
for k=1:size(A,2) % for all channels
    for j=1:size(A,2)
        x=A(:,k); 
        y=A(:,j);
        theta1=angle(hilbert(x)); % phase of x 
        theta2=angle(hilbert(y)); % phase of y 
        val(k,j)=abs(mean(exp(1i*(theta2-theta1))));
    end
end

