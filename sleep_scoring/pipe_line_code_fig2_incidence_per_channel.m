fs=30000/64;
chnl=4; % non-noisy channel
% reshaping data in 3 sec windows, in case bins are 1.5 sec
if exist('EEG_')==1
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
rand_inds=randsample(length(valid_inds),1000);
sample_valid_inds=valid_inds(rand_inds);
fs=30000/64;
LH=NaN(1,length(sample_valid_inds)); % low/high freq ratio
chnl_count=0;
for chnl=valid_chnls
    kk=1;
    for k=sample_valid_inds
        % settings for multitaper
        nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
        [pxx,f]=pmtm(EEG3sec(:,chnl,k),TW,nfft,round(fs));
        px_low=norm(pxx(f<8 & f>1.5));
        px_high=norm(pxx(f<49 & f>30));
        LH(kk)=px_low/px_high; kk=kk+1;
    end
    chnl_count=chnl_count+1;
    LH_chnls(chnl_count)=median(LH);
end

% local wave per channel 
[local_wave_per_chnl,~] = detect_local_wave(EEG3sec(:,valid_chnls,:),fs,thresh,sample_valid_inds);


%% saving variables
loaded_res=load('G:\Hamed\zf\P1\labled sleep\batch_results2.mat');
res=loaded_res.res;
res(n).bird=fname;
res(n).LH_chnls=LH_chnls;
res(n).local_wave_per_chnl=local_wave_per_chnl;

save('G:\Hamed\zf\P1\labled sleep\batch_results2.mat','res','-nocompression')
