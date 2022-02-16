
fs=30000/64;
chnl=4; % non-noisy channel
% reshaping data in 3 sec windows, in case bins are 1.5 sec
if exist('EEG_','var')==1
    EEG=EEG_;
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
t_bins3sec=t_bins;
end
mov3sec=mov3sec(1:size(EEG3sec,3));
clear t_bins mov k feats EEG auto_label

eeg=reshape(EEG3sec(:,chnl,:),[1,size(EEG3sec,1)*size(EEG3sec,3)]);
thresh=4*iqr(eeg);
maxes_=max(abs(EEG3sec(:,chnl,:)),[],1);
maxes=reshape(maxes_,[1,length(maxes_)]);
thresh_mov=median(mov3sec)+5*iqr(mov3sec); % threshold for separating wakes from sleep based on movement
valid_inds=find(maxes<thresh & mov3sec'<thresh_mov);
valid_inds_logic=(maxes<thresh & mov3sec'<thresh_mov);

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
        matrix_corr_REM_(nREM,:,:)=corr_mat;
        nREM=nREM+1;
    elseif any( ind == IS_valid_inds ) % then this epoch is REM
        matrix_corr_IS_(nIS,:,:)=corr_mat;
        nIS=nIS+1;
    elseif any( ind == SWS_valid_inds ) % then this epoch is REM
        matrix_corr_SWS_(nSWS,:,:)=corr_mat;
        nSWS=nSWS+1;
    end
end
% averaging the whole night
matrix_corr_REM=reshape(median(matrix_corr_REM_),16,16);
matrix_corr_IS=reshape(median(matrix_corr_IS_),16,16);
matrix_corr_SWS=reshape(median(matrix_corr_SWS_),16,16);

%% saving variables
loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_corr_mat_change.mat');
res=loaded_res.res;

res(n).bird=fname;
res(n).matrix_corr_REM=matrix_corr_REM; 
res(n).matrix_corr_IS=matrix_corr_IS; 
res(n).matrix_corr_SWS=matrix_corr_SWS; 

save('G:\Hamed\zf\P1\labled sleep\batch_corr_mat_change.mat','res','-nocompression')