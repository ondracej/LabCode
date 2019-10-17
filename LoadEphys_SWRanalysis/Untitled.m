%% making template of spws based on spw detection
up_tresh=tig.*(tig>thr);
[~,spw_indices1] = findpeaks(up_tresh(fs+1:end-fs)); % Finding peaks in the channel with max variance, omitting the 1st and last sec ...

% Now we remove concecutive detected peaks with less than .1 sec interval 
spw_interval=[1; diff(spw_indices1)]; % assigning the inter-SPW interval to the very next SPW. If it is longer than a specific time, that SPW is accepted.
% of course the first SPW is alway accepted so w assign a long enough
% interval to it (1).
spw_indices=spw_indices1(spw_interval>.3*fs);

spw_indices=spw_indices+fs; % shifting 1 sec to the right place for the corresponding time (removal of 1st second is compensared)
spw1=zeros(2*fs/5+1,N,length(spw_indices)); % initialization: empty spw matrix, length of spw templates is considered as 500ms
n=1;
while n <= length(spw_indices)
    spw1(:,:,n)=spwsig(spw_indices(n)-fs/5 : spw_indices(n)+fs/5,:); n=n+1;  % spw in the 1st channel
end

% removing upward detected-events
indx=spw1(round(size(spw1,1)/2),mx_var_chnl,:)<mean(spw1([1 end],mx_var_chnl,:),1); % for valid spw, middle point shall occur below the line connecting the two sides
spw_=spw1(:,:,indx);
spw_indx1=spw_indices(indx); % selected set of indices of SPWs that are downward 
% correcting SPW times, all detected events will be aligned to their
% minimum:
[~,min_point]=min(spw_(:,mx_var_chnl,:),[],1); % extracting index of the minimum point for any detected event 
align_err1=min_point-ceil(size(spw_,1)/2); % Error = min_point - mid_point
align_err=reshape(align_err1,size(spw_indx1)); 
spw_indx=spw_indx1+align_err; % these indices are time-corrected
save([add_dir '\' [Fname '-spw_indx']],'spw_indx');

% repicking SPW events after time alignment
spw=zeros(2*fs/5+1,N,length(spw_indx)); % initialization: empty spw matrix, length of spw templates is considered as 500ms
n=1;
while n <= length(spw_indx)
    spw(:,:,n)=spwsig(spw_indx(n)-fs/5 : spw_indx(n)+fs/5,:); n=n+1;  % spw in the 1st channel
end
save([add_dir '\' [Fname '-spw']],'spw');

% plotting all spws and the average shape, for channel k which is the one
% with maximum variance
figure('Position', [460 100 600 600]);
subplot(1,2,1)
for i=1:size(spw,3)
plot((-fs/5:fs/5)/fs*1000,spw(:,mx_var_chnl,i)); hold on
end; axis tight; xlabel('Time (ms)'); ylabel('Amplitude (\muV)')
axis([-200 200 -1450 950]);
title('SPWs in max variance chnl')

% plot of average SPWs across channels
subplot(1,2,2)
hold on
for chnl=1:N
plot((-fs/5:fs/5)/fs*1000,mean(spw(:,chnl,:),3), ...
    'color',[220 chnl*255/N 255-chnl*255/N]/255); % color coded based on channel
end
axis([-200 200 -400 50]); xlabel('Time (ms)');  
title({'mean SPW accross chnls'; ['rate: ' num2str( round(size(spw,3) / max(time)*60 ,1)) '/min  ' Fname]}); ylabel('Amplitude (\muV)')
print([add_dir '\' [Fname '-SPW']],'-dpng')

% plot of signal with SPWs labeld
figure;
subplot(2,1,1); 
plot(tt-t0,eeg(t_lim,mx_var_chnl)); title('Raw signal ' );  ylabel('(\muV)'); 
hold on; plot(time(spw_indx)-t0,eeg(spw_indx,mx_var_chnl),'+r');  xlim(plot_time)
subplot(2,1,2); 
plot(tt-t0,tig(t_lim),'b'); hold on; line(plot_time,[thr thr],'LineStyle','--');  title('TEO ' ); 
ylabel('(\muV^2)'); xlabel('Time (Sec)'); xlim(plot_time); axis tight

% garbage cleaning
 clear spw_times up_tresh spw1 align_err align_err1 tig spw_ spw_indices1 spw_indices spw_indx1 spw_interval min_point indx thr y tlim i n 
 