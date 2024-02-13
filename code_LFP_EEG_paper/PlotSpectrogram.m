function PlotSpectrogram(sig,time,Fs,f_lim)

% calculate the spectrogram of the input signal and visualize it

[cfs,f] = cwt(sig,'amor',Fs); % cwt with Gabor kernel

sigLen = numel(sig);
t = (0:sigLen-1)/Fs;
ss=2*(abs(cfs(f<f_lim,:))); % spectral power to be plotted
hp = pcolor(t+time(1),f(f<f_lim),ss);
c_range=diff(caxis); % color range 
c_axis=caxis;
caxis([c_axis(1)+.1*c_range  c_axis(2)-.1*c_range]);
hp.EdgeAlpha = 0;
cl = colorbar;
cl.Label.String = "Power (dB)";

axis tight

end