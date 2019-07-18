EMG_diff=EMG(:,1)-EMG(:,2);

ecgFilt = designfilt('lowpassiir','FilterOrder',2,'PassbandFrequency',10,'PassbandRipple',0.2,'SampleRate',fs);
ecg=filtfilt(emgFilt,EMG_diff);
%%
figure; 
t0=4430; % 18160;
plot_time=[0 20];
tlim=t0+plot_time;
t_lim=tlim(1)*fs:tlim(2)*fs;
X=ecg(t_lim,:);
t=time(t_lim);

plotredu(@plot,t-t0,X);  
ylabel('ECG');  xlim(plot_time);
