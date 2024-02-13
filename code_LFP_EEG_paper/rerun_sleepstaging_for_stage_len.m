%% binning of data, feature extraction and clustering
lfp1_chnl=1; %%%%%%%%%%%%%%
r_a_eeg_chnl=2; %%%%%%%%%%%%%%
r_p_eeg_chnl=3; %%%%%%%%%%%%%%
l_a_eeg_chnl=4; %%%%%%%%%%%%%%
l_p_eeg_chnl=5; %%%%%%%%%%%%%%
ref_chnl=l_a_eeg_chnl; % always left anterior EEG chnl; 
t_dark=(2285/20 +data.time(1))+[0 12*3600]; %%%%%%%%%%%%% light switching times in hameddata2\EEG-LFP-song learning, frame num /20  +time(1)
downsamp_ratio=64; 
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',12,'HalfPowerFrequency1',1,'HalfPowerFrequency2',48, ...
    'SampleRate',fs);

% binning
% chnl_to_bin=l_p_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel
% chnl_to_bin=r_p_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel %
% chnl_to_bin=lfp1_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel
% chnl_to_bin=r_a_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel
chnl_to_bin=l_a_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel

chnl_filt=data.ephys(:,chnl_to_bin);
ref_filt=data.ephys(:,ref_chnl); 

[b,a] = butter(3,30/(fs/2),'high');
ref_over30=filtfilt(b,a,data.ephys(:,ref_chnl));
win_len=floor(3*fs);
for current_win=1: (length(chnl_filt)/win_len)
inds=(current_win-1)*win_len +(1:win_len);
    wave_binned(current_win,:)=chnl_filt(inds);
    ref_binned(current_win,:)=ref_filt(inds);
    t_bin(current_win)=data.time(inds(round(fs*1.5))); % the middle time point of a bin
    pow_30hz(current_win)=rms(ref_over30(inds))^2; % power of high freq in the ref chnl for sleep/wake deliniation
end

move_artef_thresh=median(pow_30hz)+1.5*iqr(pow_30hz);
% artefact windows:
inds_wake=pow_30hz>move_artef_thresh; 
% Sleep staging feature extraction
clear Delta_ref Gamma_ref feat_ref sleep_wake t_feat Delta Gamma feat bin_label_ref bin_label
% for the reference channel and the other channel
n_bins=length(wave_binned);

[Delta, Gamma, feat,  t_feat]=sleep_feature_extract(wave_binned, t_bin, n_bins, fs);
beep; pause(.7); beep;

%%  clustering
[bin_label, valid_bin_inds]=cluster_sleep(feat, t_feat, ~inds_wake, Delta, Gamma, t_dark ); %%%%%%%%% is_wake or ~is_wake

Delta_=Delta(valid_bin_inds);
Gamma_=Gamma(valid_bin_inds);
t_bin_label=t_feat(valid_bin_inds);

% visualization of bins in the feature space
% colors for each stage

% color for each stage, might need to be updated each time 
%%%%%%%%%%%%%%
r=.8*[1 .4 .4]; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
color_order=[r; i; w; s]; %%%%%%%%%%%%%%


% second plot for other chnl
figure
plot_inds=randsample(length(bin_label),2000);
x_vals=log10(Delta_(plot_inds))';
y_vals=log10(Gamma_(plot_inds))';
group_label=bin_label(plot_inds)';
scatterhist(x_vals,y_vals,'Group',group_label,'Kernel','on','Location','SouthEast',...
    'Direction','out','Color',color_order,'LineStyle',{'-','-.',':','--'},...
    'LineWidth',[2,2,2,2],'Marker','....','MarkerSize',.6*[10, 10, 10, 10]);
ylim(median(y_vals)+3*iqr(y_vals)*[-.9 1.5]); 
xlim(median(x_vals)+2.5*iqr(x_vals)*[-1 1.]);  
title('non-ref ref channel')
xlabel('log Delta'); ylabel('log Gamma')

%% scatter plot of bouts with true label
figure
plot_inds=randsample(length(bin_label),1000);
x_vals=log10(Delta_(plot_inds))';
y_vals=log10(Gamma_(plot_inds))';
group_label=bin_label(plot_inds)';
color_order=[r; s; i; w];

for bin=1:length(plot_inds)
    stage=strcmp(group_label{bin},{'REM','SWS','IS','Wake'});
    scatter(x_vals(bin),y_vals(bin),14,color_order(stage,:),'filled'); hold on
end
ylim(median(y_vals)+3*iqr(y_vals)*[-1 1.2]); 
xlim(median(x_vals)+2.5*iqr(x_vals)*[-1 1]); 
xlabel('log Delta'); ylabel('log Gamma')


%% visualization of a piece of EEG with stages indicated
t_lim=[11000 11080]; %randsample(36000,1)+3600+[0 30]; % t lim for visualization

inds=data.time<t_lim(2) & data.time>t_lim(1); 
% filtering
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',1,'HalfPowerFrequency2',45,'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,data.ephys(inds,:));
h=figure;
chnl_to_plot=chnl_to_bin; %chnl_to_bin; %%%%%%%%%% determine the chnl number to be plotted
plot(data.time(inds),ephys_filt(:,chnl_to_plot)*2,'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-500 500]);

% adding colored shades indicating stage of sleep for any 2-sec bin 
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label    (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1));
label_plot=bin_label (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-240+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
xlabel('Time (sec)');
ylabel('Amplitude (\muV)')
set(h,'position',[100 400 1700 200]);

%% congruence analysis

chnl_name='l_a_'; %%%%%%%%%%%%%%%
bird_name='w044'; %%%%%%%%%%%%%%%
clc;


% Stage lengths
[bouts_Wake_len, bouts_SWS_len, bouts_IS_len, bouts_REM_len] = stage_length(bin_label,valid_bin_inds,t_feat);

% saving results 
fname=['Z:\HamedData\LocalSWPaper\PaperData\' bird_name '_stage_len_' chnl_name ]; 
save(fname,'bin_label','valid_bin_inds','t_bin_label','t_feat',...
    'Delta_','Gamma_','feat','wave_binned', ...
        'bouts_Wake_len', 'bouts_SWS_len', 'bouts_IS_len', 'bouts_REM_len', '-v7.3');






