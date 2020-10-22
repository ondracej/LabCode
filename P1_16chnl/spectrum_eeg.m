%% loaing data
addpath(genpath('D:\Part 1 PhD\Code\LabCode\LoadEphys_SWRanalysis'));
bird='73-03\12_03_2020'; %%%%%%%%
dir_add=['D:\Part 1 PhD\Data\' bird]; %%%%%%%

chnl_order=[1 2 3 4 5 6 8 7 ]; %%%%%%%%  10 9 11 12 13 16 15 14
[ EEG,time,~]=OpenEphys2MAT_load_save_Data(chnl_order, '133_CH',15,dir_add); % downsample ...

%%
fs=2000;
n_epoches=100; %%%%%% number of time snippets to calculate spectrum

% indicate the sleep time from the movie
t1=[0 6]; %%%%%% definite time of the inset of sleep (on the video)
t2=[7 40]; %%%%%%%% definite time when still being in sleep -10 min
ind1=(t1(1)*3600+t1(2)*60)*1.5*2000; % time to index considering fs and playback ...
% speed of movie

% notch filter
wo = 50/(fs/2);  
bw = wo/80;
[b,a] = iirnotch(wo,bw);

ind2=(t2(1)*3600+t2(2)*60)*1.5*2000;
ind=randsample((ind2-ind1),n_epoches)+ind1; 
ind=sort(ind);
clear pxx sample_avg_pxx sorted_pxx; 
for chnl=1:8 %%%%%%%%%%%
    
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
bootmax=200; % number of resampled averages in bootstrap
for j=1:bootmax % bootstrap main loop
    % Sample with replacement 1000 epoches and compute the average
    sel_epoches=randsample(n_epoches, 1000,1); 
    sample_avg_pxx(:,j)=mean(pxx(:,sel_epoches),2);
end
% For each time point sort the values, find the values that are corresponding ...
% to the 2.5% smallest and 2.5% largest
sorted_pxx=sort(sample_avg_pxx,2);
lower_bound_pxx=sorted_pxx(:,bootmax*0.025); upper_bound_pxx=sorted_pxx(:,bootmax*0.975);

figure
plot(f,10*log10(m),'b','linewidth',1); hold on
plot(f,10*log10(lower_bound_pxx),'color',[.5 .5 .5]);
plot(f,10*log10(upper_bound_pxx),'color',[.5 .5 .5]);
xlim([0 100]);
xlabel('Frequency (Hz)'); ylabel('Spectrum (dB)')
title(['Spectrum by Multitaper (' num2str(n_epoches) ' epoches), data: ' bird ...
    ' chnl: ' num2str(chnl)]); 

end % for each chnl


