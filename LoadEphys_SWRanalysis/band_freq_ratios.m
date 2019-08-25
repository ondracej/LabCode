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
t0=4300+1770;  plot_time=[0 60]; %%%%%%%%%%%
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