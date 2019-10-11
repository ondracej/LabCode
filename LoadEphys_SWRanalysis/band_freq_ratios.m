%% band power of bins with overlap
% this code shall be executed after 'spw_analysis_script'

% we consider an overlap between concequent bins, in
% the sense that for a new bin (e.g. 5 s) we go 1 sec ahead, not the whole size of a
% bin
bins=5; % bin size in seconds
feat_smpl=floor(length(eeg)/ (fs))-(bins-1); % number of bins of data along time
feat_num=5; % number of frequency bands
c=size(eeg,2); % number of EEG channels
feats=zeros(feat_smpl,c*feat_num);
% calculating relative powers
for n=1:feat_smpl
    x=eeg((n-1)*fs+1 : (n+bins-1)*fs,:); % one bin of all channels 
    bandp= bandpower(x,fs,[.5 100]); % power over all frequency ranges for normalizing
    feats(n, 1    :c  ) = bandpower(x,fs,[.5 4])./bandp; % delta
    feats(n, c+1  :2*c) = bandpower(x,fs,[4 8])./bandp; % theta
    feats(n, 2*c+1:3*c) = bandpower(x,fs,[8 12])./bandp; % alpha
    feats(n, 3*c+1:4*c) = bandpower(x,fs,[12 30])./bandp; % beta
    feats(n, 4*c+1:5*c) = bandpower(x,fs,[30 100])./bandp; % gamma
end
t_fit=bins/2 : 1 : bins/2 +(feat_smpl-1); % time stamp for the features

%% plot of diffewrent band powers over time + SPW rate
bandname={'\delta', '\theta', '\alpha', '\beta', '\gamma'};
t0=17110;  plot_time=[0 1800]; %%%%%%%%%%%
tlim=t0+plot_time; % time domain in second
t_lim=tlim(1)*fs:tlim(2)*fs; % time domain in indices
tt=time(t_lim); % time stamps for the peeriod of interest

figure
% first subplot: EEG with SPWs annotated
subplot(feat_num+4,1,1) % for bands + 2 band ratios + EEG_SPW + SPW rate
plot(tt-t0,eeg(t_lim,mx_var_chnl));  ylabel({'EEG +';'SPWs';'(\muV)'}); 
hold on;   plot(time(spw_indx)-t0,-690,'.r', 'markersize',10);   xlim(plot_time);   ylim([-700 500])
title(['File: ' file '  ,  Time reference: ' num2str(t0/60) ' min']);    xticks([])

% second subplot: SPW rate over time
subplot(feat_num+2+1+1,1,2) 
plot(t_spw, spw_rate);  xlim(tlim); ylabel({'SPW rate'; '(Hz)'});    xticks([])

% next subtitles: band powers
for k=1:feat_num
    subplot(feat_num+4,1,k+2) 
    plot((t_fit-t0)/60,feats(:,mx_var_chnl+(k-1)*c));
    xlim(plot_time/60);
    ylabel( bandname{k} ,'fontsize',12);  yticklabels({})
    xticks([])
end

% last subtitles: 2 band ratios: (delta/beta) and (theta/beta)
subplot(feat_num+4,1,feat_num+3) 
plot((t_fit-t0)/60, feats(:,mx_var_chnl+(1-1)*c)./feats(:,mx_var_chnl+(4-1)*c)   );
xlim(plot_time/60);      xticks([])
ylabel([  bandname{1} '/' bandname{4} ],'fontsize',12);  yticklabels({})

subplot(feat_num+4,1,feat_num+4) 
plot((t_fit-t0)/60, feats(:,mx_var_chnl+(2-1)*c)./feats(:,mx_var_chnl+(4-1)*c)   );
xlim(plot_time/60);
ylabel([  bandname{2} '/' bandname{4} ],'fontsize',12);  yticklabels({})
 
%% computing ratios
bandname={'\delta', '\theta', '\alpha', '\beta', '\gamma'};
t0=17110;  plot_time=[0 3600]; %%%%%%%%%%%
figure
chnls=c; 
mm=1;
for kk=1:feat_num-1 % from delta to beta
    for jj=kk+1:feat_num
        subplot(12,1,mm+2); 
        bands_=feats(:,(kk-1)*chnls+1:kk*chnls)'.\feats(:,(jj-1)*chnls+1:jj*chnls)';
        bands=filloutliers(bands_,'nearest'); % outliers are removed
        imagesc( (t_fit-t0)/60,1:chnls,zscore(bands')',[-2.5 2.5]);
        colormap(jet); axis tight; 
        ylabel([bandname(jj) '/' bandname(kk)],'fontsize',12);  yticklabels({})
        xlim((plot_time)/60) %%%%%%%%%%%%%
        if mm==1
            title(['File: ' file '  ,  Time reference: ' num2str(t0/60) ' min']);
        end
        mm=mm+1;
    end
end
xlabel('Time (m)')
%%
% line plot of average changes over all channels
figure
mm=1;
for kk=1:feat_num-1
    for jj=kk+1:feat_num
        subplot(10,1,mm);
        bands_=feats(:,(kk-1)*chnls+1:kk*chnls)'./feats(:,(jj-1)*chnls+1:jj*chnls)';
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