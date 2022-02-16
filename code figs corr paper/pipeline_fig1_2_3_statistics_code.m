
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
        % t_bins3sec=t_bins;
    end
else
    if exist('mov','var')
        mov3sec=mov;
    end
end

if exist('mov3sec','var')
    if length(EEG3sec)>=length(mov3sec) % this is true if the synchronizing pulse has worked correctly
        EEG3sec=EEG3sec(:,:,round(t_diff/3)+1:end);
        EEG3sec=EEG3sec(:,:,1:length(mov3sec));
    else
        mov3sec=mov3sec(1:size(EEG3sec,3));
    end
end

clear t_bins mov k feats EEG auto_label

% finding the bins where animal is not moving too much (is not wake) and EEG is without movement artefact
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

%% extracting low/high ratio (LH)
fs=30000/64;
LH=NaN(1,size(EEG3sec,3)); % low/high freq ratio
L=NaN(1,size(EEG3sec,3)); % low freq power 
H=NaN(1,size(EEG3sec,3)); % high freq power 
for k=1:size(EEG3sec,3)
    % settings for multitaper
    nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
    [pxx,f]=pmtm(EEG3sec(:,chnl,k),TW,nfft,round(fs));
    px_low=norm(pxx(f<8 & f>1.5));
    px_high=norm(pxx(f<49 & f>30));
    LH(k)=px_low/px_high;
    L(k)=px_low;
    H(k)=px_high;
    
end

median_LH=median(LH(~isnan(LH)));
iqr_LH=iqr(LH(~isnan(LH)));
se_LH=std(LH(~isnan(LH)))/ sqrt(sum(~isnan(LH)));

median_L=median(L(~isnan(L)));
iqr_L=iqr(L(~isnan(L)));

median_H=median(H(~isnan(H)));
iqr_H=iqr(H(~isnan(H)));
%% extracting low/high ratio (LH) for all channels
fs=30000/64;
LH_=NaN(size(EEG3sec,2),1000); % low/high freq ratio
for k=1:1000
    for chnl=1:size(EEG3sec,2)
        % settings for multitaper
        ind=randsample(size(EEG3sec,3),1);
        nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
        [pxx,f]=pmtm(EEG3sec(:,chnl,ind),TW,nfft,round(fs));
        px_low=norm(pxx(f<8 & f>1.5));
        px_high=norm(pxx(f<49 & f>30));
        LH_(chnl,k)=px_low/px_high;
    end
end
median_LH_per_chnl=median(LH_(:,~isnan(sum(LH_,1))),2);

%% local wave detection
% first designing a filter for smooting the data just to avoid detecting
% multiple redundant peaks when we do peak finding:
smoother = designfilt('lowpassiir','FilterOrder',4, ...
    'PassbandFrequency',20,'PassbandRipple',0.5, ...
    'SampleRate',fs);
EEG3sec_healthy=EEG3sec(:,valid_chnls,:);
local_wave_per_chnl=zeros(size(EEG3sec_healthy,2),size(EEG3sec_healthy,3));
% go through all the data, find the suprathreshold peaks in all channels:
for epoch=1:size(EEG3sec_healthy,3)
    
    if sum(epoch==valid_inds)==0
        local_wave(epoch)=NaN; continue;
    end
    local_wave(epoch)=0; n_loc_wav=0; % n is number of all detected paired peaks, ...
    % that could be redundant
    peak_position=[]; % peak_position contains the index to the peaks of local waves
    all_peaks=[]; % contains all the candidate peaks for local wave
    % find the times of all the supra-threshold peakes in all channels:
    for ch=1:size(EEG3sec_healthy,2)
        smoothedEEG=filtfilt(smoother, EEG3sec_healthy(:,ch,epoch));
        supra_thresh=abs(smoothedEEG)>1*thresh/4; % (thresh is 4iqr(eeg))
        [~,peak_inds{ch}]=findpeaks(smoothedEEG.*supra_thresh,'MinPeakDistance',40);
        % at least 90 m sec (40/fs) time diff between consequtive peaks
    end
    
    % find the simultaneous peaks in different channels:
    for ch1=1:size(EEG3sec_healthy,2)-1
        all_peaks_ch1=peak_inds{ch1};
        for k=1:length( all_peaks_ch1 )
            peak=all_peaks_ch1(k);
            for ch2=ch1+1:size(EEG3sec_healthy,2)
                if min(abs(peak_inds{ch2}-peak),[],'all')<=4 % peaks within 10 ms
                    n_loc_wav=n_loc_wav+1;  all_peaks(n_loc_wav)=peak;
                end
            end
        end
    end
    % now we have all the synchronusly-ocurring peaks, that may be redundant.
    % Therefore now we have to remove the redundancies. For this purpose,
    % we sort all the detected synchronous peaks, and count the number of jumps
    % (diff>2) +1
    sorted_peaks=sort(all_peaks);
    while(length(sorted_peaks)>4)
        % find the first group of simultaneous peaks:
        jump_ind=find(diff(sorted_peaks)>4,1);  % end of the first group of peaks
        if isempty(jump_ind) % if this is the last group of peaks
            break;
        end
        if length(sorted_peaks(1:jump_ind))>=.25*length(valid_chnls) & length(sorted_peaks(1:jump_ind))<=.75*length(valid_chnls)
            % if there are at least 25% chnls with that peak but not more
            % than 75% of chnls
            local_wave(epoch)=local_wave(epoch)+1;
            peak_position(local_wave(epoch))=mean(sorted_peaks(1:jump_ind));
        end
        sorted_peaks=sorted_peaks(jump_ind+1:end); % remove the first group and repeat the ...
        % process for the rest
    end
    local_wave(epoch)=local_wave(epoch)/3; % divided by duration of window
    
    % computing abundance of local waves in each channel
    for ch=1:size(EEG3sec_healthy,2)
        if isempty(peak_position)
            break;
        end
        peak_inds_ch=peak_inds{ch};
        for pk=1:length(peak_inds_ch)
            ch_peak=peak_inds_ch(pk);
            if min(abs(peak_position-ch_peak),[],'all')<=8
                local_wave_per_chnl(ch,epoch)=local_wave_per_chnl(ch,epoch)+1;
            end
        end
    end
    local_wave_position{epoch}=peak_position;
    clear   peak_inds
end
% averaging over bins
local_wave_per_chnl_mean_=mean(local_wave_per_chnl,2);
local_wave_per_chnl_mean=NaN(16,1);
local_wave_per_chnl_mean(valid_chnls)=local_wave_per_chnl_mean_;

%% taking samples of each stage and compute the cross-correlations between EEG activities.
% we take 10% of each stage
LH_valid=LH(valid_inds);
REM_thresh=quantile(LH_valid,.1); % 10% quartile for REM
IS1_thresh=quantile(LH_valid,.45); % 10% quartile for lower IS
IS2_thresh=quantile(LH_valid,.55); % 10% quartile for upper bound of IS
SWS_thresh=quantile(LH_valid,.9); % 10% quartile for SWS
REM_valid_inds=valid_inds(LH_valid<REM_thresh); % linear index to valid_inds for REM
IS_valid_inds=valid_inds(LH_valid<IS2_thresh & LH_valid>IS1_thresh); % linear index to valid_inds for IS
SWS_valid_inds=valid_inds(LH_valid>SWS_thresh); % linear index to valid_inds for SWS

nREM=1; % counter for the bins for correlation values
nIS=1; % counter for the bins for correlation values
nSWS=1; % counter for the bins for correlation values

for ind=valid_inds
    corr_mat=corrcoef(EEG3sec(:,:,ind));
    LL_corr_part=tril(corr_mat(1:8,1:8),-1);
    LL_corr_vals=LL_corr_part(valid_chnls(valid_chnls<=8), valid_chnls(valid_chnls<=8));
    LL_corr=sum(LL_corr_vals(:))/sum(LL_corr_vals(:)~=0);
    
    RR_corr_part=tril(corr_mat(9:16,9:16),-1);
    RR_corr_vals=RR_corr_part(valid_chnls(valid_chnls>8)-8, valid_chnls(valid_chnls>8)-8);
    RR_corr=sum(RR_corr_vals(:))/sum(RR_corr_vals(:)~=0);
    
    LR_corr_part=corr_mat(1:8,9:16);
    LR_corr_vals=LR_corr_part(valid_chnls(valid_chnls<=8), valid_chnls(valid_chnls>8)-8);
    LR_corr=sum(LR_corr_vals(:))/sum(LR_corr_vals(:)~=0);
    
    if any( ind == REM_valid_inds ) % then this epoch is REM
        LLRRLR_corr_REM(nREM,1)=LL_corr;
        LLRRLR_corr_REM(nREM,2)=RR_corr;
        LLRRLR_corr_REM(nREM,3)=LR_corr;
        nREM=nREM+1;
    elseif any( ind == IS_valid_inds ) % then this epoch is REM
        LLRRLR_corr_IS(nIS,1)=LL_corr;
        LLRRLR_corr_IS(nIS,2)=RR_corr;
        LLRRLR_corr_IS(nIS,3)=LR_corr;
        nIS=nIS+1;
    elseif any( ind == SWS_valid_inds ) % then this epoch is REM
        LLRRLR_corr_SWS(nSWS,1)=LL_corr;
        LLRRLR_corr_SWS(nSWS,2)=RR_corr;
        LLRRLR_corr_SWS(nSWS,3)=LR_corr;
        nSWS=nSWS+1;
    end
end
% average and ste
LLRRLR_corr_REM_ste=std(LLRRLR_corr_REM)/sqrt(length(LLRRLR_corr_REM));
LLRRLR_corr_IS_ste=std(LLRRLR_corr_IS)/sqrt(length(LLRRLR_corr_IS));
LLRRLR_corr_SWS_ste=std(LLRRLR_corr_SWS)/sqrt(length(LLRRLR_corr_SWS));
LLRRLR_corr_REM_mean=mean(LLRRLR_corr_REM);
LLRRLR_corr_IS_mean=mean(LLRRLR_corr_IS);
LLRRLR_corr_SWS_mean=mean(LLRRLR_corr_SWS);

%% saving variables
loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_results3with_dph_Fig_1_2_3.mat');
res=loaded_res.res;

res(n).bird=fname;
a=LH(valid_inds);  b=local_wave(valid_inds);
cc=~isnan(b) & ~isnan(a);
LH_local_wave_corr=corrcoef(a(cc),b(cc));
res(n).corr_local_wave_and_depth=LH_local_wave_corr(1,2); % the cross-correlation
res(n).local_wave_perSec_perChnl_mean=local_wave_per_chnl_mean/3;
local_wave_perSec_perChnl_se=std(mean(local_wave_per_chnl,1)/3) / sqrt(length(valid_inds));% sum of number of local waves corrected ...
% for the number of sleep-time bins and non-noisy channels
res(n).median_LH_per_chnl=median_LH_per_chnl;
res(n).median_LH=median_LH;
res(n).iqr_LH=iqr_LH;
res(n).se_LH=se_LH;
res(n).LLRRLR_corr_REM=LLRRLR_corr_REM_mean;
res(n).LLRRLR_corr_IS=LLRRLR_corr_IS_mean;
res(n).LLRRLR_corr_SWS=LLRRLR_corr_SWS_mean;
res(n).LLRRLR_corr_REM_ste=LLRRLR_corr_REM_ste;
res(n).LLRRLR_corr_IS_ste=LLRRLR_corr_IS_ste;
res(n).LLRRLR_corr_SWS_ste=LLRRLR_corr_SWS_ste;
save('G:\Hamed\zf\P1\labled sleep\batch_results3with_dph_Fig_1_2_3.mat','res','-nocompression')
