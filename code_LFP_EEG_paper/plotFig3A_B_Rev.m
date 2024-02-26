%% load the signals and the labels
load('Y:\hameddata2\EEG-LFP-songLearning\Mat_files\w027_2021-08-17');
%%
load('Y:\zoologie\HamedData\LocalSWPaper\PaperData\new_scorings\w027_l_a');

chnl_to_plot=4; %%%%%%%%%%%%%%%
t_lim=[16818 16900]; %randsample(36000,1)+3600+[0 30]; % t lim for visualization
r=[ 253 145 33]/255; 
s=[.4 .4 1]; 
i=[.2 1 1]; 
inds=data.time<t_lim(2) & data.time>t_lim(1); 
% filtering
downsamp_ratio=64
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',1,'HalfPowerFrequency2',48,'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,data.ephys(inds,:));
h=figure;
set(h,'position',[100 400 800 350]);
subplot(2,1,1)
plot(data.time(inds),ephys_filt(:,chnl_to_plot),'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-115 100]);

% adding colored shades indicating stage of sleep for any 2-sec bin 
color_order_=[r; s; i; ];
color_order_=[color_order_ .7*ones(3,1)];
t_bin_plot=t_DG (t_DG>=(t_lim(1)-1) & t_DG<=(t_lim(2)+1));
label_plot=labels_ (t_DG>=(t_lim(1)-1) & t_DG<=(t_lim(2)+1)); %%%%%%%%%% bin_label or labels_
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS','Wake'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-100+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
ylabel('Amp (\muV)')
title('EEG Left Anterior')

clear labels_
subplot(2,1,2)
load('Y:\zoologie\HamedData\LocalSWPaper\PaperData\new_scorings\w027_lfp');
chnl_to_plot=1; %chnl_to_bin; %%%%%%%%%% determine the chnl number to be plotted
plot(data.time(inds),ephys_filt(:,chnl_to_plot),'color',.1*[1 1 1]); hold on % scale coeff for vizualization 
ylim([-370 350]);

% adding colored shades indicating stage of sleep for any 2-sec bin 

t_bin_plot=t_DG (t_DG>=(t_lim(1)-1) & t_DG<=(t_lim(2)+1));
label_plot=labels_ (t_DG>=(t_lim(1)-1) & t_DG<=(t_lim(2)+1)); %%%%%%%%%% bin_label or labels_
for bin=1:length(t_bin_plot)
    stage=strcmp(label_plot(bin),{'REM','SWS','IS'});
    line([t_bin_plot(bin)-1.5 t_bin_plot(bin)+1.5],-290+[0 0],'color',color_order_(stage,:),'linewidth',10 );
end
xlim(t_lim)
xlabel('Time (sec)');
ylabel('Amp (\muV)')
title ('LFP DVR');


