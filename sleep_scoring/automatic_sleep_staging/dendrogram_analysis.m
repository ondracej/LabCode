% rebinning the data to 10-sec windows
% putting each concequitive 6 bins together to make a 6-sec window, with
% 1.5 sec shift
pxx=zeros(199,size(EEG,3)-5);
chnl=1; % selected chnl
fs=30000/64;
for k=1:size(EEG,3)-5
    eeg_epoch=reshape(EEG(:,chnl,k:k+5),[1,6*size(EEG,1)]);
    nwin=round(size(eeg_epoch,2)/4);  nfft=2^(nextpow2(nwin));  TW=2;  % settings for multitaper
    [pxx,f]=pmtm(eeg_epoch,TW,nfft,round(fs));
    px(:,k)=pxx(f<48 & f>2.5);
end
f=f(f<48 & f>1);
feats_all=(px./repmat(mean(px,2),[1,size(px,2)]))'; % features before removal of ...
% artifact-affected samples
%% generating the cluster and plotting
% excluding artefacts with setting a threshold-crossing criteria
eeg=reshape(EEG(:,chnl,:),[1,size(EEG,1)*size(EEG,3)]);
thresh=4*iqr(eeg); 
maxes_=max(EEG(:,chnl,:),[],1); 
maxes=reshape(maxes_,[1,length(maxes_)]);
valid_inds=maxes(1:end-5)<thresh;
feats_valid=feats(valid_inds);
auto_label_valid=auto_label(valid_inds);
k=3000;  %%%%%%%%%
inds=k:k+6000-1; %%%%%%%%%%
dists = pdist(feats(inds,:)); % calculate the distance between the data points. ...
% Data ponts are the spectral features. Default measure of distance is the
% Euclidean distance

% first create the dendrogram with a large number of leaves to extract the 
% general structure of data. Then based on the few general branches that devide 
% the data into major clusters, area another dendrogram and extract the labels
% Then reorder the data based on the branches, first the ones
% with label 1, the the ones with label 2, ... . Then area the corr matrix
% of the reordered data and add the dendrogram with more (e.x. 500) leaves
linkages = linkage(dists,'ward');
figure
[H,sample_labels,class_labels] = dendrogram(linkages,500,...
'Orientation','left','ColorThreshold',.7*max(linkages(:,3))); 
xticks([]); yticks([]);
figure
[H,sample_labels,class_labels] = dendrogram(linkages,2,...
'Orientation','left','ColorThreshold',.7*max(linkages(:,3))); 

% reordering data based on their class label
ind1=sample_labels==1;
ind2=sample_labels==2;
ind3=sample_labels==3;
ind4=sample_labels==4;
ind5=sample_labels==5;
X=feats(inds,:);
X_reordered=[X(ind1,:); X(ind2,:); X(ind3,:); X(ind4,:); X(ind5,:)];
conn_mat=corrcoef(X_reordered');
figure
ax1 = axes('Position',[0.15 0.04 0.82 .82]);
imagesc(ax1,conn_mat,[-.5 .5]);  title(ax1,'Correlation'); colorbar
% distribution area of stages along the reordered corr matrix
k=1; % current k, bin number, for the distributions
labels=auto_label_valid([find(ind1); find(ind2); find(ind3); find(ind4); find(ind5)]);
den_stage=NaN(length(inds)/5,4); 
while k*5<length(X_reordered)
    % order of stages is: Wake, IS, SWS, REM
    den_stage(k,1)=sum(strcmp(labels((k-1)*5+1:k*5),'Wake'))/20;
    den_stage(k,2)=sum(strcmp(labels((k-1)*5+1:k*5),'IS'))/20;
    den_stage(k,3)=sum(strcmp(labels((k-1)*5+1:k*5),'SWS'))/20;
    den_stage(k,4)=sum(strcmp(labels((k-1)*5+1:k*5),'REM'))/20;
    k=k+1;
end
ax2 = axes('Position',[0.04 0.04 .1 .82]);
bins=fliplr(2.5:5:length(inds)-2.5);
area(ax2,bins,den_stage(:,1),'FaceColor',[1 .7 0],'FaceAlpha', 0.4,'EdgeColor','none'); hold on
area(ax2,bins,den_stage(:,2),'FaceColor',[0 1 1],'FaceAlpha', 0.5,'EdgeColor','none')
area(ax2,bins,den_stage(:,3),'FaceColor',[0 0 1],'FaceAlpha', 0.2,'EdgeColor','none')
area(ax2,bins,den_stage(:,4),'FaceColor',[1 0 0],'FaceAlpha', 0.5,'EdgeColor','none');
view(ax2,[-90 90])
yticklabels={};

