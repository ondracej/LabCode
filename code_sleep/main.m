%% Loading EXG file and filter
clear; clc; close all;
[fname, faddress]=uigetfile('*','Select data file');
address=[faddress fname];
sr=1000;
[ ch1, ch2, time ] = loaddata( address, sr ); clear Address
beep; pause(.3); beep;
%% filtering
[ EEG, EMG ] = filterdata( sr, ch1, ch2 ) ;
EEG=EEG/25; EMG=EMG/25; 
%% showing part of signal for selecting different phases
start_=700; clear_part=start_+[0 50]; %%%%%%
segment_select(EEG, EMG, time, sr, clear_part);
%%
seg.wake=[1235 1280]+.1;%%%%%
seg.rem=[1657 1671]+.1; %%%%%
seg.nrem=[3600 3620]+.1; %%%
figure; 
subplot(3,1,1); plot(time,EMG); xlim(seg.wake); ylim([-1000 1000]); ylabel('W');
title('sample of EMG in different sleep phases')
subplot(3,1,3); plot(time,EMG); xlim(seg.rem); ylim([-1000 1000]);  ylabel('REM')
subplot(3,1,2); plot(time,EMG); xlim(seg.nrem); ylim([-1000 1000]);  ylabel('SW')
%% ECG removal
%% filtering
[ EEG, EMG ] = filterdata( sr, ch1, ch2 ) ;
EEG=EEG/25; EMG=EMG/25; 
% ECG removal
start=0; plot_t=[1657 1671]+start; %%%%%%%%%%%%% plot time
ecg=1; % 1: ECG rejection, 0 = no ECG rejection
if ecg==1
tr_ecg=600; % threshold for R peack detection
clear_part=EMG(plot_t(1)*sr:plot_t(2)*sr); %%%%%%%%  part of REM time
[ ECGinEMG, ecg_pat ] = ecg_reject(clear_part ,tr_ecg, sr, EMG);
% plot output of ECG rejection
figure;
subplot(3,1,1)
plot(time, EMG, 'b'); title('EMG before ECG removal')
xlim(plot_t); ylim([-800 900]); set(gca,'xtick',[])
subplot(3,1,2)
plot(time, EMG-ECGinEMG,'b'); xlim(plot_t); ylim([-1000 1000]);title('EMG after ECG removal')
set(gca,'xtick',[])
subplot(3,1,3)
plot(time, ECGinEMG,'r'); xlim(plot_t); ylim([-1000 1000]);title(['extracted ECG, Corr=' ...
    num2str(round(corr((EMG-ECGinEMG)', ECGinEMG'),2))])
EMG=EMG-ECGinEMG;
end

%%
[scor_trace,percentages]=score(EEG,EMG,seg,sr,time);
%% raw data plot
start=200; plot_t=[0 20]+start; %%%%%%%%%%%%% plot time
figure;
subplot(2,1,1)
plot(time,ch1); xlim(plot_t); 
title('Raw EEG');
subplot(2,1,2)
plot(time,ch2); xlim(plot_t);
title('Raw EMG')

%% plotting
% filtered data plot
start=50;  plot_t=[0 20]+start; %%%%%%%%%%%%%
figure;
set(gcf,'position',[40 320 1300 350]);
subplot(2,1,1)
plot(time,EEG); xlim(plot_t); ylim([-120 120])
title('EEG'); ylabel('Amplitude(\muV)')
subplot(2,1,2)
plot(time,EMG); xlim(plot_t); ylim([-800 800])
title('EMG'); ylabel('Amplitude (\muV)'); xlabel('Time (sec)')
set(gca,'XGrid' , 'on');

%% STFT and band powers
% an extract for stft and wavelet analysis
start=380;  plot_t=[0 20]+start; %%%%%%%%%%%%%
eeg_sig=EEG(min(plot_t)*sr+1 : max(plot_t)*sr);
emg_sig=EMG(min(plot_t)*sr+1 : max(plot_t)*sr);
time_sig=time(min(plot_t)*sr+1 : max(plot_t)*sr);
[~,Feeg,T1,Peeg, ~,Femg,T2,Pemg, bandpowers]=STFT(eeg_sig, emg_sig , sr);
% plot for STFT
figure;
subplot(2,1,1)
surf(T1+start,Feeg,Peeg,'edgecolor', 'none');   ylim([0 20]),xlim(plot_t); view(0,90); 
shading interp; ylabel 'Frequency (Hz)', title ' STFT EEG Spectrogram'
subplot(2,1,2)
surf(T2+start,Femg,Pemg,'edgecolor', 'none');  ylim([40 100]),xlim(plot_t); view(0,90);
shading interp; xlabel 'Time (s)', ylabel 'Frequency (Hz)', title 'STFT EMG Spectrogram'
colormap('parula');  set(gcf,'position',[40 20 1300 350]);
% plot for band powers
figure;
plot(10*log10(bandpowers),'v-c');
set(gca,'xtick',1:5,'xticklabel',{'Delta','Theta','Alpha','Beta','Gamma'})
axis([0 6 -40 5]); title ('Band Powers')
ylabel('Relative log power (dB)');
set(gcf,'position',[40 100 700 250]);

%% Frequency analysis of EEG
[pxx, f, FreqMax ]=freq_domain(eeg_sig, sr );

%% Spindle detection
% the output would be times of spindle, spindle parts, and start times of occurences
A=55; % threshold for spindle detection
samps=[4229.9*sr:4295.1*sr];
[spindleT, spindle, spindle_ext, Tspindle_st ]=spindle_detect(...
    EEG(samps)*25, EMG(samps), sr, time(samps), A );
% spectrogram and fft for spindles + save
k=3; % sample specific spindle number
[ P_spn_spec,T_spn_spec,F_spn_spec ] = specto( sr, EEG, Tspindle_st, k);
% frequncy component of the spindles
 [ f_spn_fft,p_spn_fft ] = spindle_freq( spindle_ext, sr );
% save variables
Fname=['spin_lrn_' fname];
save(Fname ,'spindleT','spindle_ext','P_spn_spec','T_spn_spec'...
    ,'F_spn_spec','f_spn_fft','p_spn_fft');  %%
