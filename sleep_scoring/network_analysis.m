% plots of network for different stages
edge_thresh=.75; %%%%%%%%%%%%
image_layout='Z:\zoologie\HamedData\P1\73-03\73-03 layout.jpg'; %%%%%%%%%%%%%%
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
    imagesc(corr_mat,[0 0.75]); colorbar; axis square,  title(stage{j});
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
inds=randsample(length(labels),1000);  % picking a subset of epochs for the plot
eeg_pow=reshape(mean(sqrt(mean(eeg(:,:,inds).^2,1)),2),[1 1000]);  % EEG average power

eeg_corr=zeros(1,1000);
for k=1:1000
    eeg_corr(k)=mean(corr(eeg(:,:,inds(k)),'type','spearman'),'all');
end
labels=labels(inds);

figure
cols=[0 0 1; 1 .8 0; 0 1 1; 1 0 0;]; %%%%%
gscatter(eeg_pow,eeg_corr,labels,cols,'.',[5]); 
xlabel('EEG energy (mV)');  ylabel('mean correlation');

