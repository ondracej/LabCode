
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
L_=NaN(size(EEG3sec,2),1000); % low freq ratio
H_=NaN(size(EEG3sec,2),1000); % high freq ratio

for k=1:1000
    for chnl=1:size(EEG3sec,2)
        % settings for multitaper
        ind=randsample(size(EEG3sec,3),1);
        nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
        [pxx,f]=pmtm(EEG3sec(:,chnl,ind),TW,nfft,round(fs));
        px_low=norm(pxx(f<8 & f>1.5));
        px_high=norm(pxx(f<49 & f>30));
        LH_(chnl,k)=px_low/px_high;
        L_(chnl,k)=px_low;
        H_(chnl,k)=px_high;

    end
end
median_LH_per_chnl=median(LH_(:,~isnan(sum(LH_,1))),2);
median_L_per_chnl=median(L_(:,~isnan(sum(L_,1))),2);
median_H_per_chnl=median(H_(:,~isnan(sum(H_,1))),2);


%% saving variables
loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_results3with_dph_Fig_1_2_3.mat');
res=loaded_res.res;

res(n).bird=fname;

% for the number of sleep-time bins and non-noisy channels
res(n).median_LH_per_chnl=median_LH_per_chnl;
res(n).median_LH=median_LH;
res(n).iqr_LH=iqr_LH;

res(n).median_L_per_chnl=median_L_per_chnl;
res(n).median_L=median_L;
res(n).iqr_L=iqr_L;

res(n).median_H_per_chnl=median_H_per_chnl;
res(n).median_H=median_H;
res(n).iqr_H=iqr_H;
save('G:\Hamed\zf\P1\labled sleep\batch_results3with_dph_Fig_1_2_3.mat','res','-nocompression')
