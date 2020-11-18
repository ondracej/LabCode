figure
Fs=2000;
for chnl=1:16
    plot(time(1000*Fs:1020*Fs),EEG(1000*Fs:1020*Fs,chnl)+300*chnl); hold on
end