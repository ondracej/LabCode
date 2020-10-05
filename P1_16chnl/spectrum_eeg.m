fs=2000;
n=40; % number of time snippets to calculate spectrum
t=randsample(length(EEG)-21*10^6,n)+10*10^6;
t=sort(t);
clear pxx; 
figure
for k=1:n
eegg=EEG(t(k)+1:t(k)+10^5,16);
nwin=20000;
[pxx(:,k),f] = pwelch(eegg,nwin,nwin/4,2^nextpow2(nwin),fs);
plot(f,10*log10(pxx(:,k)/max(pxx(:,k)))); hold on
xlim([0 55])
ylabel('PSD (dB)')
end
title('Spectrum by pwelch (100 sampleas and medain) zf: juv w00-20'); %%%%%%%
m=median(pxx,2);
plot(f,10*log10(m/max(m)),'k','linewidth',2)
xlabel('frequency (Hz)')


