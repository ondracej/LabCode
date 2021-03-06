%% temporal correlations between EEG channels with a focus in muscle twitch
% events, this would be a way to represent temporal functional  connectivities
clear temp_corr
% parameters for temporal correlation
bin_size=2; % size of data bin for computing temporal correlations
step_corr=.1; % time points for computation of temporal correlation 

% time frame of interest
t0=14902; % 18160;
plot_time=[0 15];
k=1; % counter for loop, sample number for temporal correlations within a block
for t_corr=t0+plot_time(1):step_corr:t0+plot_time(2)
    t_lim=round((t_corr-bin_size/2)*fs:(t_corr+bin_size/2)*fs);
    X=EEGfilt(t_lim,:); 
    temp_corr_mat=corrcoef(X); 
    corrs=tril(temp_corr_mat,-1); % computes the lower triangle of correlation matrix, since it is a symmetric matrix with ones along the main diagonal,
    % in this matrix the upper triangle (including the main diagonal ar replaced with zero)
    corrs_vector=corrs(corrs~=0); % get the address of non-zero elements and frtch them.
    temp_corr(:,k)=corrs_vector(:);     k=k+1; 
end
t_corr=t0+plot_time(1):step_corr:t0+plot_time(2); % time stamp for temp_corr

% showing traces of filtered EEG
tlim=t0+plot_time;
t_lim=tlim(1)*fs:tlim(2)*fs;
X=EEGfilt(t_lim,:);
Y=EMGfilt(t_lim,2);
t=time(t_lim);

figure('Position', pixls); 
nn=size(EEG,2)+2; % number of all channels for subplot, EEGs + EMG + temporal correlation (temporal functional connectivity)
% first plottinhg EEG channels
for n=1:nn-2 
subplot(nn,1,n)
plotredu(@plot,(t-t0),X(:,n));  
ylabel({'EEG'; ['chnl ' num2str(eeg_chnl(n))] });  xlim(plot_time);  xticks([]); ylim([-120 120])
if n==1
    title(['File: ' file '  ,  Time reference: ' num2str(t0) ' sec']);
end
end
% then plotting EMG
subplot(nn,1,n+1)
plotredu(@plot,t-t0,Y);  xlim(plot_time/60);  ylabel({'EMG'; '(\muV)'});  ylim([-220 220])

% averaging over EEG-EEG correlations, EEG-DVR correlations, and DVR-DVR
% correlations
eeg_eeg=[1,2,5]; %%%%%%%%%%%%%%%% indexes of corr matrix (N by N, where N is number of eeg channels) for EEG-EEG interaction
eeg_dvr=[3,4,6,7,8,9];
dvr_dvr=[10];
eeg_eeg_corr=mean(temp_corr(eeg_eeg,:),1);
eeg_dvr_corr=mean(temp_corr(eeg_dvr,:),1);
dvr_dvr_corr=mean(temp_corr(dvr_dvr,:),1);

subplot(nn,1,n+2)
plotredu(@plot,(t_corr-t0),eeg_eeg_corr,'c-','linewidth',1.5);    ylabel('temporal corr');    xlim(plot_time); ylim([0 1])
hold on; 
plotredu(@plot,(t_corr-t0),eeg_dvr_corr,'m--','linewidth',1.5);    ylabel('temporal corr');    xlim(plot_time); ylim([0 1])
plotredu(@plot,(t_corr-t0),dvr_dvr_corr,'k:','linewidth',1.5);    ylabel('temporal corr');    xlim(plot_time); ylim([0 1])
legend('EEG-EEG','EEG-DVR','DVR-DVR')
% line([plot_time],[0 0],'Color','k','LineStyle','--');  
xlabel('Time (sec)')