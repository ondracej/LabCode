%% EEG-EMG from different times

t0=18160; %%%%%%%%%
plot_time=[0 30]; %%%%%%%%%
tlim=t0+plot_time;
t_lim=tlim(1)*fs:tlim(2)*fs;
n1=1; %%%%%%%%%% EEG channel  
X1=EEG(t_lim,n1);
n2=4; %%%%%%%%%% LFP channel  
X2=EEG(t_lim,n2);
Y=EMG(t_lim);
t=time(t_lim);
% EEG
figure('Position', pixls); 
subplot(6,1,1)
plot(t-t0,X1);  
ylabel(['EEG chnl ' num2str(eeg_chnl(n1)) ' (\muV)']);  ylim([-200 200]); xlim(plot_time)
title(['File: ' file '  ,  Time reference: ' num2str(t0)])


subplot(6,1,2)
winstep=min(.5, range(plot_time)/400);
movingwin=[.5 , winstep]; % [winsize winstep] 
params.tapers=[2 3]; % [W*T , (tappers < tW*t-1)]
params.fpass=[0 20];
params.Fs=fs;
[S,t_,f] = mtspecgramc( X1, movingwin, params );
ss=surf(t_,f,10*log10(abs(S).^2)'); ss.EdgeColor = 'none'; shading interp; view(0,90)
ylabel({'Power (dB)', 'Hz'}); xlim(plot_time);  ylim(params.fpass);
% LFP
subplot(6,1,3)
plot(t-t0,X2);  
ylabel(['EEG chnl ' num2str(eeg_chnl(n2)) ' (\muV)']);  ylim([-350 350]); xlim(plot_time)

subplot(6,1,4)
[S,t_,f] = mtspecgramc( X2, movingwin, params );
ss=surf(t_,f,10*log10(abs(S).^2)'); ss.EdgeColor = 'none'; shading interp; view(0,90)
ylabel({'Power (dB)', 'Hz'}); xlim(plot_time);   ylim(params.fpass);

subplot(6,1,5)
plot(t-t0,Y);
% ylabel('EMG');   ylim([-200 200]); xlim(plot_time)
ylabel(['EMG chnl (\muV)']);  ylim([-350 350]); xlim(plot_time)
subplot(6,1,6)
params.fpass=[0 500];
movingwin=[.5 , winstep]; % [winsize winstep] 
params.tapers=[100*.5 10]; % [W*T , (tappers < tW*t-1)]
[S,t_,f] = mtspecgramc( Y, movingwin, params );
ss=surf(t_,f,10*log10(abs(S).^2)'); ss.EdgeColor = 'none'; shading interp; view(0,90);  ylim(params.fpass);
 xlabel('Time (s)'); ylabel({'Power (dB)', 'Hz'}); xlim(plot_time);  colormap('jet')

