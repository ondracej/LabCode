addpath(genpath('D:\Part 1 PhD\Code\LabCode\LoadEphys_SWRanalysis'));
dir_add='D:\Part 1 PhD\Data\73-03\12_03_2020'; %%%%%%%
chnl_order=[1 2 3 4 5 6 8 7 10 9 11 12 13 16 15 14]; %%%%%%%%
[ EEG,time,~]=OpenEphys2MAT_load_save_Data(chnl_order, '133_CH',15,dir_add); % downsample ...

fs=2000;
n=100; % number of time snippets to calculate spectrum
% indicate the sleep time f4rom the movie
t1=[0 6]; %%%%%% definite time of the inset of sleep
t2=[7 40]; %%%%%%%% definite time when still being in sleep -10 min
ind1=(t1(1)*3600+t1(2)*60)*1.5*2000; % time to index considering fs and playback ...
% speed of movie
ind2=(t2(1)*3600+t2(2)*60)*1.5*2000;
ind=randsample((ind2-ind1),n)+ind1; 
ind=sort(ind);
clear pxx; 
figure
for k=1:n
eegg=EEG(ind(k)+1:ind(k)+2000*1,16); %%%%%%% length of data for PSD and the chnl
nwin=20000;
[pxx(:,k),f] = pwelch(eegg,nwin,nwin/4,2^nextpow2(nwin),fs);
plot(f,10*log10(pxx(:,k)/max(pxx(:,k)))); hold on
xlim([0 55])
ylabel('PSD (dB)')
end
title('Spectrum by pwelch (100 sampleas and medain) zf: 73-03'); %%%%%%%
m=median(pxx,2);
plot(f,10*log10(m/max(m)),'k','linewidth',2)
xlabel('frequency (Hz)')


