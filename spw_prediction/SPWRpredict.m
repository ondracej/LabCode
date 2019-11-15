% code for prediction of SPWR events

%%% loading data
addpath('D:\GitHub\LabCode\LoadEphys_SWRanalysis');
dirname='D:\SPWR_prediction\Data\Chicken 10\Chick10_2019-04-27_20-49-27';
filename='100_CH1.continuous';
[signal,time0, ~] = load_open_ephys_data([dirname '\' filename]);
% fs=30000

eeg=downsample(signal,20);
time=downsample(time0,20);
fs=1500;
N=min(size(eeg)); % number of channels
clear signal time0

%% Filtering for SPW-R

ShFilt = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',1,'HalfPowerFrequency2',300, 'SampleRate',fs);
eegsig=filtfilt(ShFilt,eeg);
clear  ShFilt

%% SPW detection via Teager, and nonSPW events 
best_chnl=1; % in case eeg is multichannel which channel for detection?
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
spw1=zeros(fs/5+1,N,length(spw_indices)); % initialization: empty spw matrix, length of spw templates is considered as 500ms
n=1;
while n <= length(spw_indices)
    spw1(:,:,n)=eegsig(spw_indices(n)-fs/10 : spw_indices(n)+fs/10,:); n=n+1;  % spw in the 1st channel
end

% removing upward detected-events
indx=spw1(round(size(spw1,1)/2),best_chnl,:)<mean(spw1([1 end],best_chnl,:),1); % for valid spw, middle point shall occur below the line connecting the two sides
spw_=spw1(:,:,indx);
spw_indx1=spw_indices(indx); % selected set of indices of SPWs that are downward 
% correcting SPW times, all detected events will be aligned to their
% minimum:
[~,min_point]=min(spw_(:,best_chnl,:),[],1); % extracting index of the minimum point for any detected event 
align_err1=min_point-ceil(size(spw_,1)/2); % Error = min_point - mid_point
align_err=reshape(align_err1,size(spw_indx1)); 
spw_indx=spw_indx1+align_err; % these indices are time-corrected
save([dirname '\' filename    '-spw_indx'],'spw_indx');

% repicking SPW events after time alignment
spw=zeros(length(spw_indx),fs/10); % initialization: empty spw matrix, length of spw templates is considered as 150ms
pre_spw=zeros(length(spw_indx),fs);
n=1;
while n <= length(spw_indx)
    spw(n,:)=eegsig(spw_indx(n)-fs/20 : spw_indx(n)+fs/20-1,:)'; 
    pre_spw(n,:)=eegsig(spw_indx(n)-fs/20-fs : spw_indx(n)-fs/20-1,:)'; n=n+1;
end
save([dirname '\' [filename '-spw']],'spw','pre_spw');

% generating some non-SPW data vectors for negative labels
n=1; % number of random (non-SPW) events
while n<size(spw,1)
    t=randi([3*fs,length(eegsig)-fs]); % choose a random canditate time for non
    if min(abs(t-spw_indx))>size(spw,1) % if the random time is one length of SPW away from any SPW
    nonspw(n,:)=eegsig(t : t+fs/10-1,:)'; 
    pre_nonspw(n,:)=eegsig(t-fs : t-1,:)'; n=n+1;
    end
end
save([dirname '\' [filename '-nonspw']],'nonspw','pre_nonspw');

% plot for spw and non-spw events
t=(1:size(spw,2))*1000/fs;
figure
subplot(1,2,1)
plot(t,spw'), title('SPWs'); ylim([-400 200]); xlabel('Time(ms)')
subplot(1,2,2)
plot(t,nonspw'), title('random non-SPW events'); ylim([-400 200]); xlabel('Time(ms)')

% mean template and labels
spw_temp=mean(spw); figure, plot(t,spw_temp); 

% generating labels: similarity to SPW template: projection of events on
% SPW_template

% first normalizing everything
spw=spw-repmat(mean(spw,2),1,size(spw,2));
nonspw=nonspw-repmat(mean(nonspw,2),1,size(nonspw,2));

S=(spw*spw_temp')/sqrt(spw_temp*spw_temp');
lab_spw=S./sqrt(sum(spw.*spw,2));
S=(nonspw*spw_temp')/sqrt(spw_temp*spw_temp');
lab_nonspw=S./sqrt(sum(nonspw.*nonspw,2));

clear spw_times up_tresh spw1 align_err align_err1 spw_ spw_indices1 spw_indices spw_indx1 spw_interval min_point indx n tig t N spw_indx

%% feature extraction

