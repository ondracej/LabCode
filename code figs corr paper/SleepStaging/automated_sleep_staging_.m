%% preprocessing
% visualization, artefact removal
t_lim=[30 60]*60; % t lim for visualization
inds=time<t_lim(2) & time>t_lim(1);
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',12,'HalfPowerFrequency1',1,'HalfPowerFrequency2',45, ...
    'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,ephys(inds,:));
figure
subplot(2,1,1)
ref_chnl=lfp_chnls(1); %%%%%%%%%% determine the chnl number to be plotted %%%%%%%%%%
plot(time(inds)/60,ephys_filt(:,ref_chnl),'color',[1 1 1]*.3); hold on %%%%%%%%%%%% the colors

w_s_thersh_ref=iqr(ephys_filt(:,ref_chnl))*6.5;

hold on
line([t_lim(1) t_lim(2)]/60, [w_s_thersh_ref w_s_thersh_ref],'linestyle','--');
line([t_lim(1) t_lim(2)]/60, -[w_s_thersh_ref w_s_thersh_ref],'linestyle','--');
xlim([t_lim(1) t_lim(2)]/60); xlabel('Time (min)')
ylim(3*[-w_s_thersh_ref w_s_thersh_ref])
ylabel('Amp (\muV)')
title('Example of Wake-Sleep deliniation, R post EEG');

subplot(2,1,2)
chnl_to_plot=lfp_chnls(1); %%%%%%%%%% determine the chnl number to be plotted
w_s_thersh=iqr(ephys_filt(:,chnl_to_plot))*6;
plot(time(inds)/60,ephys_filt(:,chnl_to_plot),'color',[1 1 1]*.3); hold on %%%%%%%%%%%% the colors

hold on
line([t_lim(1) t_lim(2)]/60, [w_s_thersh w_s_thersh],'linestyle','--');
line([t_lim(1) t_lim(2)]/60, -[w_s_thersh w_s_thersh],'linestyle','--');
xlim([t_lim(1) t_lim(2)]/60); xlabel('Time (min)')
ylim(3*[-w_s_thersh w_s_thersh])
ylabel('Amp (\muV)')
title('Example of Wake-Sleep deliniation, LFP chnl 1');

%% binning of data, feature extraction and clustering

% binning
ephys_filt=filtfilt(bpFilt,ephys);

% chnl_to_bin=r_a_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel
% chnl_to_bin=l_p_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel %
chnl_to_bin=r_p_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel
% chnl_to_bin=lfp_chnls(1); %%%%%%%%%%%%%%%%%%%%%%% choose the channel

n_bins=floor(length(ephys)/(2*fs));
bin_starts=round((0:n_bins-1)*2*fs)+1;
for bin=1:n_bins
    inds=bin_starts(bin):bin_starts(bin)+floor(2*fs)-1;
    wave_binned(bin,:)=ephys_filt(inds,chnl_to_bin);
    ref_binned(bin,:)=ephys_filt(inds,ref_chnl);
    t_bin(bin)=time(inds(round(fs))); % the middle time point of a bin
end

% Sleep staging feature extraction
clear Delta_ref Gamma_ref feat_ref sleep_wake t_feat Delta Gamma feat bin_label_ref bin_label
% for the reference channel and the other channel
[Delta_ref, Gamma_ref, feat_ref, sleep_wake_ref, t_feat]=sleep_feature_extract(ref_binned, t_bin, n_bins, fs, ref_binned, ...
    w_s_thersh_ref, t_dark);

w_s_thersh=iqr(ephys_filt(:,chnl_to_bin))*6; %%%%%%%%%%%
[Delta, Gamma, feat, sleep_wake, ~]=sleep_feature_extract(wave_binned, t_bin, n_bins, fs, ref_binned, ...
    w_s_thersh, t_dark);
beep; pause(.7); beep;

%%  clustering
[bin_label_ref, valid_bin_ref_inds]=cluster_sleep(feat_ref, t_feat, sleep_wake_ref, Delta_ref, Gamma_ref, t_dark);
[bin_label, valid_bin_inds]=cluster_sleep(feat, t_feat, sleep_wake, Delta, Gamma, t_dark );
Delta_ref_=Delta_ref(valid_bin_ref_inds);
Gamma_ref_=Gamma_ref(valid_bin_ref_inds);
Delta_=Delta(valid_bin_inds);
Gamma_=Gamma(valid_bin_inds);
t_bin_label_ref=t_feat(valid_bin_ref_inds);
t_bin_label=t_feat(valid_bin_inds);

% visualization of bins in the feature space
% colors for each stage

% color for each stage, might need to be updated each time 
%%%%%%%%%%%%%%
r=.8*[1 .4 .4]; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
color_order_ref=[r; w; s; i]; %%%%%%%%%%%%%
color_order=[r; i; w; s]; %%%%%%%%%%%%%%
% first plot for the ref chnl
plot_inds=randsample(length(bin_label_ref),2000);
figure
x_vals=log10(Delta_ref_(plot_inds))';
y_vals=log10(Gamma_ref_(plot_inds))';
group_label=bin_label_ref(plot_inds)';
scatterhist(x_vals,y_vals,'Group',group_label,'Kernel','on','Location','SouthEast',...
    'Direction','out','Color',color_order_ref,'LineStyle',{'-','-.',':','--'},...
    'LineWidth',[2,2,2,2],'Marker','....','MarkerSize',.6*[10, 10, 10, 10]);
ylim(median(y_vals)+3*iqr(y_vals)*[-.9 1.4]); 
xlim(median(x_vals)+2.5*iqr(x_vals)*[-1 1.2]); 
title('Frontal ref EEG')
xlabel('log Delta'); ylabel('log Gamma')

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
ylim(median(y_vals)+3*iqr(y_vals)*[-1 1]); 
xlim(median(x_vals)+2.5*iqr(x_vals)*[-1 1]); 
xlabel('log Delta'); ylabel('log Gamma')


%% visualization of a piece of EEG with stages indicated
t_lim=[1670 1680]; %randsample(36000,1)+3600+[0 30]; % t lim for visualization

inds=time<t_lim(2) & time>t_lim(1); 
% filtering
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',1,'HalfPowerFrequency2',45,'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,ephys(inds,:));
h=figure;
chnl_to_plot=chnl_to_bin; %chnl_to_bin; %%%%%%%%%% determine the chnl number to be plotted
plot(time(inds),ephys_filt(:,chnl_to_plot)*2,'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-500 500]);

% adding colored shades indicating stage of sleep for any 2-sec bin 
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label_ref    (t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1));
label_plot=bin_label (t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1 t_bin_plot(bin)+1],-240+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
xlabel('Time (sec)');
ylabel('Amplitude (\muV)')
set(h,'position',[600 500 700 150]);

%% congruence analysis
clc;
congruence_analysis;

% Stage lengths
[bouts_Wake_len, bouts_SWS_len, bouts_IS_len, bouts_REM_len] = stage_length(bin_label,valid_bin_inds,t_feat);
[bouts_Wake_len_ref, bouts_SWS_len_ref, bouts_IS_len_ref, bouts_REM_len_ref] = stage_length(bin_label_ref,valid_bin_ref_inds,t_feat);

%% saving results for non-ref
chnl_name='l_p_eeg_'; %%%%%%%%%%%%%%%
fname=['Z:\zoologie\HamedData\LocalSWPaper\PaperData\' bird_name chnl_name fName(9:end)]; 
save(fname,'bin_label_ref','valid_bin_ref_inds','t_feat',...
    'Delta_ref_', 'Gamma_ref_','feat_ref', 'ref_binned',...
    'bouts_Wake_len','bouts_SWS_len','bouts_IS_len','bouts_REM_len','t_bin_label_ref', '-v7.3');
%% saving results ref
fname=['Z:\zoologie\HamedData\LocalSWPaper\PaperData\' bird_name '_ref' fName(9:end)]; %%%%%%%%%% update bird name and chnl (line 40)
save(fname,'bin_label','bin_label_ref','valid_bin_inds','valid_bin_ref_inds','t_feat',...
    'Delta_','Gamma_','Delta_ref_', 'Gamma_ref_','feat','feat_ref','wave_binned', 'ref_binned',...
    'bouts_Wake_len_ref','bouts_SWS_len_ref','bouts_IS_len_ref','bouts_REM_len_ref','t_bin_label_ref', 't_bin_label',...
    '-v7.3');







