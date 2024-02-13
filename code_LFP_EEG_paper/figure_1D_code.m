clear; clc;
tic
dir_path_ephys='Y:\hameddata2\EEG-LFP-songLearning\w025andw027\w0025-w0027 -just ephys\chronic_2021-08-17_21-47-03'; %%%%%%%%
bird_name='w027'; %%%%%%%%%
dir_prefix='150'; %%%%%%%%%
f_postname=''; % if exists! %%%%%%%%%
[~, fName, ~] = fileparts(dir_path_ephys);
saving_name=[bird_name '_' fName(9:18) ]; %%%%%%%%%%%% saving name in the local computer
file_dev=1; % which portion of EEG file you want to read? 10 for ane tenth of the file
rec_chnls=[ 20 24 ]; %%%%%%%%%%%% should be a continuous range of integers
data.chnl_names={'EEG_L_post'; 'LFP'; }; %%%%%%%%%%%%%%%%%%%%
% rec_chnls=[ 28 30 23 24 25 32 21 20 ]; %%%%%%%%%%%% should be a continuous range of integers
% data.chnl_names={'EEG_L_post';'EEG_L_ant';...
%     'LFP';'LFP';'LFP';'LFP';'EEG_R_post';'EEG_R_ant'; }; %%%%%%%%%%%%%%%%%%%%

chnl_labels=mat2cell(rec_chnls,1,ones(1,length(rec_chnls)));
downsamp_ratio=64; % must be a power of 2, as the file reader reads blocks of 1024 samples each time, 64

% Reading the EEG
% load EEG as .continuous
[ ephys, time, ~]=OpenEphys2MAT_load_save_Data(rec_chnls, [dir_prefix '_CH'], f_postname, downsamp_ratio, file_dev,...
    dir_path_ephys);
toc
beep; pause(1/1.61); beep;

%% crude visualization of channels
% plot channels
t_lim=4.1*3600+[2030 2150];  % t lim for visualization
time=data.time;
inds=time<t_lim(2) & time>t_lim(1);
% filtering
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8, ...
    'HalfPowerFrequency1',.3,'HalfPowerFrequency2',45, ...
    'SampleRate',fs);
ephys=data.ephys;
ephys_filt=filtfilt(bpFilt,ephys(inds,:));

% initial figure to figure out the channels
chnls=rec_chnls;   % all channels from desired bird

YTicks=[];
figure('position',[400 300 700 400])
for chnl=1:length(chnls)
    dist=std(ephys_filt(:,chnl));
    plot(time(inds),ephys_filt(:,chnl)/dist+8*(chnl-1),'color',.6*[1 1 1],'linewidth',1); hold on
    xlim([1670 1685]);
    YTicks=[YTicks max(YTicks)+8*(chnl-1)];
end
yticks(YTicks);
yticklabels(chnl_labels);

%% figures with the spectrogram
figure('position',[400 300 900 400])
bpFilt = designfilt('bandpassiir','FilterOrder',8, ...
    'HalfPowerFrequency1',.3,'HalfPowerFrequency2',45, ...
    'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,ephys(inds,:));

subplot(4,1,1) % LFP (chnl 3)
plot(time(inds),ephys_filt(:,3),'color',0*[1 1 1],'linewidth',1);
xlim([1670 1685]);
ylabel('Amp (\muV)')
subplot(4,1,2) % spectrogram
f_lim=21;
PlotSpectrogram(ephys_filt(:,3),time(inds),fs,f_lim);
ylim([0 20])
xlim([1670 1685]);
ylabel('Frequency (Hz)')
subplot(4,1,3) % L anterior EEG (chnl 2)
plot(time(inds),ephys_filt(:,2),'color',0*[1 1 1],'linewidth',1);
xlim([1670 1685]);
ylabel('Amp (\muV)')

subplot(4,1,4) % spectrogram
PlotSpectrogram(ephys_filt(:,2),time(inds),fs,f_lim);
ylim([0 20])
xlim([1670 1685]);
ylabel('Frequency (Hz)')

%% save a as vector image
% folder_path='Z:\HamedData\LocalSWPaper\figures\fig. 1 histo recordingSites traces and spectrograms'; %%%%%%%%%%
% file_name='Fig1D_spectograms'; %%%%%%%%%%%
% set(gcf,'renderer','Painters')
% print([folder_path '\' file_name '.eps'],'-depsc')


