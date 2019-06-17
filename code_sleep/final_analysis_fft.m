%% loading data
rng('default')
% before stress files:
bs={'spin_f_spinv6-3b','spin_f_spinv6-2b','spin_f_spinV6 -b','spin_f_spinN5-B',...
    'spin_f_spinn4-b3','spin_f_spinn4-b2','spin_f_spinN4 -B'...
    ,'spin_f_spinn3-B','spin_f_spinN3-2b','spin_f_spinN2-2','spin_f_spinN1',...
    'spin_f_spinN1-3b','spin_f_spinN1-1'}; 
% post stress files:
ps={'spin_f_spinv6-ps','spin_f_spinv6-3ps','spin_f_spinv6-2ps','spin_f_spinn5-s3',...
    'spin_f_spinn5-s2_','spin_f_spinn5-s2','spin_f_spinn4-s 2','spin_f_spinn4-s3',...
    'spin_f_spinn1-3stress'};
%
Bs_p_spn_fft=[]; 
for k=1:length(bs)
    Data=load(bs{k});
    Bs_p_spn_fft=cat(1,Bs_p_spn_fft, Data.p_spn_fft);
%     Bs_p_spn_fft=cat(1,Bs_p_spn_fft, Data.p_spn_fft);
end
% load ps
Ps_p_spn_fft=[]; 
for k=1:length(ps)
    Data=load(ps{k});
    Ps_p_spn_fft=cat(1,Ps_p_spn_fft, Data.p_spn_fft);
%     Bs_p_spn_fft=cat(1,Bs_p_spn_fft, Data.p_spn_fft);
end
%%
% plot
% data normalization
% some spindles may be detected falsly so that the fft is too high. in
% order to remove them, channels with total fft values in the 97.5% upper end were
% removed

total_pow_b=sum(Bs_p_spn_fft,2);
[~,total_pow_b_sort]=sort(total_pow_b,'descend');  n_start_b=round(0.025*length(total_pow_b_sort));
total_pow_p=sum(Ps_p_spn_fft,2);
[~,total_pow_p_sort]=sort(total_pow_p,'descend');  n_start_p=round(0.025*length(total_pow_p_sort));
ind_b=total_pow_b_sort(n_start_b:end);
ind_p=total_pow_p_sort(n_start_p:end);
Bs_p_fft_norm=Bs_p_spn_fft(ind_b,:);
Ps_p_fft_norm=Ps_p_spn_fft(ind_p,:);
K=min(size(Bs_p_fft_norm,1),size(Ps_p_fft_norm,1));
N1=size(Bs_p_fft_norm,1);  N2=size(Ps_p_fft_norm,1);
Bs_p_fft_norm=Bs_p_fft_norm(randsample(N1,K),:);
Ps_p_fft_norm=Ps_p_fft_norm(randsample(N2,K),:);

figure;
f_spn_fft=Data.f_spn_fft;
F=[3 20]; f=f_spn_fft>=F(1) & f_spn_fft <=F(2);
[~,~]=boundedline(f_spn_fft(f)',mean(Bs_p_fft_norm(:,f)),std(Bs_p_fft_norm(:,f))/sqrt(length(Bs_p_fft_norm))...
    , '-bs'...
    ,f_spn_fft(f)', mean(Ps_p_fft_norm(:,f)), std(Ps_p_fft_norm(:,f))/sqrt(length(Ps_p_fft_norm)), '--ro', 'alpha');
legend('before stress','post-stress')
xlabel('Frequency (Hz)'); ylabel('Power (\muV^2)'); xlim(F)

% ttest for fft
clear p h
for i=1:size(Bs_p_fft_norm,2)
[h(i),p(i)]=ttest(Bs_p_fft_norm(:,i),Ps_p_fft_norm(:,i),'alpha',0.05);
end

hold on
plot(f_spn_fft(h==1),700*h(h==1)-1.8,'k*','markersize',9)

% mean-frequency
mean_freqB=((Bs_p_fft_norm)*f_spn_fft)./sum((Bs_p_fft_norm),2);
mean_freqP=((Ps_p_fft_norm)*f_spn_fft)./sum((Ps_p_fft_norm),2);
mean_freq_B=mean(mean_freqB)
mean_freq_P=mean(mean_freqP)
[h,p]=ttest(mean_freqB,mean_freqP,'alpha',.01)
figure;
boxplot([mean_freqB mean_freqP]); title('Mean frequency of spindle waves')
set(gca,'xticklabel',{'before stress','post-stress'}); ylabel('Frequency (Hz)')