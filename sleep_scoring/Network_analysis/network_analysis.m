% plots of network for different stages

bird='w0021'; %%%%%%%%%%%
image_layout='Z:\HamedData\P1\w0021 juv\w0021 layout.jpg'; %%%%%%%%%%%%%%
save_add='G:\Hamed\zf\P1\connectivity_vars';
fs=30000/64;
edge_probab=.95; 
% position of recording sites on the photo:
figure
im=imread(image_layout); 
im=.6*double(rgb2gray(imresize(im,.3)));
imshow(int8(im)); hold on
[x,y]=ginput(16);
xy(:,1)=x; xy(:,2)=y;
plot(x,y,'*');
%% preparing the artefact-free samples and extracting the network
indx_=find(strcmp(auto_label,'Wake')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); 
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,randsample(length(valid_inds),min(400,length(valid_inds))));
[~, corr_mat_Wake] = extract_network(EEG_stage, edge_probab, image_layout, xy, 'Wake'); % for Wake
saveas(gcf,[save_add '\' bird '_head_network_Wake.fig']);
indx_=find(strcmp(auto_label,'IS')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); 
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,randsample(length(valid_inds),min(400,length(valid_inds))));
[~, corr_mat_IS] = extract_network(EEG_stage, edge_probab, image_layout, xy, 'IS'); % for Wake
saveas(gcf,[save_add '\' bird '_head_network_IS.fig']);

indx_=find(strcmp(auto_label,'SWS')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); 
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,randsample(length(valid_inds),min(400,length(valid_inds))));
[~, corr_mat_SWS] = extract_network(EEG_stage, edge_probab, image_layout, xy, 'SWS'); % for Wake
saveas(gcf,[save_add '\' bird '_head_network_SWS.fig']);

indx_=find(strcmp(auto_label,'REM')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); 
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,randsample(length(valid_inds),min(400,length(valid_inds))));
[~, corr_mat_REM] = extract_network(EEG_stage, edge_probab, image_layout, xy, 'REM'); % for Wake
saveas(gcf,[save_add '\' bird '_head_network_REM.fig']);

%% plot of networks for all stages
edge_probab=.95; %%%%%%%%%%%%

figure
stage={'Wake','IS','SWS','REM'};
for j=1:4
    if     j==1
        corr_mat=corr_mat_Wake;
    elseif j==2
        corr_mat=corr_mat_IS;
    elseif j==3
        corr_mat=corr_mat_SWS;
    elseif j==4
        corr_mat=corr_mat_REM;
    end
    subplot(2,4,j)
    imagesc(corr_mat,[0 1]); colorbar; axis square,  title(stage{j});
    xticks([4.5 12.5]); xticklabels({'L' , 'R'}); 
    
    subplot(2,4,4+j)
    s1=corr_mat>edge_probab; % depict higher correlations
    imshow(int8(im)); hold on
    s=s1-diag(diag(s1)); % removing self loops
    Gcorr = graph(s,'lower','omitselfloops');
    [ MC ] = maximalCliques( s ); % extract fully-connected subgrapohs (brain modules)
    modules=MC(:,sum(MC)>=2);
    for k =1:size(modules,2)
        sub=subgraph(Gcorr,logical(modules(:,k)));
        h=plot(sub,'EdgeAlpha',.6,'markersize',2);
        xy_=xy+.01*median(xy,'all')*randn(size(xy));
        XData=xy_(logical(modules(:,k)),1);  YData=xy_(logical(modules(:,k)),2);
        h.XData=XData;  h.YData=YData;
        h.NodeLabel = {};
        h.LineWidth = 1.5;
    end
end
saveas(gcf,[save_add '\' bird '_head_network_all.fig']);
%% coefficients of correction for the missed channels
RR=28/21;
LL=28/21;
RL=64/49;

%% connectivity measures
t=[0 12];
indx_=find(t_bins<t(2)*3600 & t_bins>t(1)*3600); %%%%%%%%%%%% time window
EEG_piece=EEG(:,:,indx_);
corr_mat_=NaN(size(EEG_piece,2),size(EEG_piece,2),size(EEG_piece,3));
conn_mat_=NaN(size(EEG_piece,2),size(EEG_piece,2),size(EEG_piece,3));
net_density=NaN(1,length(indx_));
mean_conn=NaN(1,length(indx_));
mean_connRR=NaN(1,length(indx_));
mean_connLL=NaN(1,length(indx_));
mean_connRL=NaN(1,length(indx_));

for k=1:size(EEG_piece,3)
    if max(EEG_piece(:,:,k),[],'all')<3.5
        [conn_mat_(:,:,k),~,~,~] = infer_network_correlation_analytic(EEG_piece(:,:,k));
        net_density(k)=sum(tril(conn_mat_(:,:,k),-1),'all')/...
            (size(corr_mat_,1)-1)*(size(corr_mat_,1)-2)/2; % depict higher correlations
        corr_mat_(:,:,k)=corr(EEG_piece(:,:,k),'type','spearman');
        mean_conn(k)=mean(tril(corr_mat_(:,:,k),-1),'all');
        mean_connRR(k)=mean(tril(corr_mat_(9:16,9:16,k),-1),'all')*RR;
        mean_connLL(k)=mean(tril(corr_mat_(1:8,1:8,k),-1),'all')*LL;
        mean_connRL(k)=mean(corr_mat_(9:16,1:8,k),'all')*RL;

    end
end

% plots  of network measures
figure
subplot(3,1,1)
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
xlim([0 60])
% yticks(.5:3.5); yticklabels({'SWS','IS','REM','Wake'}); axis tight
subplot(3,1,2)
plot(t_bins(indx_)/60,net_density,'color',[.5 .5 1]); hold on; axis tight
ylabel({'Network';'density'});  xlim([0 60])

subplot(3,1,3)
plot(t_bins(indx_)/60,mean_conn,'color',[.4 .8 .2]); 
xlabel('Time (min)')
ylabel({'mean';'connectivity'}); xlim([0 60])
saveas(gcf,[save_add '\' bird '_descent_into_sleep.fig']);

%% cluster's connectivity time series computation
thresh_eeg=4*iqr(EEG,'all');
t=5.3+[0/60 40/60];
indx_=find(t_bins<t(2)*3600 & t_bins>t(1)*3600 & ...
    reshape(max( max(EEG ,[],1) ,[],2)<thresh_eeg,1,length(t_bins))); %%%%%%%%%%%% time window
EEG_piece=EEG(:,:,indx_);
corr_mat_=NaN(size(EEG_piece,2),size(EEG_piece,2),size(EEG_piece,3));
corr_clus_1=NaN(1,length(indx_));
corr_clus_2=NaN(1,length(indx_));
corr_clus_3=NaN(1,length(indx_));
corr_clus_4=NaN(1,length(indx_));

for k=1:size(EEG_piece,3)
        corr_mat_(:,:,k)=corr(EEG_piece(:,:,k),'type','spearman');
        corr_clus_1(k)=(sum(corr_mat_([3 4 5 6],[3 4 5 6],k),'all')-4)/(2*6); %%%%%%%%%%%%%
        corr_clus_2(k)=(sum(corr_mat_([9 10 11],[9 10 11],k),'all')-3)/(2*3); %%%%%%%%%%%
        corr_clus_3(k)=(sum(corr_mat_([12:15],[12:15],k),'all')-4)/(2*6); %%%%%%%%%%%
        corr_clus_4(k)=(sum(corr_mat_([2:5],[2:5],k),'all')-4)/(2*6); %%%%%%%%%%%
end

%% cluster's connectivity time series plot
figure
subplot(6,1,1)
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
% yticks(.5:3.5); yticklabels({'SWS','IS','REM','Wake'}); 
axis tight
subplot(6,1,2)
plot(t_bins(indx_)/60,mean_conn,'color',[0 0 0]); axis tight
ylabel({'mean';'connectivity'}); 

subplot(6,1,3)
plot(t_bins(indx_)/60,corr_clus_1,'color',[.1 .4 1]); axis tight
ylabel({'cluster 1';'connectivity'}); ylim([.65 .94])

subplot(6,1,4)
plot(t_bins(indx_)/60,corr_clus_2,'color',[1 .9 0]); axis tight
ylabel({'cluster 2';'connectivity'}); ylim([.65 .9])

subplot(6,1,5)
plot(t_bins(indx_)/60,corr_clus_3,'color',[1 .5 0]);  axis tight
ylabel({'cluster 3';'connectivity'}); ylim([.8 .95])
xlabel('Time (min)') ;

subplot(6,1,6)
plot(t_bins(indx_)/60,corr_clus_4,'color',[1 .5 0]);  axis tight
ylabel({'cluster 4';'connectivity'}); ylim([.8 .95])
xlabel('Time (min)') ;

%% EEG at peak connectivity of different clusters
for r=1:5
[~,I] = sort(corr_clus_2-.5*mean_conn,'descend');
ind=indx_(I(r));
figure
bin_indx=ind; %randsample(size(EEG_,3)-1000,1)+500; % index to the first nREM bin
EEG_n=size(EEG,1);
for k=1:16
    plot(round(1:EEG_n)/fs,(EEG(:,k,bin_indx))+thresh_eeg*.5*k); hold on
end
% yticks(thresh_eeg*.5*(1:16)), yticklabels(compose('%01d', 1:16));
ylabel('Channel number')
xlabel('Time (sec)')
end

%% bar plot for the network measures
net_dense_Wake=0; net_dense_IS=0; net_dense_REM=0; net_dense_SWS=0;
count_den_Wake=1; count_den_IS=1; count_den_SWS=1; count_den_REM=1;
mean_conn_Wake=0; mean_conn_IS=0; mean_conn_REM=0; mean_conn_SWS=0;
count_conn_Wake=1; count_conn_IS=1; count_conn_SWS=1; count_conn_REM=1;

for k=1:length(indx_)
    if max(EEG_piece(:,:,k),[],'all')<3.5
        if strcmp(auto_label(indx_(k)),'Wake') && ~isnan(mean_conn(k)) && ~isnan(net_density(k))
            net_dense_Wake(count_den_Wake)=net_density(k); count_den_Wake=count_den_Wake+1;
            mean_conn_Wake(count_conn_Wake)=mean_conn(k); count_conn_Wake=count_conn_Wake+1;
            mean_connRL_Wake(count_conn_Wake)=mean_connRL(k);
            mean_connRR_Wake(count_conn_Wake)=mean_connRR(k);
            mean_connLL_Wake(count_conn_Wake)=mean_connLL(k);
        elseif strcmp(auto_label(indx_(k)),'REM') && ~isnan(mean_conn(k)) && ~isnan(net_density(k))
            net_dense_REM(count_den_REM)=net_density(k); count_den_REM=count_den_REM+1;
            mean_conn_REM(count_conn_REM)=mean_conn(k); count_conn_REM=count_conn_REM+1;
            mean_connRL_REM(count_conn_Wake)=mean_connRL(k);
            mean_connRR_REM(count_conn_Wake)=mean_connRR(k);
            mean_connLL_REM(count_conn_Wake)=mean_connLL(k);
        elseif strcmp(auto_label(indx_(k)),'IS') && ~isnan(mean_conn(k)) && ~isnan(net_density(k))
            net_dense_IS(count_den_IS)=net_density(k); count_den_IS=count_den_IS+1;
            mean_conn_IS(count_conn_IS)=mean_conn(k); count_conn_IS=count_conn_IS+1;
            mean_connRL_IS(count_conn_Wake)=mean_connRL(k);
            mean_connRR_IS(count_conn_Wake)=mean_connRR(k);
            mean_connLL_IS(count_conn_Wake)=mean_connLL(k);
        elseif strcmp(auto_label(indx_(k)),'SWS') && ~isnan(mean_conn(k)) && ~isnan(net_density(k))
            net_dense_SWS(count_den_SWS)=net_density(k); count_den_SWS=count_den_SWS+1;
            mean_conn_SWS(count_conn_SWS)=mean_conn(k); count_conn_SWS=count_conn_SWS+1;
            mean_connRL_SWS(count_conn_Wake)=mean_connRL(k);
            mean_connRR_SWS(count_conn_Wake)=mean_connRR(k);
            mean_connLL_SWS(count_conn_Wake)=mean_connLL(k);
        end
    end
end

figure
subplot(2,1,1)
conn_mean=[mean(mean_conn_Wake); mean(mean_conn_IS); ...
      mean(mean_conn_SWS); mean(mean_conn_REM);];
conn_conf=1.96*[std(mean_conn_Wake)/sqrt(count_conn_Wake);...
     std(mean_conn_IS)/sqrt(count_conn_IS); 
     std(mean_conn_SWS)/sqrt(count_conn_SWS);
     std(mean_conn_REM)/sqrt(count_conn_REM);];
% plot((conn_mean/mean(conn_mean))*100-100,'Facecolor',[.7 .4 .1]); hold on
errorbar(0:3,(conn_mean/mean(conn_mean))*100-100,(conn_conf/mean(conn_mean))*100,'color',[.7 .4 .1])
line([-1 4],[0 0],'linestyle','--');
xticks(0:3); xticklabels({'Wake','IS','SWS','REM'});
ylabel('Connectivity (%)')
xlim([-1 4])

subplot(2,1,2)
den_mean=[mean(net_dense_Wake); mean(net_dense_IS); ...
      mean(net_dense_SWS); mean(net_dense_REM);];
den_conf=1.96*[std(net_dense_Wake)/sqrt(count_den_Wake);...
     std(net_dense_IS)/sqrt(count_den_IS); 
     std(net_dense_SWS)/sqrt(count_den_SWS);
     std(net_dense_REM)/sqrt(count_den_REM);];
% bar((den_mean/mean(den_mean))*100-100,'FaceColor',[.4 .4 .8]); hold on
errorbar(0:3,(den_mean/mean(den_mean))*100-100,(den_conf/mean(den_mean))*100,'color',[.4 .4 .8])
line([-1 4],[0 0],'linestyle','--');
xticks(0:3); xticklabels({'Wake','IS','SWS','REM'}); xlim([-1 4]);
ylabel('Density (%)')
saveas(gcf,[save_add '\' bird '_network_measures.fig']);

%% testing the highest correlation epochs
fs=30000/64;
[~,I] = sort(mean_conn,'ascend');
highest_corr_ind=indx_(I(1:20));
for k=1:5
    figure
    for ch=1:size(EEG,2)
        plot((1:size(EEG,1))/fs,EEG(:,ch,highest_corr_ind(k))+.5*ch); hold on
    end
end
% %% variables to save
% % measures of connectivity
% save([save_add '\' bird '-vars'],...
% 'net_dense_Wake', 'net_dense_IS', 'net_dense_REM', 'net_dense_SWS',...
% 'mean_conn_Wake', 'mean_conn_IS', 'mean_conn_REM', 'mean_conn_SWS',...
% 'mean_connRR_Wake', 'mean_connRR_REM', 'mean_connRR_IS', 'mean_connRR_SWS',...
% 'mean_connRL_Wake', 'mean_connRL_REM', 'mean_connRL_IS', 'mean_connRL_SWS',...
% 'mean_connLL_Wake', 'mean_connLL_REM', 'mean_connLL_IS', 'mean_connLL_SWS');
