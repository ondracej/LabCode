%% loaing data
addpath(genpath('D:\Part 1 PhD\Code\LabCode\LoadEphys_SWRanalysis'));
bird='73_03 12_03_2020'; %%%%%%%% name of the folder containing ephys
dir_add=['D:\Part 1 PhD\Data\' bird]; %%%%%%% to read data from
save_res_dir='D:\Part 1 PhD\Res\Spectrum\'; %%%%%%% directory to save figures
chnl_order=[1 2 3 4 5 6 8 7 10 9 11 12 13 16 14 15]; %%%%%%%%  
[EEG,time,~]=OpenEphys2MAT_load_save_Data(chnl_order, '133_CH',15,dir_add); %%%%%%
% indicate the sleep time from the movie
t1=[0 20]; %%%%%% definite time of the inset of sleep (on the video)
t2=[7 50]; %%%%%%%% definite time when still being in sleep -10 min

% save variables
save(dir_add,'EEG', 'time', 'chnl_order','t1','t2','-v7.3');
%% or load the MAT file data
save_res_dir='D:\Part 1 PhD\Res\Spectrum\'; %%%%%%% directory to save figures
eeg_data=load([dir_add '\' bird]);
EEG=eeg_data.EEG;  time=eeg_data.time;  chnl_order=eeg_data.chnl_order;
t1=eeg_data.t1;  t2=eeg_data.t2;
clear eeg_data
%% normal spectrum with plot
% input parameters:
% save_fig,  save the figures? (1=yes, 0=no)
% spectrum_epoches  number of time snippets to calculate spectrum
% bootmax: number of resampled averages in bootstrap
% qf: coefficient for nutch filter
% chnl=channels to consider for spectrum %1:size(EEG,2) 

spectrum_epoches=100; % default: 1000
bootmax=200; % default: 2000
qf=50; % range: from 20 to 1500 depending on the SNR
fs=2000;
chnls=3; % default: 1:16
save_fig=0; 
[spec,lower_bound_pxx,upper_bound_pxx] = ...
    spectrum_multitaper_bootstrap(EEG,t1,t2,spectrum_epoches,bootmax,qf,fs,chnls,...
    save_fig,save_res_dir, bird, chnl_order);

%% fitting a c*1/f to ther spectrogram
% one_over_f=@(c,f) c/f;  % the fitting function, a multiple if 1/f
% spec_fit=fit(f(2:end),20*log(spec(2:end)),one_over_f);

figure
%  coefficient for 1/f to fit the spectrum the best, least square fit:
samps=2:500; % samples of spectrum that matter for fitting
c=sum(log(spec(samps)).*log(1./f(samps)))/sum(log(1./f(samps)).^2);  
plot(f(2:end),20*log(spec(2:end)),'b'); hold on
plot(f(2:end),c*20*log(1./f(2:end)),'r-' ); xlim([0 100]); ylim([-170 -30])
xlabel('Frequency (Hz)'); ylabel('Power (dB)')
title(bird)

%% 1/f removal using differentiator filter
dFilt = designfilt('differentiatorfir','FilterOrder',3);
fvtool(dFilt,'MagnitudeDisplay','Zero-phase')
