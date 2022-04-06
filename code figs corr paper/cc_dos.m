
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
        t_bins3sec=t_bins;
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

%% depth of sleep for all channels
t_plot=[2 4]*3600; %%%%%%%%%%% t_lim for plot in seconds
ind=find(t_bins3sec<t_plot(2) & t_bins3sec>t_plot(1));

LH_t_plot=NaN(length(valid_chnls),length(ind)); % low/high freq ratio, first filled with NaN, and then in the indeces that are in the t_plot and valid ...
% (artefact-free) we put the corresponding value of the LH
ind_valid_t_plot=intersect(valid_inds,ind); % indeces that are in the t_plot and valid (artefact-free)
for ch=valid_chnls
for k=ind_valid_t_plot % only for the tplot time compute the LH
    % settings for multitaper
    nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
    [pxx,f]=pmtm(EEG3sec(:,ch,k),TW,nfft,round(fs));
    px_low=norm(pxx(f<8 & f>1.5));
    px_high=norm(pxx(f<49 & f>30));
    LH_t_plot(ch,k-(ind(1)-1))=px_low/px_high; 
end
end

% statistics of DOS from different channels
nonnan=~isnan(sum(LH_t_plot));
cc16=corrcoef(LH_t_plot(:,nonnan)');
cc16_nondiag=cc16(find(tril(cc16,-1)));
mean_dos=mean(cc16_nondiag)


loaded_res=load('G:\Hamed\zf\P1\labled sleep\cc_doss.mat');
res=loaded_res.res;

res(n).experiment=fname(1:11);
res(n).mean_dos=mean_dos;

save('G:\Hamed\zf\P1\labled sleep\cc_doss.mat','res','-nocompression')
