% loading data
rng('default')
% before stress files:
bs={'spinv6-3b','spinv6-2b','spinV6 -b','spinN5-B','spinn4-b3','spinn4-b2','spinN4 -B'...
    ,'spinn3-B','spinN3-2b','spinN2-2','spinN1','spinN1-3b','spinN1-1'}; 
% post stress files:
ps={'spinv6-ps','spinv6-3ps','spinv6-2ps','spinn5-s3','spinn5-s2_','spinn5-s2',...
    'spinn4-s 2','spinn4-s3','spinn1-3stress'};
% load bs
Bs_P_spn_spec=[]; Bs_p_spn_fft=[];
for k=1:length(bs)
    Data=load(bs{k});
    Bs_P_spn_spec=cat(3,Bs_P_spn_spec, Data.P_spn_spec);
%     Bs_p_spn_fft=cat(1,Bs_p_spn_fft, Data.p_spn_fft);
end
% load ps
Ps_P_spn_spec=[]; Ps_p_spn_fft=[];
for k=1:length(ps)
    Data=load(ps{k});
    Ps_P_spn_spec=cat(3,Ps_P_spn_spec, Data.P_spn_spec);
%     Ps_p_spn_fft=cat(1,Ps_p_spn_fft, Data.p_spn_fft);
end

% ttest for spectrograms
K=min(size(Bs_P_spn_spec,3),size(Ps_P_spn_spec,3));
N1=size(Bs_P_spn_spec,3);  N2=size(Ps_P_spn_spec,3);
for i=1:length(Data.F_spn_spec)
for j=1:length(Data.T_spn_spec)
[h(i,j),p(i,j)]=ttest(Bs_P_spn_spec(i,j,randsample(N1,K)) , Ps_P_spn_spec(i,j,randsample(N2,K)));

end
end
%%
figure;
subplot(1,3,1)
imagesc(Data.T_spn_spec-.5,Data.F_spn_spec,mean(Bs_P_spn_spec,3),[0 35]);  colorbar 
axis xy; xlabel('Time (sec)'); ylabel('Frequency (Hz)'); colormap('jet(1000)')
title('mean spectrogram before stress'); ylim([3 20])
subplot(1,3,2)
imagesc(Data.T_spn_spec-.5,Data.F_spn_spec,mean(Ps_P_spn_spec,3),[0 35]);  colorbar 
axis xy; xlabel('Time (sec)'); ylabel('Frequency (Hz)'); colormap('jet(1000)')
title('mean spectrogram post-stress'); ylim([3 20])
subplot(1,3,3)
imagesc(Data.T_spn_spec-.5,Data.F_spn_spec,min(~(p<1e-2),p));  colorbar 
axis xy; xlabel('Time (sec)'); ylabel('Frequency (Hz)'); colormap('jet(1000)')
title('p-value in spectrogram difference'); ylim([3 20])
