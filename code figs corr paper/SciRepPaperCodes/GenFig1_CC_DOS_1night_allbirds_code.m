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

if length(EEG3sec)>=length(mov3sec) && exist('t_diff','var') % this is true if the synchronizing pulse has worked correctly
    EEG3sec=EEG3sec(:,:,round(t_diff/3)+1:end);
    EEG3sec=EEG3sec(:,:,1:length(mov3sec));
else
    mov3sec=mov3sec(1:size(EEG3sec,3));
end

clear t_bins mov k feats EEG auto_label

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
%% extracting low/high ratio (LH) for all channels
fs=30000/64;
LH_all_chnls=NaN(length(valid_chnls),length(valid_chnls)); % low/high freq ratio %%%%%%%%%%
for k=1:round(length(valid_inds)/4)
    for chnl=1:length(valid_chnls)
        % settings for multitaper
        ind=valid_inds(k);
        nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
        [pxx,f]=pmtm(EEG3sec(:,valid_chnls(chnl),ind),TW,nfft,round(fs));
        px_low=norm(pxx(f<8 & f>1.5));
        px_high=norm(pxx(f<49 & f>30));
        LH_all_chnls(chnl,k)=px_low/px_high;
    end
end

fname(1:5)

corr_mat=corr(LH_all_chnls','type','pearson');
corr_valid_part=tril(corr_mat,-1);
mean_corr_LH=mean(corr_valid_part(find(corr_valid_part)))
sd_corr_LH=std(corr_valid_part(find(corr_valid_part)))

% saving data
loaded_res=load('G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\batch_1_night_AllBirds_CC_of_DOS.mat');
res=loaded_res.res;

res(n).bird=fname;
res(n).corr_mat=corr_mat; 
res(n).mean_corr_LH=mean_corr_LH; 
res(n).sd_corr_LH=sd_corr_LH; 

save('G:\Hamed\zf\P1_16chnl_EEG\EEGdata_corr_paper\batch_1_night_AllBirds_CC_of_DOS.mat','res','-nocompression');

