%% Sleep staging feature extraction
clear Delta_ref Gamma_ref feat_ref sleep_wake t_feat Delta Gamma feat bin_label bin_label
% for the reference channel and the other channel
[Delta, Gamma, Low, feat,  t_feat]=sleep_feature_extract_(EEG3sec, t_bins3sec, fs);
beep; pause(.5); beep;
%%  clustering
sleep_wake=valid_inds_logic(2:end-1);
[bin_label, valid_bin_inds]=cluster_sleep_(feat, sleep_wake, Delta, Gamma );

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


% scatter plot of bouts with true label
figure
plot_inds=randsample(length(bin_label),1000);
x_vals=log10(Delta_(plot_inds))';
y_vals=log10(Gamma_(plot_inds))';
group_label=bin_label(plot_inds)';
color_order=[r; s; i; w];

for bin=1:length(plot_inds)
    stage=strcmp(group_label{bin},{'REM','SWS','IS','Wake'});
    scatter(x_vals(bin),y_vals(bin),10,color_order(stage,:),'filled'); hold on
end
ylim(median(y_vals)+3*iqr(y_vals)*[-1 1]); 
xlim(median(x_vals)+2.5*iqr(x_vals)*[-1 1]); 
xlabel('log Delta'); ylabel('log Gamma')


%% visualization of a piece of EEG with stages indicated
% reconstructing the signal from the windows:
ephys=reshape(EEG3sec(:,chnl,:),1,size(EEG3sec,1)*size(EEG3sec,3));
% reconstructing time variable
% interpolating fine time steps from the time of bin centers
bin_centers=size(EEG3sec,1)*.5:size(EEG3sec,1):size(EEG3sec,1)*size(EEG3sec,3)-size(EEG3sec,1)*.5;
t_bin_centers=t_bins3sec;
fine_samples=1:length(ephys);
time = interp1(bin_centers,t_bin_centers,fine_samples);

t_lim=randsample(36000,1)+3600+[0 30]; % t lim for visualization

inds=time<t_lim(2) & time>t_lim(1); 
% filtering
downsamp_ratio=64;
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',1,'HalfPowerFrequency2',45,'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,ephys(inds));
h=figure('position',[ 100 300 1600 150]);
plot(time(inds),ephys_filt*200,'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-500 500]);

% adding colored shades indicating stage of sleep for any 2-sec bin 
color_order_=[r; s; i; w];
color_order_=[color_order_ .7*ones(4,1)];
t_bin_plot=t_bin_label    (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1));
label_plot=bin_label (t_bin_label>=(t_lim(1)-1) & t_bin_label<=(t_lim(2)+1)); %%%%%%%%%% bin_label or bin_label
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.25 t_bin_plot(bin)+1.25],-240+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
xlabel('Time (sec)');
ylabel('Amplitude (\muV)')
