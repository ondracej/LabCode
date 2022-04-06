clear

% fname='73-03_09_03_scoring';
% load(fname);
% light_off_t=31000/20; %%%%%%%%%%% frame number devided by rate of acquisition
% light_on_t=889160/20;  %%%%%%%%%%% frame number devided by rate of acquisition
fname='w0020_25_09_scoring';
load(fname);
light_off_t=35580/20; %%%%%%%%%%% frame number devided by rate of acquisition
light_on_t=900200/20;  %%%%%%%%%%% frame number devided by rate of acquisition

fs=30000/64;
chnl=4; % non-noisy channel
% reshaping data in 3 sec windows, in case bins are 1.5 sec
if exist('EEG3sec','var')==0
    if exist('EEG_','var')==1
        EEG=EEG_;
    elseif exist('eeg_adc','var')
        EEG=eeg_adc;
    end
    if size(EEG,3)>27000
        new_len=floor(size(EEG,3)/2);
        EEG3sec=zeros(size(EEG,1)*2,size(EEG,2),new_len);
        for k=1:new_len
            EEG3sec(:,:,k)=[EEG(:,:,2*k-1);EEG(:,:,2*k)];
        end
        t_bins3sec=downsample(t_bins,2)+1.5/2;
        mov3sec=downsample((mov+circshift(mov,-1))/2, 2);
    else
        mov3sec=mov;
        EEG3sec=EEG;
        if exist('t_bins','var')
        t_bins3sec=t_bins;
        end
        % t_bins3sec=t_bins;
    end
else
    mov3sec=mov;
    
end

if length(EEG3sec)>=length(mov3sec) && exist('t_diff','var') % this is true if the synchronizing pulse has worked correctly
    EEG3sec=EEG3sec(:,:,round(t_diff/3)+1:end);
    EEG3sec=EEG3sec(:,:,1:length(mov3sec));
else
    mov3sec=mov3sec(1:size(EEG3sec,3));
end
if ~exist('t_bins3sec','var') % in case that there were no synchronizong ADC, we estimate the time samples
    t_bins3sec=1.5:3:1.5+(length(EEG3sec)*3);
end

% finding the bins when the bird is not moving too much (is not wake) and EEG is without movement artefact  
eeg=reshape(EEG3sec(:,chnl,:),[1,size(EEG3sec,1)*size(EEG3sec,3)]);
thresh=4*iqr(eeg);
maxes_=max(abs(EEG3sec(:,chnl,:)),[],1);
maxes=reshape(maxes_,[1,length(maxes_)]);
if exist('t_diff','var') % in case that we dont have the synchronizing signal
    valid_inds=find(maxes<thresh );
    valid_inds_logic=(maxes<thresh );
else
    thresh_mov=median(mov3sec)+5*iqr(mov3sec); % threshold for separating wakes from sleep based on movement
    valid_inds=find(maxes<thresh & mov3sec'<thresh_mov);
    valid_inds_logic=(maxes<thresh & mov3sec'<thresh_mov);
end

% extracting low/high ratio (continuous depth of sleep index)
fs=30000/64; % initial sampling rate devided by downsampling factor
LH=NaN(1,size(EEG3sec,3)); % low/high freq ratio
for k=1:size(EEG3sec,3)
    % settings for multitaper
    nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
    [pxx,f]=pmtm(EEG3sec(:,chnl,k),TW,nfft,round(fs));
    px_low=norm(pxx(f<8 & f>1.5)); % delta and theta power (below 1.5 could me polluted with noise artefacts [Rattenborg, 2019, Sleep])
    px_high=norm(pxx(f<49 & f>30)); % (low) gamma
    LH(k)=px_low/px_high;
end

%% plot of low/high 
t_plot=[light_off_t-1800 light_on_t+1800]; %%%%%%%%%%% t_lim for plot in seconds
ind=1:length(t_bins3sec)-1;
mov_valid=NaN(size(mov3sec));
mov_valid(valid_inds)=mov3sec(valid_inds);
LH_valid=NaN(size(LH));
LH_valid(valid_inds)=LH(valid_inds);
% plot of smothed data (movement, low/high and connectivity)
figure
set(gcf, 'Position',  [100, 100, 700, 230])

win=5;
plot((t_bins3sec(1:length(LH_valid)))/3600,mov_avg_nan(LH_valid,win),'linewidth',1.0,'color',[1 .5 .5]);
xlim(t_plot/3600); ylim([0 1.03*max(mov_avg_nan(LH_valid,win))]); 
hold on
area([t_plot(1) light_off_t]/3600,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
area([light_on_t t_plot(2)]/3600,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
ylabel('\bf	(\delta+\theta) / \gamma');  
xlabel('Time (h)')

% the smoothing threshold
win=600; % half an hour is the length of the smoothing window for threshold line
SWS_thresh=mov_avg_nan(LH_valid,win)+.4*mov_iqr_nan(LH_valid,win);
plot((t_bins3sec(1:length(SWS_thresh)))/3600,SWS_thresh,'linewidth',1.0,'color',.6*[1 1 1]);
REM_thresh=mov_avg_nan(LH_valid,win)-.4*mov_iqr_nan(LH_valid,win);
plot((t_bins3sec(1:length(REM_thresh)))/3600,REM_thresh,'linewidth',1.0,'color',.6*[ 1 1 1]);
area([light_on_t t_plot(2)]/3600,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,'edgecolor',[1 .8 0]);

ylabel('\bf	(\delta+\theta) / \gamma');  
xlabel('Time (h)')


% state transitions detection:
SWS_onsets=[];
REM_onsets=[];
t0_=t_bins3sec(1); % initiation for the variable containing the times of SWS and REM initiation
t0=t_bins3sec(1); % initiation for the variable containing the times of SWS and REM initiation
win=5;
LH_valid_smoo=mov_avg_nan(LH_valid,win);
SWS_inds=[];
REM_inds=[];
while ~isempty(t0_)
    t0_=find(LH_valid_smoo>SWS_thresh & t_bins3sec(1:length(LH_valid_smoo))>t0);
    if ~isempty(t0_)
        t0=t_bins3sec(t0_(1)); % first time after the current transition time, t0, that DOS surpasses SWS threshold
        SWS_onsets=[SWS_onsets t0];
        SWS_inds=[SWS_inds t0_(1)];
        % see if there is also REM happening:
        t0_=find(LH_valid_smoo<REM_thresh & t_bins3sec(1:length(LH_valid_smoo))>t0);
        if ~isempty(t0_)
            t0=t_bins3sec(t0_(1)); % first time after the current transition time, t0, that DOS surpasses SWS threshold
            REM_onsets=[REM_onsets t0];
            REM_inds=[REM_inds t0_(1)];
        end
    end
end

hold on
% overlaying ther state-transition times
valid_REM_inds=REM_onsets>light_off_t+20*60 & REM_onsets<light_on_t;
plot(REM_onsets(valid_REM_inds)/3600,LH_valid_smoo(REM_inds(valid_REM_inds)),'.','markersize',9,'linewidth',1.0,...
    'color',.3*[1 1 1 1]);
valid_SWS_inds=SWS_onsets>light_off_t+20*60 & SWS_onsets<light_on_t;
plot(SWS_onsets(valid_SWS_inds)/3600,LH_valid_smoo(SWS_inds(valid_SWS_inds)),'.','markersize',9,'linewidth',1.0,...
    'color',.3*[1 1 1 1]);
title(fname(1:11));






