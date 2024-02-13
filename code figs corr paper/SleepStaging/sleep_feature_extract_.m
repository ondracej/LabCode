
function [Delta, Gamma, Low, feat,  t_feat]=sleep_feature_extract_(EEG3sec, t_bin, fs)
chnl=4; % 
for bin=2:size(EEG3sec,3)-1
    Delta(bin)=bandpower(EEG3sec(:,chnl,bin),fs,[1 4]);
    Gamma(bin)=bandpower(EEG3sec(:,chnl,bin),fs,[40 80]);
    Low(bin)=bandpower(EEG3sec(:,chnl,bin),fs,[1 8]);
    Delta_before=bandpower(EEG3sec(:,chnl,bin-1),fs,[1 4]);
    Gamma_before=bandpower(EEG3sec(:,chnl,bin-1),fs,[40 80]);
    Delta_after=bandpower(EEG3sec(:,chnl,bin+1),fs,[1 4]);
    Gamma_after=bandpower(EEG3sec(:,chnl,bin+1),fs,[40 80]);
    
    feat(bin,1)=log10(Delta(bin));
    feat(bin,2)=Gamma(bin)/(eps+Delta(bin));
    feat(bin,3)=Delta_after-Delta_before;
    feat(bin,4)=Gamma_after/(eps+Delta_after)-Gamma_before/(eps+Delta_before);
    feat(bin,5)=length(findpeaks(EEG3sec(:,chnl,bin)));
    feat(bin,6)=max(abs(EEG3sec(:,chnl,bin)));
    feat(bin,7)=std(EEG3sec(:,chnl,bin));

    t_feat(bin)=t_bin(bin);
end
% removing the first entry which is zero, since bin started from 2 
Delta=Delta(2:end);
Gamma=Gamma(2:end);
Low=Low(2:end);
feat=feat(2:end,:);
t_feat=t_feat(2:end);

end
