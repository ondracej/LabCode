% plot of temporal dynamics of congruence for all birds along the night of
% sleep
clear;
data_dir='Z:\HamedData\LocalSWPaper\PaperData';

% loading dat from all birds and averaging on each hour
load ([data_dir '\' 'w027_cong_temporal']);

% average cong along the night
for h=1:12
    inds_hr=t_bin_in_range>=(h-1)*3600 & t_bin_in_range<h*3600;
    sws_cong_027(h)=mean(sws_congruence(inds_hr));
    sws_lfp_027(h)=mean(sws_bins(inds_hr))/101;
    sws_ref_027(h)=mean(sws_bins_ref(inds_hr))/101;

    rem_cong_027(h)=mean(rem_congruence(inds_hr));
    rem_lfp_027(h)=mean(rem_bins(inds_hr))/101;
    rem_ref_027(h)=mean(rem_bins_ref(inds_hr))/101;
end

load ([data_dir '\' 'w025_cong_temporal']);

% average cong along the night
for h=1:12
    inds_hr=t_bin_in_range>=(h-1)*3600 & t_bin_in_range<h*3600;
    sws_cong_025(h)=mean(sws_congruence(inds_hr));
    sws_lfp_025(h)=mean(sws_bins(inds_hr))/101;
    sws_ref_025(h)=mean(sws_bins_ref(inds_hr))/101;

    rem_cong_025(h)=mean(rem_congruence(inds_hr));
    rem_lfp_025(h)=mean(rem_bins(inds_hr))/101;
    rem_ref_025(h)=mean(rem_bins_ref(inds_hr))/101;
end

load ([data_dir '\' 'w042_cong_temporal']);

% average cong along the night
for h=1:12
    inds_hr=t_bin_in_range>=(h-1)*3600 & t_bin_in_range<h*3600;
    sws_cong_042(h)=mean(sws_congruence(inds_hr));
    sws_lfp_042(h)=mean(sws_bins(inds_hr))/101;
    sws_ref_042(h)=mean(sws_bins_ref(inds_hr))/101;

    rem_cong_042(h)=mean(rem_congruence(inds_hr));
    rem_lfp_042(h)=mean(rem_bins(inds_hr))/101;
    rem_ref_042(h)=mean(rem_bins_ref(inds_hr))/101;
end

% 
r=[1 .5 0]; 
s=[.4 .4 1]; 
i=[0 .83 .98]; 
w=.3*[1 1 1];
figure;
subplot(3,1,1)
errorbar(1:12,mean(3*[sws_ref_025; sws_ref_027; sws_ref_042]),...
    std([sws_ref_025; sws_ref_027; sws_ref_042])/sqrt(3), 'color',s,'linewidth',1); hold on
xlim([.5 12.5])
xlabel('Time (h)');
ylabel('p(SWS) ref')
ylim([0 1])


subplot(3,1,2)
errorbar(1:12,mean(2*[sws_lfp_025; sws_lfp_027; sws_lfp_042]),...
    std([sws_lfp_025; sws_lfp_027; sws_lfp_042])/sqrt(3), 'color',s,'linewidth',1); hold on
xlim([.5 12.5])
xlabel('Time (h)');
ylabel('p(SWS) lfp')
ylim([0 1])

subplot(3,1,3)
errorbar(1:12,1.1*mean([sws_cong_025; sws_cong_027; sws_cong_042]*100),...
std([sws_cong_025; sws_cong_027; sws_cong_042]*100)/sqrt(3),'color',s);
xlim([.5 12.5])
xlabel('Time (h)');
ylabel('cong (%)')
ylim([0 100])


figure;
subplot(3,1,1)
errorbar(1:12,mean([rem_ref_025; rem_ref_027; rem_ref_042]),...
    std([rem_ref_025; rem_ref_027; rem_ref_042])/sqrt(3), 'color',r,'linewidth',1); hold on
xlim([.5 12.5])
xlabel('Time (h)');
ylabel('p(rem) ref')
ylim([0 .7])


subplot(3,1,2)
errorbar(1:12,mean([rem_lfp_025; rem_lfp_027; rem_lfp_042]),...
    std([rem_lfp_025; rem_lfp_027; rem_lfp_042])/sqrt(3), 'color',r,'linewidth',1); hold on
xlim([.5 12.5])
xlabel('Time (h)');
ylabel('p(rem) lfp')
ylim([0 .7])

subplot(3,1,3)
errorbar(1:12,.9*mean([rem_cong_025; rem_cong_027; rem_cong_042]*100),...
std([rem_cong_025; rem_cong_027; rem_cong_042]*100)/sqrt(3),'color',r);
xlim([.5 12.5])
xlabel('Time (h)');
ylabel('cong (%)')
ylim([0 100])

%% corr between p_sws at L A and LFP and congruence
% sws
A=[sws_ref_025; sws_ref_027; sws_ref_042];
B=[sws_lfp_025; sws_lfp_027; sws_lfp_042];
C=[sws_cong_025; sws_cong_027; sws_cong_042];

corr_ref_cong_sws=0;
corr_lfp_cong_sws=0;
for bird=1:3
    corr_new=corrcoef(A(bird,:),C(bird,:));
    corr_ref_cong_sws(bird)=corr_new(1,2);
    corr_new=corrcoef(B(bird,:),C(bird,:));
    corr_lfp_cong_sws(bird)=corr_new(1,2);
end
mean(corr_ref_cong_sws)
std(corr_ref_cong_sws)
mean(corr_lfp_cong_sws)
std(corr_lfp_cong_sws)

% rem
A=[rem_ref_025; rem_ref_027; rem_ref_042];
B=[rem_lfp_025; rem_lfp_027; rem_lfp_042];
C=[rem_cong_025; rem_cong_027; rem_cong_042];

corr_ref_cong_rem=0;
corr_lfp_cong_rem=0;
for bird=1:3
    corr_new=corrcoef(A(bird,:),C(bird,:));
    corr_ref_cong_rem(bird)=corr_new(1,2);
    corr_new=corrcoef(B(bird,:),C(bird,:));
    corr_lfp_cong_rem(bird)=corr_new(1,2);
end
mean(corr_ref_cong_rem)
std(corr_ref_cong_rem)
mean(corr_lfp_cong_rem)
std(corr_lfp_cong_rem)



