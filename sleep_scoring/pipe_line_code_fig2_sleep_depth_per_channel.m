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

%% saving variables
loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_results4.mat');
res=loaded_res.res;

res(n).bird=fname;
res(n).median_LH_per_chnl=median_LH_per_chnl; 

save('G:\Hamed\zf\P1\labled sleep\batch_results4.mat','res','-nocompression')
