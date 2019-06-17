function [ F,Pxx ] = spindle_freq( spindle_ext, sr )
Pxx=zeros(length(spindle_ext),39); %Pxx corresponds to 2:40 Hz
nwin=2^nextpow2(.5*sr); 
freq=2:1:40; 
for k=1:length(spindle_ext)
    x=spindle_ext{k};
[~,F,~,P]=spectrogram(x,nwin,nwin-10,freq,sr,'yaxis');
Pxx(k,:)=interp1(F,sum(P,2)',freq);
end

end

