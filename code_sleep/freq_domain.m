function [pxx, f, FreqMax ]=freq_domain(eeg_sig, sr )
% Frequency analysis of EEG
Nwin=2^nextpow2(4*sr);   Noverlap=round(Nwin*.8);    Nfft=2*Nwin;
[pxx,f] = pwelch(eeg_sig,Nwin,Noverlap,Nfft,sr);
h=figure;
hLIN = plot(f,10*log10(pxx));
xdata = hLIN.XData;
ydata = hLIN.YData;
[peakf,idxMax] = max(ydata);
FreqMax = xdata(idxMax);
hold on
plot([FreqMax,FreqMax],ylim,'r--');
axis([0 40 0 peakf+1 ]); ylabel('Spectral Power (dB)'); xlabel('Frequency (Hz)')
xlim([0 20])
text(FreqMax,10*log10(pxx(f==FreqMax)),[num2str(round(FreqMax,1)) 'Hz'])
set(gcf,'position',[20 20 350 200]);
end