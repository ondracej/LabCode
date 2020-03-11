% code for prediction of SPWR events
clear;

%%% loading data
GitDir='D:\GitHub\LabCode';
addpath([GitDir '\LoadEphys_SWRanalysis']);
addpath([GitDir '\spw_prediction']);
addpath(genpath([GitDir '\pairplot']));
dirname='D:\SPWR_prediction\Data\zebra finch 60 88\exp1_2019-04-29_15-02-55';
chnls=[1:1];  % channels to be used
downsamp=20; % downsampling ratio
prename='100_CH';
fs=30000/downsamp;
[eegsig,time]=predict_gather_data(dirname,chnls,prename,downsamp,fs); % reads, downsamples, and filters eeg channels

%% Extraction of SPW, nonSPW events, and correspondong pre-events
clear spw nonspw
% find spw volley times
best_chnl=1; % in case eeg is multichannel which channel for detection?
[spw_indx, thr] = pre_spw_detect(eegsig, best_chnl, fs);
% repicking SPW events after time alignment

pre_len=fs*.8; % length of pre-event (raw feature vector) %%%%%%%%%%%%%%%%%
spw.event=zeros(length(spw_indx),fs/10); % initialization: empty spw matrix, length of spw templates is considered as 150ms
spw.pre=zeros(length(spw_indx),pre_len*length(chnls));
n=1;
while n <= length(spw_indx)
    spw.event(n,:)=eegsig(spw_indx(n)-fs/20 : spw_indx(n)+fs/20-1,best_chnl)';
    spw_pre=eegsig(spw_indx(n)-fs/20-pre_len : spw_indx(n)-fs/20-1,:)';
    spw.pre(n,:)=reshape(spw_pre', 1, numel(spw_pre));
    n=n+1;
end

% generating some non-SPW data vectors for negative labels
nonspw.event=zeros(length(spw_indx),fs/10); % initialization: empty spw matrix, length of spw templates is considered as 150ms
nonspw.pre=zeros(length(spw_indx),pre_len*length(chnls));
n=1; % number of random (non-SPW) events
while n<=size(spw.event,1)
    t=randi([3*fs,length(eegsig)-fs]); % choose a random canditate time for non
    if min(abs(t-spw_indx))>size(spw,1) % if the random time is one length of SPW away from any SPW
        nonspw.event(n,:)=eegsig(t : t+fs/10-1,best_chnl)';
        nonspw_pre=eegsig(t-pre_len : t-1,:)';
        nonspw.pre(n,:)=reshape(nonspw_pre', 1, numel(nonspw_pre),1);
        n=n+1;
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

clear spw_times up_tresh spw1 align_err align_err1 spw_ spw_indices1 spw_indices spw_indx1 spw_interval min_point indx n tig t N spw_indx pre_spw S


%% feature extraction

% Features 1: AR coefficients, 2: entropy of all nodes in a wavelet packet
% tree
wav_order=3; %%%%%%%%%%%%%%%% 5 was not better than 4
ar_order=5; %%%%%%%%%%%%%%%%
spw.feats=spw_feature_extract(spw.pre',ar_order, wav_order);
nonspw.feats=spw_feature_extract(nonspw.pre',ar_order, wav_order);

% plot of AR features
colors = lines(2);
xylabels={'AR(1)','Ar(2)','Ar(3)','AR(4)','Ar(5)','AR(6)','Ar(7)'};
feats=[spw.feats.ar; nonspw.feats.ar];
classes=[1*ones(size(spw.feats.ar,1),1); 2*ones(size(nonspw.feats.ar,1),1)];
figure;  pairplot(feats, xylabels , num2cell(num2str(classes)), colors, 'both');

% plot of entropy of wavelet packet
xylabels={'WP(1)','WP(2)','WP(3)','WP(4)','WP(5)','WP(6)','WP(7)'};
feats=[spw.feats.wav1(:,1:5); nonspw.feats.wav1(:,1:5)];
classes=[1*ones(size(spw.feats.ar,1),1); 2*ones(size(nonspw.feats.ar,1),1)];
figure;  pairplot(feats, xylabels , num2cell(num2str(classes)), colors, 'both');

% plot of energy of windoes of wave preceeding the event
xylabels={'En(1)','En(2)','En(3)','En(4)','En(5)','En(6)','En(7)','En(8)'};
feats=[spw.feats.energy(:,1:5); nonspw.feats.energy(:,1:5)];
classes=[1*ones(size(spw.feats.energy,1),1); 2*ones(size(nonspw.feats.energy,1),1)];
figure;  pairplot(feats, xylabels , num2cell(num2str(classes)), colors, 'both');


%% feature selection


%% classification
% via MultiLayer Perceptron


for rep = 1:20 % repeated train-tests
    
    % features: AR
    % trian
    train_rat=.7;
    net = patternnet([4,2]);
    net.trainFcn = 'trainlm';
    train_inp=[ spw.feats.ar(1:floor(train_rat*size(spw.feats.ar,1)),:)' , nonspw.feats.ar(1:floor(train_rat*size(nonspw.feats.ar,1)),:)'];
    train_outp=[repmat([1;0],1,floor(train_rat*size(spw.feats.ar,1))) , repmat([0;1],1,floor(train_rat*size(nonspw.feats.ar,1)))];
    net = train(net, train_inp, train_outp);
    % test
    test_inp=[ spw.feats.ar(ceil(train_rat*size(spw.feats.ar,1)):end,:)' , nonspw.feats.ar(ceil(train_rat*size(nonspw.feats.ar,1)):end,:)'];
    test_true=[repmat([1;0],1,ceil((1-train_rat)*size(spw.feats.ar,1))) , repmat([0;1],1,ceil((1-train_rat)*size(nonspw.feats.ar,1)))];
    net_outp_ = round(net(test_inp));
    net_outp = vec2ind(net_outp_);
    true_label=vec2ind(test_true);
    spw_classification.ar.confusion(:,:,rep)=confusion_mat(true_label-1, net_outp-1);
    clear net
    
    
    % features: wavp Entrop
    % trian
    net = patternnet([4,2]);
    net.trainFcn = 'trainlm';
    train_inp=[ spw.feats.wav1(1:floor(train_rat*size(spw.feats.wav1,1)),:)' , nonspw.feats.wav1(1:floor(train_rat*size(nonspw.feats.wav1,1)),:)'];
    train_outp=[repmat([1;0],1,floor(train_rat*size(spw.feats.wav1,1))) , repmat([0;1],1,floor(train_rat*size(nonspw.feats.wav1,1)))];
    net = train(net, train_inp, train_outp);
    % test
    test_inp=[ spw.feats.wav1(ceil(train_rat*size(spw.feats.wav1,1)):end,:)' , nonspw.feats.wav1(ceil(train_rat*size(nonspw.feats.wav1,1)):end,:)'];
    test_true=[repmat([1;0],1,ceil((1-train_rat)*size(spw.feats.wav1,1))) , repmat([0;1],1,ceil((1-train_rat)*size(nonspw.feats.wav1,1)))];
    net_outp_ = round(net(test_inp));
    net_outp = vec2ind(net_outp_);
    true_label=vec2ind(test_true);
    spw_classification.wav1.confusion(:,:,rep)=confusion_mat(true_label-1, net_outp-1);
    clear net
    
    % features: windowe energies
    % trian
    net = patternnet([4,2]);
    net.trainFcn = 'trainlm';
    train_inp=[ spw.feats.energy(1:floor(train_rat*size(spw.feats.energy,1)),:)' , nonspw.feats.energy(1:floor(train_rat*size(nonspw.feats.energy,1)),:)'];
    train_outp=[repmat([1;0],1,floor(train_rat*size(spw.feats.energy,1))) , repmat([0;1],1,floor(train_rat*size(nonspw.feats.energy,1)))];
    net = train(net, train_inp, train_outp);
    % test
    test_inp=[ spw.feats.energy(ceil(train_rat*size(spw.feats.energy,1)):end,:)' , nonspw.feats.energy(ceil(train_rat*size(nonspw.feats.energy,1)):end,:)'];
    test_true=[repmat([1;0],1,ceil((1-train_rat)*size(spw.feats.energy,1))) , repmat([0;1],1,ceil((1-train_rat)*size(nonspw.feats.energy,1)))];
    net_outp_ = round(net(test_inp));
    net_outp = vec2ind(net_outp_);
    true_label=vec2ind(test_true);
    spw_classification.energy.confusion(:,:,rep)=confusion_mat(true_label-1, net_outp-1);
    clear net
    
    % features: wav1+AR
    net = patternnet([4,2]);
    net.trainFcn = 'trainlm';
    train_inp=[ spw.feats.ar(1:floor(train_rat*size(spw.feats.ar,1)),:)' , nonspw.feats.ar(1:floor(train_rat*size(nonspw.feats.ar,1)),:)' ;
        spw.feats.wav1(1:floor(train_rat*size(spw.feats.wav1,1)),:)' , nonspw.feats.wav1(1:floor(train_rat*size(nonspw.feats.wav1,1)),:)'];
    train_outp=[repmat([1;0],1,floor(train_rat*size(spw.feats.ar,1))) , repmat([0;1],1,floor(train_rat*size(nonspw.feats.ar,1)))];
    net = train(net, train_inp, train_outp);
    % test
    test_inp=[ spw.feats.ar(ceil(train_rat*size(spw.feats.ar,1)):end,:)' , nonspw.feats.ar(ceil(train_rat*size(nonspw.feats.ar,1)):end,:)';
        spw.feats.wav1(ceil(train_rat*size(spw.feats.wav1,1)):end,:)' , nonspw.feats.wav1(ceil(train_rat*size(nonspw.feats.wav1,1)):end,:)'];
    test_true=[repmat([1;0],1,ceil((1-train_rat)*size(spw.feats.ar,1))) , repmat([0;1],1,ceil((1-train_rat)*size(nonspw.feats.ar,1)))];
    net_outp_ = round(net(test_inp));
    net_outp = vec2ind(net_outp_);
    true_label=vec2ind(test_true);
    spw_classification.ar_wav1.confusion(:,:,rep)=confusion_mat(true_label-1, net_outp-1);
    
end

% averaging through reps
spw_classification.ar.confusion=mean(spw_classification.ar.confusion,3);
spw_classification.wav1.confusion=mean(spw_classification.wav1.confusion,3);
spw_classification.ar_wav1.confusion=mean(spw_classification.ar_wav1.confusion,3);
spw_classification.energy.confusion=mean(spw_classification.energy.confusion,3);

figure
subplot(1,5,1), imagesc(spw_classification.ar.confusion,[0,1]), xlabel('using AR'), axis square
subplot(1,5,2), imagesc(spw_classification.wav1.confusion,[0,1]), xlabel('usung wav1'), axis square
subplot(1,5,3), imagesc(spw_classification.ar_wav1.confusion,[0,1]), xlabel('using AR+wav1'), axis square
subplot(1,5,4), imagesc(spw_classification.energy.confusion,[0,1]), xlabel('using pca'), axis square
subplot(1,5,5), colorbar

clear xylabels wav_order true_label train_rst train_outp trin_inp test_true test_inp spw_temp pre_len net_outp_ net_outp net colors  best_chnl ar_order


