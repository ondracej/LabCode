function [ P,T1,F1 ] = specto( sr, EEG, Tspindle_st, k)
% k is one spesific spindle number
% Spectrogram
Fs=sr;
n=512; %Number of points in moving window
freq=2:40; %Frequencies we are interested in
cueInd=round(Tspindle_st(k)*Fs); %First cue SAMPLE
indTrial =cueInd-Fs/2:cueInd+2.5*Fs; %-500 ms to +2000 ms around cue
[~,F1,T1,P1]=spectrogram(EEG(indTrial),n,n-40,freq,Fs,'yaxis');
maxDb=35; %Maximum on scale for decibels.
figure 
imagesc(T1-.5,F1,10*log10(P1),[0 maxDb]); colormap('jet'); colorbar %Plot spectrogrm
axis xy; xlabel('Time (sec)'); ylabel('Frequency (Hz)');
title(['spectrogram of sample spindle number ' num2str(k)]);

% all spondles in 3D matrix
Fs=sr;
n=512; %Number of points in moving window
freq=2:40; %Frequencies we are interested in
P=zeros(length(F1),length(T1),length(Tspindle_st)); % initialization
for k=1:length(Tspindle_st)
cueInd=round(Tspindle_st(k)*Fs); %First cue SAMPLE
indTrial =cueInd-Fs/2:cueInd+2.5*Fs; %-500 ms to +2000 ms around cue
[~,~,~,P(:,:,k)]=spectrogram(EEG(indTrial),n,n-40,freq,Fs,'yaxis');
end
maxDb=25; %Maximum on scale for decibels.
figure 
imagesc(T1-.5,F1,10*log10(mean(P,3)),[0 maxDb]); colormap('jet'); colorbar %Plot spectrogrm
axis xy; xlabel('Time (sec)'); ylabel('Frequency (Hz)');
title(['mean spectrogram of all spindles ']);

end

