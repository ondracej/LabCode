
addpath(genpath('D:\Part 1 PhD\Code\LabCode\LoadEphys_SWRanalysis'));
addpath(genpath('D:\Part 1 PhD\Code\LabCode\P1_16chnl'));

%% loaing data
bird='w0021 17_08_2020'; %%%%%%%% name of the folder containing ephys
dir_add=['D:\Part 1 PhD\Data\' bird]; %%%%%%% to read data from
save_res_dir='D:\Part 1 PhD\Res\spectrum 1over f fitting'; %%%%%%% directory to save figures
chnl_order=[1 2 3 4 5 7 6 8 10 9 11 12 13 16 14 15]; %%%%%%%%  
[EEG,time,~]=OpenEphys2MAT_load_save_Data(chnl_order, '142_CH',15,dir_add); %%%%%%
% indicate the sleep time from the movie
t1=[0 20]; %%%%%% definite time of the inset of sleep (on the video)
t2=[7 50]; %%%%%%%% definite time when still being in sleep -10 min

% save variables
save(dir_add,'EEG', 'time', 'chnl_order','t1','t2','-v7.3');
%% or load the MAT file data
bird='W0020 24_09_2020'; %%%%%%%% name of the folder containing ephys
dir_add=['D:\Part 1 PhD\Data\' bird]; %%%%%%% to read data from
save_res_dir='D:\Part 1 PhD\Res\spectrum 1over f fitting'; %%%%%%% directory to save figures
eeg_data=load([dir_add '\' bird]);
EEG=eeg_data.EEG;  time=eeg_data.time;  chnl_order=eeg_data.chnl_order;
t1=eeg_data.t1;  t2=eeg_data.t2;
clear eeg_data
%% spectrum with plots

% notch filter
fs=2000;
wo = 50/(fs/2);  
qf=1100; %%%%%%%%%% for spectrum before 1/f removal. from 20 to 1500 depending on the SNR
bw = wo/qf; 
[b,a] = iirnotch(wo,bw);


% spectrum with sampling %
% input parameters:
% save_fig,  save the figures? (1=yes, 0=no)
% spectrum_epoches  number of time snippets to calculate spectrum
% bootmax: number of resampled averages in bootstrap
% qf: coefficient for nutch filter
% chnl=channels to consider for spectrum %1:size(EEG,2) 

spectrum_epoches=1000; %%%%%%%%% default: 1000
bootmax=2000; %%%%%%% default: 2000
chnl=10; %%%%%%%%% default: 1:16
EEG_=filtfilt(b,a,EEG(:,chnl));  % removing 50Hz harmonic

[spec,f,lower_bound_pxx,upper_bound_pxx] = ...
    spectrum_multitaper_bootstrap(EEG_,t1,t2,spectrum_epoches,bootmax,fs);

H=figure;
subplot(2,1,1)
plot(f,20*log10(spec),'b','linewidth',1); hold on
plot(f,20*log10(lower_bound_pxx),'color',[.5 .5 .5]);
plot(f,20*log10(upper_bound_pxx),'color',[.5 .5 .5]);
xlim([0 100]); 
xlabel('Frequency (Hz)'); ylabel('Power (dB)')
title(['Spectrum by Multitaper (' num2str(spectrum_epoches) ' epoches), data: ' bird ...
    ' chnl: ' num2str(chnl)]); 

% fitting a c*1/f to the spectrogram

%  coefficient for 1/f to fit the spectrum the best, least square fit:
samps=2:500; % samples of spectrum that matter for fitting
c=sum(log10(spec(samps)).*log10(1./f(samps)))/sum(log10(1./f(samps)).^2);  
plot(f(samps),c*20*log10(1./f(samps)),'r-' ); xlim([0 100]); 
ylim([min(20*log10(spec(samps)))-10 max(20*log10(spec(samps)))+10]);

% 1/f removal using differentiator filter
ord=2; % filter order, even integer
b=(1/2)*[1 zeros(1,ord-2) -1]*fs; a=1;
eeg_=filtfilt(b,a,EEG_(:,1));
% plot the spectrum after diffrentiator filtering

[spec_,f,lower_bound_pxx_,upper_bound_pxx_] = ...
    spectrum_multitaper_bootstrap(eeg_,t1,t2,spectrum_epoches,bootmax,fs);

subplot(2,1,2)
plot(f,20*log10(spec_),'b','linewidth',1); hold on
plot(f,20*log10(lower_bound_pxx_),'color',[.5 .5 .5]);
plot(f,20*log10(upper_bound_pxx_),'color',[.5 .5 .5]);
xlim([0 100]); 
xlabel('Frequency (Hz)'); ylabel('Power (dB)')
title(['Spectrum after 1/f removal']); 

% save the figure
%     mkdir([save_res_dir bird 'subplot']); % directory to save the resultant plots
    savefig(H,[save_res_dir  '\' bird],'compact'); % save as fig
    saveas(H,[save_res_dir '\'  bird '.png']); % save as png
