
clear; clc;
tic
dir_path_ephys='Y:\hameddata2\EEG-LFP-songLearning\w042andw044\w044 and w042\chronic_2022-01-12_21-39-12'; %%%%%%%%
bird_name='w044'; %%%%%%%%%
dir_prefix='150'; %%%%%%%%%
f_postname=''; % if exists! %%%%%%%%%
[~, fName, ~] = fileparts(dir_path_ephys);
saving_name=[bird_name '_' fName(9:18) ]; %%%%%%%%%%%% saving name in the local computer
file_dev=1; % which portion of EEG file you want to read? 10 for ane tenth of the file
rec_chnls=[ 8 5 12 ]; %%%%%%%%%%%% should be a continuous range of integers
data.chnl_names={'LFP'; 'EEG_L_ant'; 'EEG_R_ant'; }; %%%%%%%%%%%%%%%%%%%%

chnl_labels=mat2cell(rec_chnls,1,ones(1,length(rec_chnls)));
downsamp_ratio=128; % must be a power of 2, as the file reader reads blocks of 1024 samples each time, 64

% Reading the EEG
% load EEG as .continuous
[ ephys, time, ~]=OpenEphys2MAT_load_save_Data(rec_chnls, [dir_prefix '_CH'], f_postname, downsamp_ratio, file_dev,...
    dir_path_ephys);
toc
beep; pause(1/1.61); beep;
% binning of data, feature extraction and clustering
lfp1_chnl=1; %%%%%%%%%%%%%%
ref_chnl=2; %%%%%%%% always left anterior EEG chnl; 
t_dark=(11811/20 +time(1))+[0 12*3600]; %%%%%%%%%%%%% light switching times in hameddata2\EEG-LFP-song learning, frame num /20  +time(1)
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',12,'HalfPowerFrequency1',1,'HalfPowerFrequency2',48, ...
    'SampleRate',fs);

chnl_filt=ephys(:,lfp1_chnl);
ref_filt=ephys(:,ref_chnl); 

[b,a] = butter(3,30/(fs/2),'high');
ref_over30=filtfilt(b,a,ephys(:,ref_chnl));
win_len=floor(3*fs);
for current_win=1: (length(chnl_filt)/win_len)
inds=(current_win-1)*win_len +(1:win_len);
    wave_binned(current_win,:)=chnl_filt(inds);
    ref_binned(current_win,:)=ref_filt(inds);
    t_bin(current_win)=time(inds(round(fs*1.5))); % the middle time point of a bin
    pow_30hz(current_win)=rms(ref_over30(inds))^2; % power of high freq in the ref chnl for sleep/wake deliniation
end
 
% Sleep staging feature extraction
clear Delta_ref Gamma_ref feat_ref sleep_wake t_feat Delta Gamma feat bin_label_ref bin_label
% for the reference channel and the other channel
n_bins=length(ref_binned);
[Delta_ref, Gamma_ref, feat_ref,  t_feat_ref]=sleep_feature_extract(ref_binned, t_bin, n_bins, fs);

[Delta, Gamma, feat,  t_feat]=sleep_feature_extract(wave_binned, t_bin, n_bins, fs);
beep; pause(.7); beep;

%%  clustering
move_artef_thresh=median(pow_30hz)+41.5*iqr(pow_30hz); %%%%%%%%%
arte_factor=60; % threshold as a factor of iqr(feat) for artefact removal
% artefact windows:
inds_wake=pow_30hz>move_artef_thresh;

[bin_label_ref, valid_bin_ref_inds]=cluster_sleep(feat_ref, t_feat_ref, ~inds_wake, Delta_ref, ...
    Gamma_ref, t_dark, arte_factor);
[bin_label, valid_bin_inds]=cluster_sleep(feat, t_feat, ~inds_wake, Delta, Gamma, t_dark, arte_factor); %%%%%%%%% is_wake or ~is_wake
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
r=[1 .5 0]; 
s=[.4 .4 1]; 
i=[0 .83 .98]; 
w=.3*[1 1 1];

% scatter plot of bouts: Ref channel
g=figure
plot_inds=randsample(length(bin_label_ref),1000);
x_vals=log10(Delta_ref_(plot_inds))';
y_vals=log10(Gamma_ref_(plot_inds))';
group_label=bin_label_ref(plot_inds)';
color_order=[r; s; i; w];

for bin=1:length(plot_inds)
    stage=strcmp(group_label{bin},{'REM','SWS','IS','Wake'});
    scatter(x_vals(bin),y_vals(bin),8,color_order(stage,:),'filled'); hold on
end
ylim(median(y_vals)+3*iqr(y_vals)*[-1 1]); 
xlim(median(x_vals)+2.5*iqr(x_vals)*[-1 1]); 
xlabel('log Delta'); ylabel('log Gamma')
set(g,'position',[100 400 350 350]);

% scatterhist
figure
scatterhist(x_vals,y_vals,'Group',group_label,'Kernel','on','marker','.','Location','SouthEast',...
    'Direction','out','markersize',[8 8 8 0.001],'color',[i;r;s;w]);
axis([1.4 3.9 .9 1.9])
%% scatter plot of bouts : LFP channel
[bin_label, valid_bin_inds]=cluster_sleep(feat, t_feat, ~inds_wake, Delta, Gamma, t_dark, arte_factor); %%%%%%%%% is_wake or ~is_wake
Delta_=Delta(valid_bin_inds);
Gamma_=Gamma(valid_bin_inds);
t_bin_label=t_feat(valid_bin_inds);

z=figure
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
set(z,'position',[100 400 350 350]);

% scatterhist
figure
scatterhist(x_vals,y_vals,'Group',group_label,'Kernel','on','marker','.','Location','SouthEast',...
    'Direction','out','markersize',[8 8 8 0.001],'color',[r;s;i;w]);
axis([2.5 5 1.75 2.75])
%% visualization of a piece of EEG with stages indicated
t0=500;
t_lim=t0+[0 30]; %randsample(36000,1)+3600+[0 30]; % t lim for visualization

inds=time<t_lim(2) & time>t_lim(1); 
% filtering
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',1,'HalfPowerFrequency2',45,'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,ephys(inds,:));
h=figure;
subplot(2,1,1)
chnl_to_plot=ref_chnl; %lfp1_chnl; %%%%%%%%%% determine the chnl number to be plotted
plot   (time(inds),ephys_filt(:,chnl_to_plot)*4,'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-550 500]);

% adding colored shades indicating stage of sleep for any 2-sec bin 
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label_ref(t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1));
label_plot=bin_label_ref (t_bin_label_ref>=(t_lim(1)-1) & t_bin_label_ref<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-450+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
xlabel('Time (sec)');
ylabel({'front L EEG';'Amplitude (\muV)'})
set(h,'position',[100 400 1700 150]);


% visualization of a piece of LFP with stages indicated

subplot(2,1,2)
chnl_to_plot=lfp1_chnl; %lfp1_chnl; %%%%%%%%%% determine the chnl number to be plotted
plot(time(inds),ephys_filt(:,chnl_to_plot),'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-550 500]);

% adding colored shades indicating stage of sleep for any 2-sec bin 
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label(t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1));
label_plot=bin_label (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label_ref
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-450+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
xlabel('Time (sec)');
ylabel({'LFP';'Amplitude (\muV)'})
set(h,'position',[100 400 1000 250]);




