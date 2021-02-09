% plots of network for different stages
edge_thresh=.75; %%%%%%%%%%%%
image_layout='Z:\zoologie\HamedData\P1\w0009 juv\w0009-layout.jpg'; %%%%%%%%%%%%%%
% position of recording sites on the photo:
figure
im=imread(image_layout); %%%%%%%%% 'G:\Hamed\zf\P1\73 03\electrode_placement.jpg'
im=.6*double(rgb2gray(imresize(im,.3)));
imshow(int8(im)); hold on
[x,y]=ginput(16);
xy(:,1)=x; xy(:,2)=y;
plot(x,y,'*');
%% preparing the artefact-free samples and extracting the network
indx_=find(strcmp(auto_label,'Wake')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); % pick the ones with highest gamma
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,valid_inds);
[~, corr_mat_Wake] = extract_network(EEG_stage, edge_thresh, image_layout, xy); % for Wake

indx_=find(strcmp(auto_label,'IS')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); % pick the ones with highest gamma
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,valid_inds);
[~, corr_mat_IS] = extract_network(EEG_stage, edge_thresh, image_layout, xy); % for Wake

indx_=find(strcmp(auto_label,'SWS')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); % pick the ones with highest gamma
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,valid_inds);
[~, corr_mat_SWS] = extract_network(EEG_stage, edge_thresh, image_layout, xy); % for Wake

indx_=find(strcmp(auto_label,'REM')); % for Wake
vals=reshape( max( max(EEG(:,:,indx_) ,[],1) ,[],2),[1,length(indx_)]); % pick the ones with highest gamma
valid_inds=indx_(vals<3.5); % artifact-free ones are the ones with EEG < 3.5 std
EEG_stage=EEG(:,:,valid_inds);
[~, corr_mat_REM] = extract_network(EEG_stage, edge_thresh, image_layout, xy); % for Wake

%% plot of networks for all stages
edge_thresh=.75; %%%%%%%%%%%%

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
    imagesc(corr_mat,[0 edge_thresh]); colorbar; axis square,  title(stage{j});
    xticks([4.5 12.5]); xticklabels({'L' , 'R'});  yticks([4.5 12.5]); yticklabels({'L' , 'R'})
    
    subplot(2,4,4+j)
    s1=corr_mat>edge_thresh; % depict higher correlations
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


%% plot of signal power and total correlation
% picking the artefact-free ones
vals=reshape( max( max(EEG,[],1) ,[],2) ,[1,size(EEG,3)]); % pick the ones with highest gamma
eeg=EEG(:,:,vals<3.5);
labels=auto_label(vals<3);
inds=randsample(length(labels),2000);  % picking a subset of epochs for the plot
eeg_pow=reshape(mean(sqrt(mean(eeg(:,:,inds).^2,1)),2),[1 2000]);  % EEG average power

eeg_corr=zeros(1,2000);
for k=1:2000
    eeg_corr(k)=mean(corr(eeg(:,:,inds(k)),'type','spearman'),'all');
end
labels=labels(inds);

figure
cols=[1 .8 0;0 0 1; 1 0 0; 0 1 1;   ]; %%%%%
gscatter(eeg_pow,eeg_corr,labels,cols,'.',[5]);
xlabel('EEG energy (mV)');  ylabel('mean correlation');

%% nework features
t=[2.33 2.45001];
indx_=find(t_bins<t(2)*3600 & t_bins>t(1)*3600); %%%%%%%%%%%% time window
EEG_piece=EEG(:,:,indx_);
corr_mat_=NaN(size(EEG_piece,2),size(EEG_piece,2),size(EEG_piece,3));
net_density=NaN(1,length(indx_));
net_cliques=NaN(1,length(indx_));
mean_corr=NaN(1,length(indx_));
for k=1:size(EEG_piece,3)
    if max(EEG_piece(:,:,k),[],'all')<3.5
        corr_mat_(:,:,k)=corr(EEG_piece(:,:,k),'type','spearman');
        net_density(k)=sum(tril(corr_mat_(:,:,k)>edge_thresh,-1),'all')/(size(corr_mat_,1)*(size(corr_mat_,1)-1)/2); % depict higher correlations
        s1=corr_mat_(:,:,k)> edge_thresh; % depict higher correlations
        s=s1-diag(diag(s1)); % removing self loops
        net_cliques(k) = sum(sum(maximalCliques( s ))>1);
        mean_corr(k)=mean(tril(corr_mat_(:,:,k),-1),'all');
    end
end

% plots  of network measures
figure
subplot(5,1,1:2)
for k=indx_
    if strcmp(auto_label(k),'Wake')
        line([t_bins(k) t_bins(k)]/60,[3 4],'color',[1 .8 0]); hold on
    elseif strcmp(auto_label(k),'REM')
        line([t_bins(k) t_bins(k)]/60,[2 3],'color',[1 0 0]);
    elseif strcmp(auto_label(k),'IS')
        line([t_bins(k) t_bins(k)]/60,[1 2],'color',[0 1 1]);
    elseif strcmp(auto_label(k),'SWS')
        line([t_bins(k) t_bins(k)]/60,[0 1],'color',[0 0 1]);
    end
end
yticks(.5:3.5); yticklabels({'SWS','IS','REM','Wake'}); axis tight
subplot(5,1,3)
plot(t_bins(indx_)/60,net_density,'color',[.5 .5 1]); hold on; axis tight
ylabel({'Network';'density'}); ylim([.12 .23])
subplot(5,1,4)
plot(t_bins(indx_)/60,net_cliques,'color',[.8 .5 .2]); axis tight
xlabel('Time (h)')
ylabel({'Network';'cliquiness'}); ylim([7 12])
subplot(5,1,5)
plot(t_bins(indx_)/60,mean_corr,'color',[.4 .8 .2]); 
xlabel('Time (min)')
ylabel({'mean';'correlation'}); axis tight

%% bar plot for the network measures
net_dense_Wake=0; net_dense_IS=0; net_dense_REM=0; net_dense_SWS=0;
count_den_Wake=1; count_den_IS=1; count_den_SWS=1; count_den_REM=1;
net_cliques_Wake=0; net_cliques_IS=0; net_cliques_REM=0; net_cliques_SWS=0;
count_cliq_Wake=1; count_cliq_IS=1; count_cliq_SWS=1; count_cliq_REM=1;

for k=1:length(indx_)
    if max(EEG_piece(:,:,k),[],'all')<3.5
        if strcmp(auto_label(indx_(k)),'Wake')
            net_dense_Wake(count_den_Wake)=net_density(k); count_den_Wake=count_den_Wake+1;
            net_cliques_Wake(count_cliq_Wake)=net_cliques(k); count_cliq_Wake=count_cliq_Wake+1;
        elseif strcmp(auto_label(indx_(k)),'REM')
            net_dense_REM(count_den_REM)=net_density(k); count_den_REM=count_den_REM+1;
            net_cliques_REM(count_cliq_REM)=net_cliques(k); count_cliq_REM=count_cliq_REM+1;
        elseif strcmp(auto_label(indx_(k)),'IS')
            net_dense_IS(count_den_IS)=net_density(k); count_den_IS=count_den_IS+1;
            net_cliques_IS(count_cliq_IS)=net_cliques(k); count_cliq_IS=count_cliq_IS+1;
        elseif strcmp(auto_label(indx_(k)),'SWS')
            net_dense_SWS(count_den_SWS)=net_density(k); count_den_SWS=count_den_SWS+1;
            net_cliques_SWS(count_cliq_SWS)=net_cliques(k); count_cliq_SWS=count_cliq_SWS+1;
        end
    end
end

figure
cliq_mean=[mean(net_cliques_Wake); mean(net_cliques_IS); ...
      mean(net_cliques_SWS); mean(net_cliques_REM);];
cliq_conf=1.96*[std(net_cliques_Wake)/sqrt(count_cliq_Wake);...
     std(net_cliques_IS)/sqrt(count_cliq_IS); 
     std(net_cliques_SWS)/sqrt(count_cliq_SWS);
     std(net_cliques_REM)/sqrt(count_cliq_REM);];
bar((cliq_mean/mean(cliq_mean))*100-100,'Facecolor',[.7 .4 .1]); hold on
errorbar((cliq_mean/mean(cliq_mean))*100-100,(cliq_conf/mean(cliq_mean))*100,'.','color','k')
xticklabels({'Wake','IS','SWS','REM'});
ylabel('Cliquiness (%)')
figure
den_mean=[mean(net_dense_Wake); mean(net_dense_IS); ...
      mean(net_dense_SWS); mean(net_dense_REM);];
den_conf=1.96*[std(net_dense_Wake)/sqrt(count_den_Wake);...
     std(net_dense_IS)/sqrt(count_den_IS); 
     std(net_dense_SWS)/sqrt(count_den_SWS);
     std(net_dense_REM)/sqrt(count_den_REM);];
bar((den_mean/mean(den_mean))*100-100,'FaceColor',[.4 .4 .8]); hold on
errorbar((den_mean/mean(den_mean))*100-100,(den_conf/mean(den_mean))*100,'.','color','k')
xticklabels({'Wake','IS','SWS','REM'});
ylabel('Density (%)')
%% testing trhe highest correlation epochs
fs=30000/64;
[~,I] = sort(mean_corr,'ascend');
highest_corr_ind=indx_(I(1:20));
for k=1:5
    figure
    for ch=1:size(EEG,2)
        plot((1:size(EEG,1))/fs,EEG(:,ch,highest_corr_ind(k))+2*ch); hold on
    end
end

