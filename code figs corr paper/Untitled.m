%% depth of sleep for all channels
t_plot=[0 5]*3600; %%%%%%%%%%% t_lim for plot in seconds
ind=find(t_bins3sec<t_plot(2) & t_bins3sec>t_plot(1));

LH_t_plot=NaN(4,length(ind)); % low/high freq ratio, first filled with NaN, and then in the indeces that are in the t_plot and valid ...
% (artefact-free) we put the corresponding value of the LH
ind_valid_t_plot=intersect(valid_inds,ind); % indeces that are in the t_plot and valid (artefact-free)
for ch=[2 7 11 16]
for k=ind_valid_t_plot % only for the tplot time compute the LH
    % settings for multitaper
    nwin=size(EEG3sec,1);  nfft=2^(nextpow2(nwin));  TW=1.25;
    [pxx,f]=pmtm(EEG3sec(:,ch,k),TW,nfft,round(fs));
    px_low=norm(pxx(f<8 & f>1.5));
    px_high=norm(pxx(f<49 & f>30));
    LH_t_plot(ch,k-(ind(1)-1))=px_low/px_high; 
end
end
% figure for the sleep depth across channels
t_plot=[0 5]*3600; %%%%%%%%%%% t_lim for plot in seconds
ind=find(t_bins3sec<t_plot(2) & t_bins3sec>t_plot(1));

figure
title(fname);
dist=1; % spacing between the channels on the EEG plot 
win=20; % win length for smoothing
for ch=[1:4]
HL_ch=mov_avg_nan(LH_t_plot(ch,:),win);
HL_toplot=NaN(size(HL_ch));
HL_toplot(~isnan(HL_ch))=(HL_ch(~isnan(HL_ch))-mean(HL_ch(~isnan(HL_ch))))/std(HL_ch(~isnan(HL_ch)));
plot((t_bins3sec(ind))/3600,HL_toplot+dist*ch,'linewidth',1,'color',[0*(1-ch/16) 1*(1-ch/16) 1*(ch/16) .8]); % 
hold on
end

xlim(t_plot/3600); ylim([-3 24]);
area([t_plot(1) light_off_t]/3600,[5000 5000],'facecolor',[1 1 0],'FaceAlpha',.2,...
    'edgecolor',[1 .8 0]);
ylabel('normalized \bf	(\delta+\theta) / \gamma'); 
xlabel('Time (h)');
print(['depth 4 channel adult' fname],'-painters','-depsc');
