
function [Delta, Gamma, feat, sleep_wake, t_feat]=sleep_feature_extract(wave_binned, t_bin, n_bins, fs, ref_binned, w_s_thersh, t_dark)
k=1;
for bin=16:n_bins-1
    Delta(k)=bandpower(wave_binned(bin,:),fs,[1 4]);
    Gamma(k)=bandpower(wave_binned(bin,:),fs,[35 45]);
    Delta_before=bandpower(wave_binned(bin-1,:),fs,[1 4]);
    Gamma_before=bandpower(wave_binned(bin-1,:),fs,[35 45]);
    Delta_after=bandpower(wave_binned(bin+1,:),fs,[1 4]);
    Gamma_after=bandpower(wave_binned(bin+1,:),fs,[35 45]);
    
    feat(k,1)=log10(Delta(k));
    feat(k,2)=Gamma(k)/(eps+Delta(k));
    feat(k,3)=Delta_after-Delta_before;
    feat(k,4)=Gamma_after/(eps+Delta_after)-Gamma_before/(eps+Delta_before);
    feat(k,5)=length(findpeaks(wave_binned(bin,:)));
    feat(k,6)=max(abs(wave_binned(bin,:)));
    feat(k,7)=std(wave_binned(bin,:));
    is_sleep=[];
    for del=0:15
        is_sleep(del+1)=max(abs(wave_binned(bin-del,:)))<w_s_thersh;
        if sum(is_sleep)==16 & t_bin(bin)>t_dark(1) & t_bin(bin)<t_dark(2) 
            sleep_wake(k)=1;
        else
            sleep_wake(k)=0;
        end
    end
    t_feat(k)=t_bin(bin);
    k=k+1;
end


end
