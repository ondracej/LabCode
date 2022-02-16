%% nework features
edge_thresh=.75; %%%%%%%%%%%%
t=4+[0/60 20/60];
indx_=find(t_bins<t(2)*3600 & t_bins>t(1)*3600); %%%%%%%%%%%% time window
EEG_piece=EEG(:,:,indx_);
corr_mat_=NaN(size(EEG_piece,2),size(EEG_piece,2),size(EEG_piece,3));
net_density=NaN(1,length(indx_));
corr_clus_1=NaN(1,length(indx_));
corr_clus_2=NaN(1,length(indx_));
corr_clus_3=NaN(1,length(indx_));
mean_conn=NaN(1,length(indx_));
for k=1:size(EEG_piece,3)
    if max(EEG_piece(:,:,k),[],'all')<3.5
        corr_mat_(:,:,k)=corr(EEG_piece(:,:,k),'type','spearman');
        net_density(k)=sum(tril(corr_mat_(:,:,k)>edge_thresh,-1),'all')/(size(corr_mat_,1)*(size(corr_mat_,1)-1)/2); % depict higher correlations
        mean_conn(k)=mean(tril(corr_mat_(:,:,k),-1),'all');
        corr_clus_1(k)=(sum(corr_mat_(3:5,3:5,k),'all')-3)/(2*3);
        corr_clus_2(k)=(sum(corr_mat_([13 15 16],[13 15 16],k),'all')-3)/(2*3);
        corr_clus_3(k)=(sum(corr_mat_([13 14 16],[13 14 16],k),'all')-3)/(2*3);

    end
end

% plots  of network measures
figure
subplot(5,1,1)
for k=indx_
    if strcmp(auto_label(k),'Wake')
        line([t_bins(k) t_bins(k)]/60,[3 4],'color',[1 .8 0],'LineWidth',.1); hold on
    elseif strcmp(auto_label(k),'REM')
        line([t_bins(k) t_bins(k)]/60,[2 3],'color',[1 0 0],'LineWidth',.1);
    elseif strcmp(auto_label(k),'IS')
        line([t_bins(k) t_bins(k)]/60,[1 2],'color',[0 1 1],'LineWidth',.1);
    elseif strcmp(auto_label(k),'SWS')
        line([t_bins(k) t_bins(k)]/60,[0 1],'color',[0 0 1],'LineWidth',.1);
    end
end
yticks(.5:3.5); yticklabels({'SWS','IS','REM','Wake'}); axis tight
subplot(5,1,2)
plot(t_bins(indx_)/60,mean_conn,'color',[0 0 0]); axis tight
ylabel({'mean';'connectivity'}); 

subplot(5,1,3)
plot(t_bins(indx_)/60,corr_clus_1,'color',[.1 .4 1]); 
ylabel({'cluster 1';'connectivity'}); ylim([.8 .94])

subplot(5,1,4)
plot(t_bins(indx_)/60,corr_clus_2,'color',[1 .9 0]);
ylabel({'cluster 2';'connectivity'}); ylim([.75 .93])

subplot(5,1,5)
plot(t_bins(indx_)/60,corr_clus_3,'color',[1 .5 0]); 
ylabel({'cluster 3';'connectivity'}); ylim([.75 .90])
xlabel('Time (min)') ;

