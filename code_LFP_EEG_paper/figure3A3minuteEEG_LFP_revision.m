%% run this code after 'automated_sleep_staging.m'
t_lim=[16815 16845]; %randsample(36000,1)+3600+[0 30]; % t lim for visualization

inds=data.time<t_lim(2) & data.time>t_lim(1); 
% filtering
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',1,'HalfPowerFrequency2',48,'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,data.ephys(inds,:));
h=figure;
set(h,'position',[100 400 1000 350]);
subplot(2,1,1)
chnl_to_plot=chnl_to_bin; %chnl_to_bin; %%%%%%%%%% determine the chnl number to be plotted
plot(data.time(inds),ephys_filt(:,chnl_to_plot),'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-370 350]);

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
title('DVR')


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
title ('Left anterior');


