% computing the common average of some selected channels and subtracting
% this from channels
eeg_chnl_clean=[1 3 4 5];
extracteeg=EEGfilt(:,eeg_chnl_clean);
eeg_clean=extracteeg-repmat(mean(extracteeg,2),1,4);
%% the figure for traces
figure('Position', pixls); 
t0=1*3600; % 18160;
plot_time=[0 30];
tlim=t0+plot_time;
t_lim=tlim(1)*fs:tlim(2)*fs;
X=eeg_clean(t_lim+1,:);
t=time(t_lim+1);
Y=EMGfilt(t_lim+1,1);

nn=size(eeg_clean,2)+1; 
for n=1:nn-1 
subplot(nn,1,n)
plotredu(@plot,(t-t0)/3600,X(:,n));  ylim([-80 80])
ylabel({'EEG'; ['chnl' num2str(eeg_chnl(n))] });    xticks([]); xlim(plot_time/3600);
if n==1
    title(['File: ' file '  ,  Time reference: ' num2str(t0)]);
end
end

subplot(nn,1,n+1)
plotredu(@plot,(t-t0)/3600,Y);  xlim(plot_time/3600);  ylabel({'EMG'; '(\muV)'});   xlabel('Time (h)'); 
ylim([-500 500])