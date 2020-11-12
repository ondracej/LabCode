function [spec,lower_bound_pxx,upper_bound_pxx] = ...
    spectrum_multitaper_bootstrap(EEG,t1,t2,spectrum_epoches,bootmax,qf,fs,chnls,save_fig ...
    ,save_res_dir, bird, chnl_order)

% normal spectrum with plot

ind1=(t1(1)*3600+t1(2)*60)*1.5*2000; % time to index considering fs and playback ...
% speed of movie

% notch filter
wo = 50/(fs/2);  
bw = wo/qf; %%%%%%%%
[b,a] = iirnotch(wo,bw);

ind2=(t2(1)*3600+t2(2)*60)*1.5*2000;
ind=randsample((ind2-ind1),spectrum_epoches)+ind1; 
ind=sort(ind);
clear pxx sample_avg_pxx sorted_pxx; 
mkdir([save_res_dir bird]); % directory to save the resultant plots
for chnl=chnls %%%%%%%%%%%

% extracting n_epoches spectrums for the channel chnl
for k=1:spectrum_epoches
eegg=zscore(EEG(ind(k)+1:ind(k)+2000*3,chnl)); %%% length of data for PSD and the chnl

% removing 50Hz harmonic
eegg=filtfilt(b,a,eegg);

% spectrum 
nwin=length(eegg);
nfft=2^(nextpow2(nwin));
TW=1.5; % 2W=1; % I want to have 1 Hz resoluted, so W=1, T=3, so 2TW constant=3,
[pxx(:,k),f] = pmtm(eegg,TW,nfft,fs);
end
spec=mean(pxx,2);

% conf intervals with bootstrapping
for j=1:bootmax % bootstrap main loop
    % Sample with replacement 1000 epoches and compute the average
    sel_epoches=randsample(spectrum_epoches, 1000,1); 
    sample_avg_pxx(:,j)=mean(pxx(:,sel_epoches),2);
end
% For each time point sort the values, find the values that are corresponding ...
% to the 2.5% smallest and 2.5% largest
sorted_pxx=sort(sample_avg_pxx,2);
lower_bound_pxx=sorted_pxx(:,bootmax*0.025); upper_bound_pxx=sorted_pxx(:,bootmax*0.975);

H=figure;
plot(f,20*log10(spec),'b','linewidth',1); hold on
plot(f,20*log10(lower_bound_pxx),'color',[.5 .5 .5]);
plot(f,20*log10(upper_bound_pxx),'color',[.5 .5 .5]);
xlim([0 100]); 
xlabel('Frequency (Hz)'); ylabel('Spectrum (dB)')
title(['Spectrum by Multitaper (' num2str(spectrum_epoches) ' epoches), data: ' bird ...
    ' chnl: ' num2str(chnl_order(chnl))]); 
if save_fig
    savefig(H,[save_res_dir bird '\' num2str(chnl_order(chnl))],'compact'); % save as fig
    saveas(H,[save_res_dir bird '\' num2str(chnl_order(chnl)) '.png']); % save as png
end
end % for each chnl

end
