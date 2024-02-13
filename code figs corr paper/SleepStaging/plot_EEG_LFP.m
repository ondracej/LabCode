% plot channels 
t_lim=randsample(36000,1)+3600+[-.5 20+.5]; % t lim for visualization
inds=time<t_lim(2) & time>t_lim(1); 
% filtering
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8, ...
         'HalfPowerFrequency1',1,'HalfPowerFrequency2',45, ...
         'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,ephys(inds,:));

% initial figure to figure out the channels
chnls_=rec_chnls-rec_chnls(1)+1;   % all channels from desired bird
dist=1000;
noisy=[22 26 27 29 31]-chnl_labels{1}+1; %%%%%%%%%%%%%%% enter the noisy channels!!!!!!
chnls=setdiff(chnls_,noisy); % non-noisy channels
figure
for chnl=1:length(chnls)
    plot(time(inds),ephys_filt(:,chnls(chnl))+dist*chnls(chnl)); hold on
end
yticks(chnls*dist);
yticklabels(chnl_labels(chnls))

% figure for paper
% channels
r_a_eeg_chnl=28 -rec_chnls(1)+1; %%%%%%%%%
l_a_eeg_chnl=21 -rec_chnls(1)+1; %%%%%%%%%
r_p_eeg_chnl=30 -rec_chnls(1)+1; %%%%%%%%%
l_p_eeg_chnl=20 -rec_chnls(1)+1; %%%%%%%%%
lfp_chnls=[23:25 32 ]-rec_chnls(1)+1; %%%%%%%%%%

% colors
r_a_eeg_col=[.1 .1 .7 .8];
l_a_eeg_col=[.1 .1 .7 .8];
r_p_eeg_col=[.7 .1 .1 .8];
l_p_eeg_col=[.7 .1 .1 .8];
lfp_col=[.35 .1 .35 .8];
% normalization scale for the plotting
eeg_scale=iqr(ephys_filt(:,l_p_eeg_chnl))*10;
lfp_scale=iqr(ephys_filt(:,lfp_chnls(1)))*10;

figure
plot(time(inds),ephys_filt(:,l_p_eeg_chnl)/(eeg_scale),'color',l_p_eeg_col); hold on
plot(time(inds),ephys_filt(:,r_p_eeg_chnl)/(eeg_scale)+1,'color',r_p_eeg_col); 

for k=1:length(lfp_chnls)
    plot(time(inds),ephys_filt(:,lfp_chnls(k))/(lfp_scale)+1.3+k,'color',lfp_col); 
end

plot(time(inds),ephys_filt(:,l_a_eeg_chnl)/(eeg_scale)+length(lfp_chnls)+2.6,'color',l_a_eeg_col); 
plot(time(inds),ephys_filt(:,r_a_eeg_chnl)/(eeg_scale)+length(lfp_chnls)+3.6,'color',r_a_eeg_col); 
xlabel('Time (sec)')

yticks([0 1 3.6 6.6 7.6]);
yticklabels({'L post. EEG' ,'R post. EEG', 'DVR LFPs', 'L ant. EEG', 'R ant. EEG'})
ytickangle(0)

title(['distance between EEGs= ' num2str(round(eeg_scale))  '\muV'...
    ',    distance between LFPs= ' num2str(round(lfp_scale)) '\muV']);
axis tight
xlim([t_lim(1)+.5 t_lim(end)-.5])

%% signal trace and spectrogram
figure
chnl_to_plot=l_p_eeg_chnl; %%%%%%%%%% determine the chnl number to be plotted
h1=subplot(2,1,1);
plot(time(inds),ephys_filt(:,chnl_to_plot),'color',r_p_eeg_col); hold on %%%%%%%%%%%% the colors
axesHandles1 = findall(h1,'type','axes');
pos1=get(axesHandles1,'position');
axis tight
xlim([t_lim(1)+.5 t_lim(end)-.5])
ylabel('Amp (\muV)')
h2=subplot(2,1,2);
axesHandles2 = findall(h2,'type','axes');
pos2=get(axesHandles2,'position');
set(h1,'position',[pos1(1:2) pos2(3) pos2(4)]);
% settings for the multitaper
win=[1 .05]; % length of mov win, win step
% params: structure with fields tapers, pad, Fs, fpass, err, trialave
params.tapers=[8 10]; % T*W , k
params.Fs=fs;
params.trialave=0; % no multiple trial, so no trial average: 0
[S,t,f] =mtspecgramc( ephys_filt(:,chnl_to_plot), win, params );
spec_to_plot=flipud(10*log10(S'));
spec_range=iqr(spec_to_plot(:)); %%%%%%%%%%%%
imagesc(t_lim(1)+t,(f),spec_to_plot,[-1*spec_range 1*spec_range]);
f_max=max(f);
yticks(fliplr(f_max+[0 -10 -20 -30 -40 -50]));
yticklabels([50 40 30 20 10 0]);
% yticklabels;
ylim(f_max+[-40 0])
xlabel ('Time (s)');
ylabel('Freq (Hz)')
xlim([t_lim(1)+.5 t_lim(end)-.5])
