% feature extraction, dimentionalitz reduction and figures
clear bins feat_smpl feats
bins=5; % bin size in seconds
EEG_=EEGfilt;
feat_smpl=floor(length(EEG_)/ (bins*fs)); % number of bins of data along time
feat_num=5; % number of frequency bands
c=size(EEG_,2); % number of EEG channels
feats=zeros(feat_smpl,c*feat_num+1);
% calculating rtelative powers
for n=1:feat_smpl
    x=EEG_((n-1)*bins*fs+1 : n*bins*fs,:); % one bin of all channels (3 sec)
    bandp= bandpower(x,fs,[.5 100]); % power over all frequency ranges for normalizing
    feats(n, 1    :c  ) = bandpower(x,fs,[.5 4])./bandp; % delta
    feats(n, c+1  :2*c) = bandpower(x,fs,[4 8])./bandp; % theta
    feats(n, 2*c+1:3*c) = bandpower(x,fs,[8 12])./bandp; % alpha
    feats(n, 3*c+1:4*c) = bandpower(x,fs,[12 30])./bandp; % beta
    feats(n, 4*c+1:5*c) = bandpower(x,fs,[30 100])./bandp; % gamma
end
% EMG power as a nother feature
for n=1:feat_smpl
    x=EMGfilt((n-1)*bins*fs+1 : n*bins*fs,1);
    feats(n,c*feat_num+1)= bandpower(x,fs,[10 300]); % power over 10-300Hz frequency ranges for EMG
end
% z score
featsn=zscore(feats);
%% figures
figure; % figure for all features
tt=bins/2:bins:feat_smpl*bins-bins/2; % time stamp for bins
for band=1:5
    subplot(5,1,band)
    imagesc(tt/3600,1:c,featsn(:,(band-1)*c+1:band*c)');
    colormap(jet); axis tight; colorbar
    switch band
        case 1
            ylabel('Delta')
        case 2
            ylabel('Theta')
        case 3
            ylabel('Alpha')
        case 4
            ylabel('Beta')
        case 5
            ylabel('Gamma')
    end
end
xlabel('Time (h)')

%% band power of bins with overlap
% this is basically the same as previous feature extraction. The only
% difference is that now we consider an overlap between concequent bins, in
% the sense that for a new bin we go 1 sec ahead, not the whole size of a
% bin
bins=10; % bin size in seconds
feat_smpl=floor(length(EEGfilt)/ fs)-bins+1; % number of bins of data along time
feat_num=5; % number of frequency bands
c=size(EEGfilt,2); % number of EEG channels
feats_=zeros(feat_smpl,c*feat_num);
% calculating rtelative powers
for n=1:feat_smpl
    x=EEGfilt((n-1)*fs+1 : (n+bins-1)*fs,:); % one bin of all cha nnels (3 sec)
    bandp= bandpower(x,fs,[.5 100]); % power over all frequency ranges for normalizing
    feats_(n, 1    :c  ) = bandpower(x,fs,[.5 4])./bandp; % delta
    feats_(n, c+1  :2*c) = bandpower(x,fs,[4 8])./bandp; % theta
    feats_(n, 2*c+1:3*c) = bandpower(x,fs,[8 12])./bandp; % alpha
    feats_(n, 3*c+1:4*c) = bandpower(x,fs,[12 30])./bandp; % beta
    feats_(n, 4*c+1:5*c) = bandpower(x,fs,[30 100])./bandp; % gamma
end
t_fit=bins/2 : 1 : bins/2 +feat_smpl-1; % time stamp for the overlapped features
%% computing ratios
bandname={'\delta', '\theta', '\alpha', '\beta', '\gamma'};
t0=14400;  plot_time=[0 .3*3600]; %%%%%%%%%%%
figure
chnls=5; %%%%%%%%%%%%
mm=1;
for kk=3:4 % from alpha to beta
    for jj=kk+1:5
        subplot(3,1,mm); 
        bands_=feats_(:,(kk-1)*chnls+1:kk*chnls)'./feats_(:,(jj-1)*chnls+1:jj*chnls)';
        bands=filloutliers(bands_,'nearest',2); % outliers are removed
        imagesc( (t_fit-t0)/60,1:chnls,zscore(bands')');
        colormap(jet); axis tight; 
        ylabel([bandname(kk) '/' bandname(jj)],'fontsize',12);  yticklabels({})
        xlim((plot_time)/60) %%%%%%%%%%%%%
        if mm==1
            title(['File: ' file '  ,  Time reference: ' num2str(t0) ' sec']);
        end
        mm=mm+1;
    end
end
xlabel('Time (min)')

% line plot of average changes over all channels
figure
mm=1;
for kk=3:4
    for jj=kk+1:5
        subplot(3,1,mm);
        bands_=feats_(:,(kk-1)*chnls+1:kk*chnls)'./feats_(:,(jj-1)*chnls+1:jj*chnls)';
        bands=filloutliers(bands_,'nearest',3); % outliers are removed
        plot(  (t_fit-t0)/60,mean(zscore(bands')'));
        axis tight;
        ylabel([bandname(kk) '/' bandname(jj)],'fontsize',12); xlim((plot_time)/60) ; yticklabels({})
        if mm==1
            title(['File: ' file '  ,  Time reference: ' num2str(t0) ' sec']);
        end
        mm=mm+1;
    end
end
xlabel('Time (min)')
%%
% correlation between bands
figure;
imagesc(corr(feats)); colormap(jet); axis square; colorbar
yticks([5,12,20,28,36]); yticklabels({'Delta','Tetha','Alpha','Beta','Gamma'})
xticks([5,12,20,28,36]); xticklabels({'Delta','Tetha','Alpha','Beta','Gamma'})

% PCA, and scatter plots
[eeg_dir,feats_pc,eeg_var] = pca(feats);
pix = get(0,'screensize'); pix(3)=pix(4);
figure('Position', pix);
numplot=10;
for row=1:numplot
    for column=1:numplot
        subplot(numplot,numplot,(row-1)*numplot+column)
        scatter(feats_pc(1500:11400,row),feats_pc(1500:11400,column),1,'.b');  hold on;  %% sleep
        scatter(feats_pc(11400:end,row),feats_pc(11400:end,column),1,'.r');              %% post sleep wake
        scatter(feats_pc(1:1500,row),feats_pc(1:1500,column),1,'.g');                    %% pre-sleep wake
        axis tight; axis square;
        if column==1
            ylabel(['PC ' num2str(row)]); end
        if row==1
            title(['PC ' num2str(column)],'fontweight','normal'); end
        xticklabels({});  yticklabels({});
    end
end
dim = [.12 .06 .5 .03];
str = 'Green:pre-sleep wake    Blue:sleep    Red: post-sleep';
aa=annotation('textbox',dim,'String',str); aa.FontWeight='bold'; aa.LineStyle='none';

figure; % figure for all features
numpc=16;
tt=1.5:3:feat_smpl*3; % time stamp for 3-sec bins
s1=surf(tt/3600,1:numpc,feats_pc(:,1:numpc)');
s1.EdgeColor = 'none';  view(0,90) ; colormap(hot);
xlabel('Time (h)');  ylabel('Features');   axis tight;