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

% repicking SPW events after time alignment
spw.event=zeros(length(spw_indx),fs/10); % initialization: empty spw matrix, length of spw templates is considered as 150ms
spw.pre=zeros(length(spw_indx),fs);
n=1;
while n <= length(spw_indx)
    spw.event(n,:)=eegsig(spw_indx(n)-fs/20 : spw_indx(n)+fs/20-1,:)'; 
    spw.pre(n,:)=eegsig(spw_indx(n)-fs/20-fs : spw_indx(n)-fs/20-1,:)'; n=n+1;
end

% generating some non-SPW data vectors for negative labels
nonspw.event=zeros(length(spw_indx),fs/10); % initialization: empty spw matrix, length of spw templates is considered as 150ms
n=1; % number of random (non-SPW) events
while n<size(spw.event,1)
    t=randi([3*fs,length(eegsig)-fs]); % choose a random canditate time for non
    if min(abs(t-spw_indx))>size(spw,1) % if the random time is one length of SPW away from any SPW
    nonspw.event(n,:)=eegsig(t : t+fs/10-1,:)'; 
    nonspw.pre(n,:)=eegsig(t-fs : t-1,:)'; n=n+1;
    end
end

% plot for spw and non-spw events
figure
subplot(1,2,1)
t=(1:size(spw.event,2))*1000/fs;
plot(t,spw.event'), title('SPWs'); ylim([-400 200]); xlabel('Time(ms)')
subplot(1,2,2)
t=(1:size(nonspw.event,2))*1000/fs;
plot(t,nonspw.event'), title('random non-SPW events'); ylim([-400 200]); xlabel('Time(ms)')

% mean template and labels
spw_temp=mean(spw.event); figure, plot(t,spw_temp); 

% generating labels: similarity to SPW template: projection of events on
% SPW_template

% first normalizing everything
spw.event=spw.event-repmat(mean(spw.event,2),1,size(spw.event,2));
nonspw.event=nonspw.event-repmat(mean(nonspw.event,2),1,size(nonspw.event,2));

S=(spw.event*spw_temp')/sqrt(spw_temp*spw_temp');
spw.label=S./sqrt(sum(spw.event.*spw.event,2));
S=(nonspw.event*spw_temp')/sqrt(spw_temp*spw_temp');
nonspw.label=S./sqrt(sum(nonspw.event.*nonspw.event,2));
save([dirname '\' [filename '-nonspw']],'nonspw');
save([dirname '\' [filename '-spw']],'spw');

clear spw_times up_tresh spw1 align_err align_err1 spw_ spw_indices1 spw_indices spw_indx1 spw_interval min_point indx n tig t N spw_indx pre_spw S

%% feature extraction 

% Features 1: AR coefficients

spw.feats=spw_feature_extract(spw.event');
nonspw.feats=spw_feature_extract(nonspw.event');

% plot of AR features
colors = lines(2);
xylabels={'AR(1)','Ar(2)','Ar(3)','AR(4)','Ar(5)','AR(6)','Ar(7)'};
feats=[spw.feats.ar; nonspw.feats.ar];
classes=[1*ones(size(spw.feats.ar,1),1); 2*ones(size(nonspw.feats.ar,1),1)];
figure;  pairplot(feats, xylabels , num2cell(num2str(classes)), colors, 'both');

% feature 2: Wavelet Entropy
wpt = wpdec(x,3,'db1','shannon');
[cd1,cd2,cd3] = detcoef(c,l,[1 2 3]);
e = wentropy(x,'shannon');


%% classification 
% via MultiLayer Perceptron

% trian
train_rat=.7;
net = patternnet([4,2]);
train_inp=[ spw.feats.ar(1:floor(train_rat*size(spw.feats.ar,1)),:)' , nonspw.feats.ar(1:floor(train_rat*size(nonspw.feats.ar,1)),:)'];
train_outp=[repmat([1;0],1,floor(train_rat*size(spw.feats.ar,1))) , repmat([0;1],1,floor(train_rat*size(nonspw.feats.ar,1)))];
net = train(net, train_inp, train_outp);
view(net)

% test
test_inp=[ spw.feats.ar(ceil(train_rat*size(spw.feats.ar,1)):end,:)' , nonspw.feats.ar(ceil(train_rat*size(nonspw.feats.ar,1)):end,:)'];
test_true=[repmat([1;0],1,ceil((1-train_rat)*size(spw.feats.ar,1))) , repmat([0;1],1,ceil((1-train_rat)*size(nonspw.feats.ar,1)))];
net_outp_ = round(net(test_inp));
net_outp = vec2ind(net_outp_);
true_label=vec2ind(test_true);
spw_classification.ar.confusion=confusion_mat(true_label-1, net_outp-1);

%% 





