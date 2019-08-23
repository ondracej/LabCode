EMG_diff=EMG(:,1)-EMG(:,2);

ecgFilt = designfilt('bandpassiir','FilterOrder',2, 'HalfPowerFrequency1',1,'HalfPowerFrequency2',5,'SampleRate',fs);
ecg=filtfilt(ecgFilt,EMG_diff);
%%
figure; 
t0=4430; % 18160;
plot_time=[0 20];
tlim=t0+plot_time;
t_lim=tlim(1)*fs:tlim(2)*fs;
X=ecg(t_lim,:);
t=time(t_lim);
subplot(3,1,1)
plot(t-t0,EMGfilt(t_lim,1));
ylabel('EMG1');  xlim(plot_time);

subplot(3,1,2)
plot(t-t0,EMGfilt(t_lim,2));
ylabel('EMG2');  xlim(plot_time);

subplot(3,1,3)
plotredu(@plot,t-t0,X);  
ylabel('ECG');  xlim(plot_time);
