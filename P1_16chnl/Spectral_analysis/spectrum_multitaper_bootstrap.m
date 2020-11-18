function [spec,f,lower_bound_pxx,upper_bound_pxx] = ...
    spectrum_multitaper_bootstrap(EEG,t1,t2,spectrum_epoches,bootmax,fs)

% normal spectrum with plot

ind1=(t1(1)*3600+t1(2)*60)*1.5*2000; % time to index considering fs and playback ...
% speed of movie

ind2=(t2(1)*3600+t2(2)*60)*1.5*2000;
ind=randsample((ind2-ind1),spectrum_epoches)+ind1; 
ind=sort(ind);
clear pxx sample_avg_pxx sorted_pxx; 

% extracting n_epoches spectrums for the channel chnl
for k=1:spectrum_epoches
eegg=zscore(EEG(ind(k)+1:ind(k)+2000*3,1)); %%% length of data for PSD and the chnl

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

end
