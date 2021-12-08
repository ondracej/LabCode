fs=30000/64;
chnl=4;
if exist('EEG_','var')
    EEG=EEG_;
end
% reshaping data in 3 sec windows, in case bins are 1.5 sec
if length(mov)>27000
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

%%  plot EEG3sec_ to find and ignore noisy chnls
for j=1:5
figure
bin_indx=j*2400; %randsample(size(EEG3sec_,3)-1000,1)+500; % index to the first nREM bin
EEG3sec_n=size(EEG3sec,1);
dist=1; % in std
for k=1:16
    plot(round(1:EEG3sec_n)/fs,(EEG3sec(:,k,bin_indx))+dist*k); hold on
end
yticks(2*(1:16)), yticklabels(compose('%01d', 1:16));
ylabel('Channel number')
xlabel('Time (sec)')
title(fname);
print(['Z:\zoologie\HamedData\CorrelationPaper\72-00overview\eeg ' fname(1:12) num2str(2*j)],'-dpng')
end
close all