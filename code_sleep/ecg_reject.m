function [ EMG_f_ecg, ecg_pat ] = ecg_reject( EMG_ ,tr, sr, EMG)

% ECG detection and pattern extaction
peak_signal=EMG_.*(EMG_>tr);
[~,ecg_times] = findpeaks(peak_signal,'MinPeakDistance',sr/10);
halfL=round(sr/20);
ecgs=zeros(length(ecg_times)-1,2*halfL+1); n=1;
for t=ecg_times(2:end-1)
    ecgs(n,:)=EMG_(t-halfL:t+halfL); n=n+1;
end
figure;
plot((1:2*halfL+1)/sr,ecgs'); axis tight; hold on
xlabel('Time (ms)'); ylabel('Amplitude (\muV)')
ecg_pat=mean(ecgs); plot((1:2*halfL+1)/sr,ecg_pat,'y--','linewidth',2);
title('ECG template');
a = 1;
b = 2.7*fliplr(ecg_pat)/sum(abs(ecg_pat));
w = logspace(-1,3); 
h = freqs(b,a,w);
mag = abs(h);
phase = angle(h);
figure;
subplot(2,1,1), loglog(w,mag), grid on
xlabel 'Frequency (rad/s)', ylabel Magnitude, title 'Frequency response of ECG-adapted filter'
subplot(2,1,2), semilogx(w,phase), grid on
xlabel 'Frequency (rad/s)', ylabel 'Phase (rad)'
% Matched filtering
EMG_f_ecg=filtfilt(b,a,EMG);
end


