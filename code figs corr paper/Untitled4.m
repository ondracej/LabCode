eeg_sample=EEG3sec_healthy(:,:,4300);
figure
for k=1:13
    plot(eeg_sample(:,k)+k-1); hold on
end
ylim([-4 20])
