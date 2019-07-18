eeg_chnl_clean=[1 3 4 5];
extracteeg=EEGfilt(:,eeg_chnl_clean);
eeg_clean=extracteeg-repmat(mean(extracteeg,2),1,4);
%%
figure('Position', pixls); 
t0=0; % 18160;
plot_time=[time(1) time(end)];
tlim=t0+plot_time;
t_lim=tlim(1)*fs:tlim(2)*fs;
X=eeg_clean(t_lim+1,:);
t=time(t_lim+1)/3600;
Y=EMGfilt(t_lim+1,1);

nn=size(eeg_clean,2)+1; 
for n=1:nn-1 
subplot(nn,1,n)
plotredu(@plot,t-t0,X(:,n));  ylim([-80 80])
ylabel({'EEG'; ['chnl' num2str(eeg_chnl(n))] });  xlim(plot_time/3600);  xticks([]);
if n==1
    title(['File: ' file '  ,  Time reference: ' num2str(t0)]);
end
end

subplot(nn,1,n+1)
plotredu(@plot,t-t0,Y);  xlim(plot_time/3600);  ylabel({'EMG'; '(\muV)'});   xlabel('Time (h)'); 
ylim([-500 500])