%% spectrum across groups
% for nREM
nwin=size(EEG,1);
nfft=2^(nextpow2(nwin));
TW=2.5; % 2W=1; % I want to have .5 Hz resoluted, so W=1, T=5, so 2TW constant=3
clear pxx_SWS pxx_REM pxx_IS pxx_Wake

% for SWS
bin_indx=find(strcmp(auto_label,'SWS')) ;
ind_stage=randsample(length(bin_indx),138);
n=1;
for k=1:138
    if max(EEG(:,chnl,bin_indx(ind_stage(k))))<3.5 % EEG less than 3 std
        [pxx_SWS(:,n),f] = pmtm(EEG(:,chnl,bin_indx(ind_stage(k))),TW,nfft,round(fs)); n=n+1
    end
end

% for REM
bin_indx=find(strcmp(auto_label,'REM')) ;
ind_stage=randsample(length(bin_indx),138);
n=1;
for k=1:138
    if max(EEG(:,chnl,bin_indx(ind_stage(k))))<3.5 % EEG less than 3 std
        [pxx_REM(:,n),f] = pmtm(EEG(:,chnl,bin_indx(ind_stage(k))),TW,nfft,round(fs)); n=n+1
    end
end

% for wake
bin_indx=find(strcmp(auto_label,'Wake')) ;
ind_stage=randsample(length(bin_indx),138);
n=1;
for k=1:138
    if max(EEG(:,chnl,bin_indx(ind_stage(k))))<3.5 % EEG less than 3 std
        [pxx_Wake(:,n),f] = pmtm(EEG(:,chnl,bin_indx(ind_stage(k))),TW,nfft,round(fs)); n=n+1
    end
end

% for IS
bin_indx=find(strcmp(auto_label,'IS')) ;
ind_stage=randsample(length(bin_indx),138);
n=1;
for k=1:138
    if max(EEG(:,chnl,bin_indx(ind_stage(k))))<3.5 % EEG less than 3 std
        [pxx_IS(:,n),f] = pmtm(EEG(:,chnl,bin_indx(ind_stage(k))),TW,nfft,round(fs)); n=n+1
    end
end
% computing mean and STE
mean_spec_SWS=mean(pxx_SWS,2);
mean_spec_REM=mean(pxx_REM,2);
mean_spec_Wake=mean(pxx_Wake,2);
mean_spec_IS=mean(pxx_IS,2);

figure
plot(f,log10(mean_spec_SWS),'b','linewidth',2);  hold on
plot(f,log10(mean_spec_REM),'r','linewidth',2)
plot(f,log10(mean_spec_Wake),'color',[1 .8 0],'linewidth',2)
plot(f,log10(mean_spec_IS),'c','linewidth',2)
xlim([0 138]); ylim([-4.7 -0.1]) %%%%%%%%
ylabel('Log of power')
legend('SWS','REM','Wake','IS')
xlabel('Freequency (Hz)')