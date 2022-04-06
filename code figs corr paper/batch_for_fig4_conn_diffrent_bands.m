
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
    mov3sec=mov;
    
end

if length(EEG3sec)>=length(mov3sec) % this is true if the synchronizing pulse has worked correctly
    EEG3sec=EEG3sec(:,:,round(t_diff/3)+1:end);
    EEG3sec=EEG3sec(:,:,1:length(mov3sec));
else
    mov3sec=mov3sec(1:size(EEG3sec,3));
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
for k=1:size(EEG3sec,3)
    % settings for multitaper
    nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
    [pxx,f]=pmtm(EEG3sec(:,chnl,k),TW,nfft,round(fs));
    px_low=norm(pxx(f<8 & f>1.5));
    px_high=norm(pxx(f<49 & f>30));
    LH(k)=px_low/px_high;
end
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
    
    if any( ind == REM_valid_inds ) % then this epoch is REM
        full_band_corr_REM_(nREM,:,:)=corr_mat;
        nREM=nREM+1;
    elseif any( ind == IS_valid_inds ) % then this epoch is REM
        full_band_corr_IS_(nIS,:,:)=corr_mat;
        nIS=nIS+1;
    elseif any( ind == SWS_valid_inds ) % then this epoch is REM
        full_band_corr_SWS_(nSWS,:,:)=corr_mat;
        nSWS=nSWS+1;
    end
end
% averaging the whole night
full_band_corr_REM=reshape(mean(full_band_corr_REM_),16,16);
full_band_corr_IS=reshape(mean(full_band_corr_IS_),16,16);
full_band_corr_SWS=reshape(mean(full_band_corr_SWS_),16,16);

%% corr matrix for low frequency components
nREM=1; % counter for the bins for correlation values
nIS=1; % counter for the bins for correlation values
nSWS=1; % counter for the bins for correlation values

[b,a] = butter(4,[1.5 8]/(fs/2));


for ind=valid_inds
    corr_mat=corrcoef(filtfilt(b,a,EEG3sec(:,:,ind)));
    
    if any( ind == REM_valid_inds ) % then this epoch is REM
        full_band_corr_REM_(nREM,:,:)=corr_mat;
        nREM=nREM+1;
    elseif any( ind == IS_valid_inds ) % then this epoch is REM
        full_band_corr_IS_(nIS,:,:)=corr_mat;
        nIS=nIS+1;
    elseif any( ind == SWS_valid_inds ) % then this epoch is REM
        full_band_corr_SWS_(nSWS,:,:)=corr_mat;
        nSWS=nSWS+1;
    end
end
% averaging the whole night
low_band_corr_REM=reshape(mean(full_band_corr_REM_),16,16);
low_band_corr_IS=reshape(mean(full_band_corr_IS_),16,16);
low_band_corr_SWS=reshape(mean(full_band_corr_SWS_),16,16);

%% corr matrix for high frequency components
nREM=1; % counter for the bins for correlation values
nIS=1; % counter for the bins for correlation values
nSWS=1; % counter for the bins for correlation values

[b,a] = butter(4,[30 49.5]/(fs/2));


for ind=valid_inds
    corr_mat=corrcoef(filtfilt(b,a,EEG3sec(:,:,ind)));
    
    if any( ind == REM_valid_inds ) % then this epoch is REM
        full_band_corr_REM_(nREM,:,:)=corr_mat;
        nREM=nREM+1;
    elseif any( ind == IS_valid_inds ) % then this epoch is REM
        full_band_corr_IS_(nIS,:,:)=corr_mat;
        nIS=nIS+1;
    elseif any( ind == SWS_valid_inds ) % then this epoch is REM
        full_band_corr_SWS_(nSWS,:,:)=corr_mat;
        nSWS=nSWS+1;
    end
end
% averaging the whole night
high_band_corr_REM=reshape(mean(full_band_corr_REM_),16,16);
high_band_corr_IS=reshape(mean(full_band_corr_IS_),16,16);
high_band_corr_SWS=reshape(mean(full_band_corr_SWS_),16,16);

%% visualization
clim=[.1 1];
figure
subplot(3,3,1)
imagesc(full_band_corr_SWS,clim); axis equal; axis tight
ylabel('SWS')
title('full-band')
subplot(3,3,4)
imagesc(full_band_corr_IS,clim); axis equal; axis tight
ylabel('IS')
subplot(3,3,7); 
imagesc(full_band_corr_REM,clim); axis equal; axis tight
ylabel('REM')

subplot(3,3,2)
imagesc(low_band_corr_SWS,clim); axis equal; axis tight
title('1.5-8 Hz')
subplot(3,3,5)
imagesc(low_band_corr_IS,clim); axis equal; axis tight
subplot(3,3,8); 
imagesc(low_band_corr_REM,clim); axis equal; axis tight

subplot(3,3,3)
imagesc(high_band_corr_SWS,clim); axis equal; axis tight
title('30-50 Hz')
subplot(3,3,6)
imagesc(high_band_corr_IS,clim); axis equal; axis tight
subplot(3,3,9); 
imagesc(high_band_corr_REM,clim); axis equal; axis tight
print(['G:\Hamed\zf\P1\corr_matrices_figures\' fname(1:11)],'-dpng'); % Save figure

%% saving variables
loaded_res=load('G:\Hamed\zf\P1\labled sleep\conn_diff_bands.mat');
res=loaded_res.res;

res(n).experiment=fname(1:11);

res(n).full_band_corr_REM=full_band_corr_REM;
res(n).full_band_corr_IS=full_band_corr_IS;
res(n).full_band_corr_SWS=full_band_corr_SWS;

res(n).high_band_corr_REM=high_band_corr_REM;
res(n).high_band_corr_IS=high_band_corr_IS;
res(n).high_band_corr_SWS=high_band_corr_SWS;

res(n).low_band_corr_REM=low_band_corr_REM;
res(n).low_band_corr_IS=low_band_corr_IS;
res(n).low_band_corr_SWS=low_band_corr_SWS;


save('G:\Hamed\zf\P1\labled sleep\corr_full_low_high_band.mat','res','-nocompression')
