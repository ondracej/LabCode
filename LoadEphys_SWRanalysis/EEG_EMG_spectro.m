%% EEG-EMG from different times

t0=4300; % 18160;
plot_time=[0 500]; %%%%%%%%%
tlim=t0+plot_time;
t_lim=tlim(1)*fs:tlim(2)*fs;
n1=1; %%%%%%%%%% EEG/LFP channel , index in EEG variable, not actual channel number (file number)
X1=EEGfilt(t_lim,n1);
n2=2; %%%%%%%%%% EEG/LFP channel , index in EEG variable, not actual channel number (file number)
X2=EEGfilt(t_lim,n2);
Y=EMGfilt(t_lim);
t=time(t_lim);
% plot EEG trace
figure('Position', pixls); 
subplot(5,1,1)
plot((t-t0)/60,X1);  
ylabel(['EEG chnl ' num2str(eeg_chnl(n1)) ' (\muV)']);  ylim([min(X1) max(X1)]/60); xlim(plot_time/60)
title(['File: ' file '  ,  Time reference: ' num2str(t0)]); ylim([-100 100])

% plot EEG spectrogram
subplot(5,1,2)
winstep=min(.5, range(plot_time)/300);
movingwin=[1 , winstep]; % [winsize winstep] 
params.tapers=[2 2]; % [W*T , (tappers < tW*t-1)]
params.fpass=[0 30];
params.Fs=fs;
[S,t_,f] = mtspecgramc( X1, movingwin, params );
ss=surf(t_/60,f,20*log10(abs(S))'); ss.EdgeColor = 'none'; shading interp; view(0,90)
ylabel({'Power (dB)', 'Hz'}); xlim(plot_time/60);  ylim(params.fpass);

% plot EMG
subplot(5,1,3)
plot((t-t0)/60,Y);
ylabel(['EMG chnl (\muV)']);  ylim([min(Y) max(Y)]); xlim(plot_time/60); ylim([-700 700])

% plot EMG spectrogram and midfrequency
subplot(5,1,5)
params.fpass=[0 300];
movingwin=[.5 , winstep]; % [winsize winstep] 
params.tapers=[100*.5 10]; % [W*T , (tappers < tW*2-1)]
[S,t_,f] = mtspecgramc( Y, movingwin, params );
ss=surf(t_/60,f,20*log10(abs(S))'); ss.EdgeColor = 'none'; shading interp; view(0,90);  ylim(params.fpass);
 xlabel('Time (min)'); ylabel({'EMG Power (dB), max-frequency', 'Hz'}); xlim(plot_time/60);  colormap('jet')
 % max frequency
[q,nd] = max(20*log10(abs(S))');
hold on
plot3(t_/60,f(nd),q,'m','linewidth',1)
 
% plot smothed instantaneous power of EMG
subplot(5,1,4)
emgpow=sum(20*log10(abs(S))');
smoo=1;
plot(t_/60,filtfilt(1/smoo*ones(1,smoo),1,emgpow)); ylabel({'smoothed';'EMG power (dB)'})
axis tight; xlim(plot_time/60); 
