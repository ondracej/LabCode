%% loaing data
addpath(genpath('D:\Part 1 PhD\Code\LabCode\LoadEphys_SWRanalysis'));
bird='w0009 02_05_2020'; %%%%%%%%
dir_add=['D:\Part 1 PhD\Data\' bird]; %%%%%%% to read data from
save_res_dir='D:\Part 1 PhD\Res\Spectrum\'; %%%%%%% directory to save figures
chnl_order=[1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15]; %%%%%%%%  
[ EEG,time,~]=OpenEphys2MAT_load_save_Data(chnl_order, '133_CH',15,dir_add); %%%%%%
% indicate the sleep time from the movie
t1=[0 10]; %%%%%% definite time of the inset of sleep (on the video)
t2=[7 45]; %%%%%%%% definite time when still being in sleep -10 min
%% save variables
save(dir_add,'EEG', 'time', 'chnl_order','t1','t2','-v7.3');
%% normal spectrum with plot

fs=2000;
n_epoches=1000; %%%%%% number of time snippets to calculate spectrum
bootmax=2000; %%%%%%% number of resampled averages in bootstrap

ind1=(t1(1)*3600+t1(2)*60)*1.5*2000; % time to index considering fs and playback ...
% speed of movie

% notch filter
wo = 50/(fs/2);  
bw = wo/1500;
[b,a] = iirnotch(wo,bw);

ind2=(t2(1)*3600+t2(2)*60)*1.5*2000;
ind=randsample((ind2-ind1),n_epoches)+ind1; 
ind=sort(ind);
clear pxx sample_avg_pxx sorted_pxx; 
mkdir([save_res_dir bird]); % directory to save the resultant plots
for chnl=1:size(EEG,2) %%%%%%%%%%%

% extracting n_epoches spectrums for the channel chnl
for k=1:n_epoches
eegg=zscore(EEG(ind(k)+1:ind(k)+2000*3,chnl)); %%%%%%% length of data for PSD ...
% and the chnl

% removing 50Hz harmonic
eegg=filtfilt(b,a,eegg);

% spectrum 
nwin=length(eegg);
nfft=2^(nextpow2(nwin));
T=3; TW=1.5; % 2W=1; % I want to have 1 Hz resoluted
[pxx(:,k),f] = pmtm(eegg,TW,nfft,fs);
end
m=mean(pxx,2);

% conf intervals with bootstrapping
for j=1:bootmax % bootstrap main loop
    % Sample with replacement 1000 epoches and compute the average
    sel_epoches=randsample(n_epoches, 1000,1); 
    sample_avg_pxx(:,j)=mean(pxx(:,sel_epoches),2);
end
% For each time point sort the values, find the values that are corresponding ...
% to the 2.5% smallest and 2.5% largest
sorted_pxx=sort(sample_avg_pxx,2);
lower_bound_pxx=sorted_pxx(:,bootmax*0.025); upper_bound_pxx=sorted_pxx(:,bootmax*0.975);

H=figure;
plot(f,10*log10(m),'b','linewidth',1); hold on
plot(f,10*log10(lower_bound_pxx),'color',[.5 .5 .5]);
plot(f,10*log10(upper_bound_pxx),'color',[.5 .5 .5]);
xlim([0 100]); ylim([-35 -5])
xlabel('Frequency (Hz)'); ylabel('Spectrum (dB)')
title(['Spectrum by Multitaper (' num2str(n_epoches) ' epoches), data: ' bird ...
    ' chnl: ' num2str(chnl_order(chnl))]); 
savefig(H,[save_res_dir bird '\' num2str(chnl_order(chnl))],'compact'); % save as fig
saveas(H,[save_res_dir bird '\' num2str(chnl_order(chnl)) '.png']); % save as png

end % for each chnl

