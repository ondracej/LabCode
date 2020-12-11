%% correlation over time (calculation) just between 2 chnls
clear ll_corr lr_corr rr_corr
ll_corr=zeros(1,ceil(t_lim_plot(end)*60));
rr_corr=zeros(1,ceil(t_lim_plot(end)*60));
lr_corr=zeros(1,ceil(t_lim_plot(end)*60));

t_corr=t_lim_plot(1)+1:1:t_lim_plot(end)-1;
tic
for k=t_corr
    
    indx=time*60>k-1 & time*60<=k+1;
    if sum(indx)>1
        ll_corr(k)=(sum(corr(zscore(EEG(indx,1:8)),'type','spearman'),'all')-8)/56;
        lr_corr(k)=sum(corr(zscore(EEG(indx,1:8)),EEG(indx,9:16),'type','spearman'),'all')/64;
        rr_corr(k)=(sum(corr(zscore(EEG(indx,9:16)),'type','spearman'),'all')-8)/56;
    end
    if (rem(k,50)==0) k  % displaying time
        toc
        tic
    end
end
subplot(3,1,3)
plot([zeros(1,t_corr(1)-1) t_corr]/60,ll_corr,'color',[0 .8 1]); hold on
plot([zeros(1,t_corr(1)-1) t_corr]/60,rr_corr,'color',[0 .6 .7]);
plot([zeros(1,t_corr(1)-1) t_corr]/60,lr_corr,'color',[0 .4 .4]);
xlim(t_lim_plot); % time constraints, in minute
