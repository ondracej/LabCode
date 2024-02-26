
function [DG, Delta Gamma MaxAmp t_DG]=DG_extract(wave_binned, t_bin, fs)
DG=NaN(size(wave_binned,1),1);
Delta=NaN(size(wave_binned,1),1);
Gamma=NaN(size(wave_binned,1),1);
MaxAmp=NaN(size(wave_binned,1),1);

t_DG=NaN(1,size(wave_binned,1));
for bin=1:size(wave_binned,1)
    Delta(bin)=bandpower(wave_binned(bin,:),fs,[1 4]);
    Gamma(bin)=bandpower(wave_binned(bin,:),fs,[30 48]);
    MaxAmp(bin)=max(abs(wave_binned(bin,:)));
    DG(bin)=Delta(bin)/(eps+Gamma(bin));
    t_DG(bin)=t_bin(bin);
end
end
