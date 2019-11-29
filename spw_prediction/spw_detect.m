function [spw_indx, thr] = spw_detect(eegsig, best_chnl, fs)
% SPW detection viaTeager energy

tig=teager(eegsig(:,best_chnl),[100]);
thr=median(tig)+6*iqr(tig); % threshold for detection of spw
up_tresh=tig.*(tig>thr);
[~,spw_indices1] = findpeaks(up_tresh(fs+1:end-fs)); % Finding peaks in the channel with max variance, omitting the 1st and last sec ...

% Now we remove concecutive detected peaks with less than .1 sec interval 
spw_interval=[1; diff(spw_indices1)]; % assigning the inter-SPW interval to the very next SPW. If it is longer than a specific time, that SPW is accepted.
% of course the first SPW is alway accepted so w assign a long enough
% interval to it (1).
spw_indices=spw_indices1(spw_interval>.3*fs);

spw_indices=spw_indices+fs; % shifting 1 sec to the right place for the corresponding time (removal of 1st second is compensared)
spw1=zeros(fs/5+1,length(spw_indices)); % initialization: empty spw matrix
n=1;
while n <= length(spw_indices)
    spw1(:,n)=eegsig(spw_indices(n)-fs/10 : spw_indices(n)+fs/10,:); n=n+1;  % spw in the 1st channel
end

% removing upward detected-events
indx=spw1(round(size(spw1,1)/2),:)<mean(spw1([1 , end],:),1); % for valid spw, middle point shall occur below the line connecting the two sides
spw_=spw1(:,indx);
spw_indx1=spw_indices(indx); % selected set of indices of SPWs that are downward 
% correcting SPW times, all detected events will be aligned to their
% minimum:
[~,min_point]=min(spw_,[],1); % extracting index of the minimum point for any detected event 
align_err1=min_point-ceil(size(spw_,1)/2); % Error = min_point - mid_point
align_err=reshape(align_err1,size(spw_indx1)); 
spw_indx=spw_indx1+align_err; % these indices are time-corrected

end

