%% EEG-EMG spectrogram

% signal and time extraction
t0=5*3600; % 18160;
plot_time=[0 300]; %%%%%%%%%
tlim=t0+plot_time;
t_lim=tlim(1)*fs:tlim(2)*fs;
t=time(t_lim);
kk=size(EEGfilt,2);

% chronux spectrogram params
winstep=min(.5, range(plot_time)/300);
movingwin=[1 , winstep]; % [winsize winstep]
params.tapers=[2 2]; % [W*T , (tappers < tW*t-1)]
params.fpass=[0 40];
params.Fs=fs;

% figure (spectrogram)

figure
for k=1:kk
    subplot(kk,1,k)
    X=EEGfilt(t_lim,k);
    [S,t_,f] = mtspecgramc( X, movingwin, params );
    ss=surf((t_+t0)/3600,f,20*log10(abs(S))'); ss.EdgeColor = 'none'; shading interp; view(0,90); colormap(jet)
    ylabel({'EEG'; ['chnl' num2str(eeg_chnl(k))] });   xlim(tlim/3600);  ylim(params.fpass);
    if k==1
        title(['File: ' file '  ,  Time reference: ' num2str(t0)]);     xlim(tlim/3600);
    end
end

% Spectrrogram by toolbox
clear s
for k=1:kk
    X=EEGfilt(t_lim,k);
    [s(:,:,k),f,t_] = spectrogram(X,2.2*fs,2*fs,.2:1:40,fs);
end

figure
for k=1:kk
    subplot(kk,1,k)
    ss=surf((t_+t0)/3600,f,20*log10(abs(s(:,:,k)))); ss.EdgeColor = 'none'; shading interp; view(0,90); colormap(jet)
    ylabel({'EEG'; ['chnl' num2str(eeg_chnl(k))] });   xlim(tlim/3600);  ylim(params.fpass);
end

if k==1
    title(['File: ' file '  ,  Time reference: ' num2str(t0)]);     xlim(tlim/3600);
end
