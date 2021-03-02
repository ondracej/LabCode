k=1;  %%%%%%%%%
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
[H,sample_labels,class_labels] = dendrogram(linkages,5,...
'Orientation','left','ColorThreshold',.7*max(linkages(:,3))); 

% reordering data based on their class label
ind1=sample_labels==1;
ind2=sample_labels==2;
ind3=sample_labels==3;
ind4=sample_labels==4;
ind5=sample_labels==5;
X=feats(inds,:);
X_reordered=[X(ind1,:); X(ind2,:); X(ind3,:); X(ind4,:); X(ind5,:)];
conn_mat=corr(X_reordered','type','spearman');
figure
ax1 = axes('Position',[0.15 0.04 0.82 .82]);
imagesc(ax1,conn_mat,[0 1]);  title(ax1,'Correlation'); 
% distribution area of stages along the reordered corr matrix
k=1; % current k for the distributions
labels=auto_label([find(ind1); find(ind2); find(ind3); find(ind4); find(ind5)]);
den_stage=NaN(length(inds)/20,4);
while k*20<length(X_reordered)
    % order of stages is: Wake, IS, SWS, REM
    den_stage(k,1)=sum(strcmp(labels((k-1)*20+1:k*20),'Wake'))/20;
    den_stage(k,2)=sum(strcmp(labels((k-1)*20+1:k*20),'IS'))/20;
    den_stage(k,3)=sum(strcmp(labels((k-1)*20+1:k*20),'SWS'))/20;
    den_stage(k,4)=sum(strcmp(labels((k-1)*20+1:k*20),'REM'))/20;
    k=k+1;
end
ax2 = axes('Position',[0.04 0.04 .1 .82]);
bins=fliplr(10:20:length(inds));
area(ax2,bins,den_stage(:,1),'FaceColor',[1 .7 0],'FaceAlpha', 0.4,'EdgeColor','none'); hold on
area(ax2,bins,den_stage(:,2),'FaceColor',[0 1 1],'FaceAlpha', 0.5,'EdgeColor','none')
area(ax2,bins,den_stage(:,3),'FaceColor',[0 0 1],'FaceAlpha', 0.2,'EdgeColor','none')
area(ax2,bins,den_stage(:,4),'FaceColor',[1 0 0],'FaceAlpha', 0.5,'EdgeColor','none');
view(ax2,[-90 90])
yticklabels={};

