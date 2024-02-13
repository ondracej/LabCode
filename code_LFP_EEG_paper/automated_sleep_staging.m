 clear; clc;
 load('Y:\hameddata2\EEG-LFP-songLearning\Mat_files\w027_2021-08-17');
% tic
% dir_path_ephys='Y:\hameddata2\EEG-LFP-songLearning\w025andw027\w0025-w0027 -just ephys\chronic_2021-08-17_21-47-03'; %%%%%%%%
% bird_name='w027'; %%%%%%%%%
% dir_prefix='150'; %%%%%%%%%
% f_postname=''; % if exists! %%%%%%%%%
% [~, fName, ~] = fileparts(dir_path_ephys);
% saving_name=[bird_name '_' fName(9:18) ]; %%%%%%%%%%%% saving name in the local computer
% file_dev=1; % which portion of EEG file you want to read? 10 for ane tenth of the file
% rec_chnls=[ 24 28 29 20 21 ]; %%%%%%%%%%%% should be a continuous range of integers
% data.chnl_names={'LFP';'EEG_R_ant'; 'EEG_R_post';'EEG_L_post';'EEG_L_ant';}; %%%%%%%%%%%%%%%%%%%%
% 
% chnl_labels=mat2cell(rec_chnls,1,ones(1,length(rec_chnls)));
% downsamp_ratio=64; % must be a power of 2, as the file reader reads blocks of 1024 samples each time, 64
% 
% % Reading the EEG
% % load EEG as .continuous
% [ ephys, time, ~]=OpenEphys2MAT_load_save_Data(rec_chnls, [dir_prefix '_CH'], f_postname, downsamp_ratio, file_dev,...
%     dir_path_ephys);
% toc
% beep; pause(1/1.61); beep;
% % save the output variables
% data.ephys=ephys;
% 
% data.rec_chnl=rec_chnls;  
% data.time=time;
% save(['Y:\hameddata2\EEG-LFP-song learning\Mat_files\' saving_name],'data','-v7.3','-nocompression'); % add light on
% % light off times

% binning of data, feature extraction and clustering
lfp1_chnl=1; %%%%%%%%%%%%%%
r_a_eeg_chnl=2; %%%%%%%%%%%%%%
r_p_eeg_chnl=3; %%%%%%%%%%%%%%
l_a_eeg_chnl=4; %%%%%%%%%%%%%%
l_p_eeg_chnl=5; %%%%%%%%%%%%%%
ref_chnl=l_a_eeg_chnl; % always left anterior EEG chnl; 
t_dark=data.time(1)+[0 10]*3600; %%%%%%%%%%%%% light switching times in hameddata2\EEG-LFP-song learning, frame num /20  +time(1)
downsamp_ratio=64; 
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',4,'HalfPowerFrequency1',1,'HalfPowerFrequency2',48, ...
    'SampleRate',fs);

% binning
% chnl_to_bin=l_p_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel
% chnl_to_bin=r_p_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel %
chnl_to_bin=lfp1_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel
% chnl_to_bin=r_a_eeg_chnl; %%%%%%%%%%%%%%%%%%%%%%% choose the channel

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

move_artef_thresh=median(pow_30hz)+5*iqr(pow_30hz);
% artefact windows:
inds_wake=pow_30hz>move_artef_thresh; 
% Sleep staging feature extraction
clear Delta_ref Gamma_ref feat_ref sleep_wake t_feat Delta Gamma feat bin_label_ref bin_label
% for the reference channel and the other channel
n_bins=length(ref_binned);
[Delta_ref, Gamma_ref, feat_ref,  t_feat_ref]=sleep_feature_extract(ref_binned, t_bin, n_bins, fs);

[Delta, Gamma, feat,  t_feat]=sleep_feature_extract(wave_binned, t_bin, n_bins, fs);
beep; pause(.7); beep;

%%  clustering
arte_factor=7; %%%%%%%%%%%%
[bin_label_ref, valid_bin_ref_inds]=cluster_sleep(feat_ref, t_feat_ref, ~inds_wake, Delta_ref, Gamma_ref,...
    t_dark, arte_factor);
[bin_label, valid_bin_inds]=cluster_sleep(feat, t_feat, ~inds_wake, Delta, Gamma, t_dark, arte_factor ); %%%%%%%%% is_wake or ~is_wake
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
r=[253 145 33]/256; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
w=[.9 .9 .3];
color_order_ref=[r; w; s; i]; %%%%%%%%%%%%%
color_order=[r; i; w; s]; %%%%%%%%%%%%%%
% first plot for the ref chnl
plot_inds=randsample(length(bin_label_ref),1500);
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
plot_inds=randsample(length(bin_label_ref),1000);
x_vals=log10(Delta_ref_(plot_inds))';
y_vals=log10(Gamma_ref_(plot_inds))';
group_label=bin_label_ref(plot_inds)';
color_order=[r; s; i; w];

for bin=1:length(plot_inds)
    stage=strcmp(group_label{bin},{'REM','SWS','IS','Wake'});
    scatter(x_vals(bin),y_vals(bin),15,color_order(stage,:),'filled'); hold on
end
ylim(median(y_vals)+3*iqr(y_vals)*[-1 1]); 
xlim(median(x_vals)+2.5*iqr(x_vals)*[-1 1]); 
xlabel('log Delta'); ylabel('log Gamma')


%% visualization of a piece of EEG with stages indicated
t_lim=4.1*3600+[2060 2090]; %randsample(36000,1)+3600+[0 30]; % t lim for visualization

inds=data.time<t_lim(2) & data.time>t_lim(1); 
% filtering
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',1,'HalfPowerFrequency2',45,'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,data.ephys(inds,:));
h=figure;
set(h,'position',[100 400 1700 250]);
subplot(2,1,1)
chnl_to_plot=chnl_to_bin; %chnl_to_bin; %%%%%%%%%% determine the chnl number to be plotted
plot(data.time(inds),ephys_filt(:,chnl_to_plot),'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-350 350]);

% adding colored shades indicating stage of sleep for any 2-sec bin 
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1));
label_plot=bin_label (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-300+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
ylabel('Amp (\muV)')

subplot(2,1,2)
chnl_to_plot=ref_chnl; %chnl_to_bin; %%%%%%%%%% determine the chnl number to be plotted
plot(data.time(inds),ephys_filt(:,chnl_to_plot),'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-115 100]);

% adding colored shades indicating stage of sleep for any 2-sec bin 

t_bin_plot=t_bin_label_ref (t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1));
label_plot=bin_label_ref (t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-90+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
xlabel('Time (sec)');
ylabel('Amp (\muV)')

%% congruence analysis

chnl_name='r_p_'; %%%%%%%%%%%%%%%
bird_name='w027'; %%%%%%%%%%%%%%%
clc;
% congruence_analysis; %%%%%%%%%%%% comment?
% 
% % Stage lengths
% [bouts_Wake_len, bouts_SWS_len, bouts_IS_len, bouts_REM_len] = stage_length(bin_label,valid_bin_inds,t_feat);
% [bouts_Wake_len_ref, bouts_SWS_len_ref, bouts_IS_len_ref, bouts_REM_len_ref] = stage_length(bin_label_ref,valid_bin_ref_inds,t_feat);

% saving results 
fname=['Y:\hameddata2\EEG-LFP-songLearning\Mat_files\ReClustering\' bird_name '_' chnl_name ]; 
save(fname,'bin_label','t_bin_label','bin_label_ref','t_bin_label_ref','t_feat','Delta','Gamma','Delta_ref',...
    'Gamma_ref','wave_binned','ref_binned','t_bin','-v7.3');






