figure
for k=1:16
    EEG_val=EEG3sec(t_samp_ind,k,bin_indx)-.6*k;
    
    % finding the corresponding color
    all_eeg=EEG3sec(:,:,bin_indx);
    cmap=hot(256);
    col_ind=round(256*(EEG_val+.6*k-min(all_eeg,[],'all'))/range(all_eeg,'all'));
    plot(t_samp_ind/fs,EEG_val,'.','markersize',10,'markerfacecolor',...
    cmap(col_ind,:), 'markeredgecolor',cmap(col_ind,:)); 
end