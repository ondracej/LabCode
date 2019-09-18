function [drift]=correlator(superf,deeper)
% this functions gets 2 CSD/LFP matrices, and computes the correlation between
% them. the superficial csd is untuched, and we shift the deeper csd one
% row each time to the down and computed the average of corr between
% corresponding rows. output is this average corr for different number of
% shifts

% deternmining number of rows in each mtrix (because some channels may be ...
% removed before computing CSD due to high noise value)
n1=size(superf,1);   n2=size(deeper,1);  N=min(n1,n2);

% comparing corresponding rows, after different shifts, depends on the
% relative number of rows in the 2 matrices, either n1<n2 or n1>n2:
switch(n1>=n2)
    
    case 1
        k=1; % k is the starting row of the shifted matrix (deeper one), at first it is 1, so no shift ...
        % and we continues as long as there is at least one row to be compared
        while min(n1,N+k-1)-k+1>=1
            a=superf(k:min(n1,N),:); % selected part from 1st matrix
            b=deeper(1:min(n1,N+k-1)-k+1,:); % selected part from 2nd matrix
            drift(k)=sum(diag(a*b')) / sqrt( sum(diag(a*a')) * sum(diag(b*b')) ); % this is sum of corr(a,b)/ sqrt(corr(a).corr(b)) for all rows in a and b
            k=k+1
        end
        
    case 0
        k=1;
        while N-k+1>=1
            a=superf(k:n1,:); % selected part from 1st matrix
            b=deeper(1:N-k+1,:); % selected part from 2nd matrix
            drift(k)=sum(diag(a*b')) / sqrt( sum(diag(a*a')) * sum(diag(b*b')) );
            k=k+1
        end
end

end