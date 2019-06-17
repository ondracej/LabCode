function [Seeg,Feeg,T1,Peeg, Semg,Femg,T2,Pemg, bandpowers]=STFT(eeg_sig, emg_sig , sr)

nwin=2^nextpow2(2*sr); % window size for PSD
nover=nwin-50;
Feeg=linspace(.4,20,20); % frequency points for PSD
Femg=linspace(5,300,40); % frequency points for PSD
[Seeg,Feeg,T1,Peeg]=spectrogram(eeg_sig, nwin , nover, Feeg, sr, 'yaxis');
[Semg,Femg,T2,Pemg]=spectrogram(emg_sig, nwin , nover, Femg, sr, 'yaxis');

% band powers
delta=Feeg<3.5;   delta_p=sum(Peeg(delta,:))/sum(Peeg);
teta= 3.5<=Feeg & Feeg<7.5;    teta_p=sum(Peeg(teta,:))/sum(Peeg);
alpha=7.5<=Feeg & Feeg<13;   alpha_p=sum(Peeg(alpha,:))/sum(Peeg);
beta= 13<=Feeg & Feeg<30;  beta_p=sum(Peeg(beta,:))/sum(Peeg);
gama= 30<=Feeg;            gama_p=sum(Peeg(gama,:))/sum(Peeg);
bandpowers=[delta_p, teta_p, alpha_p, beta_p, gama_p];
end