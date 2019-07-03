% feature extraction, dimentionalitz reduction and figures
% we consider epochs of data as 3 sec
feat_smpl=floor(length(EEG)/ (3*fs)); % number of bins of data along time 
feat_num=6; % number of frequency bands
c=size(EEG,2); % number of EEG channels
feats=zeros(feat_smpl,c*feat_num);
% calculating rtelative powers
for n=1:feat_smpl
x=EEG((n-1)*3*fs+1 : n*3*fs,:); % one bin of all channels (3 sec)
bandp= bandpower(x,fs,[.5 100]); % power over all frequency ranges for normalizing
feats(n, 1    :c  ) = bandpower(x,fs,[.1 .5])./bandp; % low delta
feats(n, c+1  :2*c) = bandpower(x,fs,[.5 4])./bandp; % delta
feats(n, 2*c+1:3*c) = bandpower(x,fs,[4 8])./bandp; % theta
feats(n, 3*c+1:4*c) = bandpower(x,fs,[8 12])./bandp; % alpha
feats(n, 4*c+1:5*c) = bandpower(x,fs,[12 30])./bandp; % beta
feats(n, 5*c+1:6*c) = bandpower(x,fs,[30 100])./bandp; % gamma
end

feats=(feats-repmat(mean(feats),size(feats,1),1)); % removing the average
figure; % figure for all features
tt=1.5:3:feat_smpl*3; % time stamp for 3-sec bins
s1=surf(tt/3600,1:c*feat_num,feats');
s1.EdgeColor = 'none';  view(0,90) ; colormap('hot'); 
xlabel('Time (h)');  ylabel('Features');   axis tight;

% PCA
[eeg_dir,feats_pc,eeg_var] = pca(feats);
figure('Position', pixls); 
numplot=10;
for row=1:numplot
    for column=1:numplot
        subplot(numplot,numplot,(row-1)*numplot+column)
        scatter(feats_pc(:,row),feats_pc(:,column),1,'.');  hold on
        scatter(feats_pc(11400:end,row),feats_pc(11400:end,column),1,'.r'); 
        scatter(feats_pc(1:1500,row),feats_pc(1:1500,column),1,'.g');    axis tight;
        if column==1 
            ylabel(['PC ' num2str(row)]); end
        if row==1 
            title(['PC ' num2str(column)],'fontweight','normal'); end
    end
end



