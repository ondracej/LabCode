
function [Delta, Gamma, feat, t_feat]=sleep_feature_extract(wave_binned, t_bin, n_bins, fs)
k=1;
Delta=NaN(1,n_bins-2);
Gamma=NaN(1,n_bins-2);
t_feat=NaN(1,n_bins-2);
feat=NaN(n_bins-2,7);
for bin=2:n_bins-1
    Delta(k)=bandpower(wave_binned(bin,:),fs,[1 4]);
    Gamma(k)=bandpower(wave_binned(bin,:),fs,[30 48]);
    Delta_before=bandpower(wave_binned(bin-1,:),fs,[1 4]);
    Gamma_before=bandpower(wave_binned(bin-1,:),fs,[30 48]);
    Delta_after=bandpower(wave_binned(bin+1,:),fs,[1 4]);
    Gamma_after=bandpower(wave_binned(bin+1,:),fs,[30 48]);
    
    feat(k,1)=log10(Delta(k));
    feat(k,2)=Gamma(k)/(eps+Delta(k));
    feat(k,3)=Delta_after-Delta_before;
    feat(k,4)=Gamma_after/(eps+Delta_after)-Gamma_before/(eps+Delta_before);
    feat(k,5)=length(findpeaks(wave_binned(bin,:)));
    feat(k,6)=max(abs(wave_binned(bin,:)));
    feat(k,7)=std(wave_binned(bin,:));
    t_feat(k)=t_bin(bin);
    k=k+1;
end


end
