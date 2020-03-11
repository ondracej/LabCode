for k=1:6
    eeg=EEG(:,k);
    save([dataname '_chnl' num2str(k)], 'eeg');
end