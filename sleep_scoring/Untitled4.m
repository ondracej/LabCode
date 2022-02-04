eeg_sample=eeg_(:,:,1100);
figure
for k=1:16
    plot(eeg_sample(:,k)+k-1); hold on
    title('w041')
end
