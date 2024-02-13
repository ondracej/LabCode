load('72-94_07-06_scoring.mat'); %%%%%%

t_bin0=round((397350+500) /(30)); %%%%%%% turning frame number to the bin nuzmber 
eeg=zeros(16,size(EEG,1)*10);
for chnl=1:16
    eeg_chnl=[];
    for k=0:9
        eeg_chnl=[eeg_chnl squeeze(EEG(:,chnl,t_bin0+k)')];
    end
    eeg(chnl,:)=eeg_chnl;
end

% visualization
t=((1:length(eeg))/length(eeg))*15+t_bin0;
figure
for chnl=1:16
plot(t,zscore(eeg(chnl,:))/8+chnl,'k'); hold on
end
c=3;
plot(t,chnl+ones(size(t))*c*iqr(eeg(chnl,:))/(8*std(eeg(chnl,:))),'b--');