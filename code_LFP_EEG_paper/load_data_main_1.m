clear; clc;
tic
dir_path_ephys='Y:\hameddata2\EEG-LFP-songLearning\w025andw027\w0025-w0027 -just ephys\chronic_2021-08-17_21-47-03'; %%%%%%%%
bird_name='w027'; %%%%%%%%%
dir_prefix='150'; %%%%%%%%%
f_postname=''; % if exists! %%%%%%%%%
[~, fName, ~] = fileparts(dir_path_ephys);
saving_name=[bird_name '_4LFP' fName(9:18) ]; %%%%%%%%%%%% saving name in the local computer
file_dev=1; % which portion of EEG file you want to read? 10 for ane tenth of the file
rec_chnls=[ 18 32 24 26 28 29 21 20 ]; %%%%%%%%%%%% should be a continuous range of integers
data.chnl_names={'LFP1';'LFP2';'LFP3';'LFP4';'EEG_R_ant'; 'EEG_R_post';'EEG_L_ant';'EEG_L_post';}; %%%%%%%%%%%%%%%%%%%%

chnl_labels=mat2cell(rec_chnls,1,ones(1,length(rec_chnls)));
downsamp_ratio=64; % must be a power of 2, as the file reader reads blocks of 1024 samples each time, 64

% Reading the EEG
% load EEG as .continuous
[ ephys, time, ~]=OpenEphys2MAT_load_save_Data(rec_chnls, [dir_prefix '_CH'], f_postname, downsamp_ratio, file_dev,...
    dir_path_ephys);
toc
beep; pause(1/1.61); beep;
% save the output variables
data.ephys=ephys;

data.rec_chnl=rec_chnls;  
data.time=time;
save(['Y:\hameddata2\EEG-LFP-songLearning\Mat_files\' saving_name],'data','-v7.3','-nocompression'); % add light on
% light off times

%% Reading the ADC
% load EEG as .continuous
% rec_chnls=[1:6]; %%%%%%%%%%%% should be a continuous range of integers
% [ ADCs, ~, ~]=OpenEphys2MAT_load_save_Data(rec_chnls, [dir_prefix '_AUX'], f_postname, downsamp_ratio, file_dev,...
%     dir_path_ephys);

%% load video
folder_path='Y:\hameddata2\EEG-LFP-song learning\w025 and w027\w0025'; %%%%%%%%%%%%%
fname='w25-05-08-2021_00197_converted'; %%%%%%%%%%%%
f_path=[folder_path '\' fname '.avi'];
vid=VideoReader(f_path);
frames=1: (vid.NumFrames-2000); % frames to be analyzed

clear r_dif
roi_y=1:512;  roi_x=700:1280;  % where is the region of interest? %%%%%%%%%%%%%
frame_n=1; % frame counter
k=1; % epoch counter for video
while frame_n+3*20-1<=vid.NumFrames
win_frames=frame_n:frame_n+3*20-1;
[r_dif(k,:),~, ~, ~] = birdvid_move_extract_app_obj(vid,win_frames,roi_y,roi_x); 
if rem(k,200)==0 
    disp([num2str(k*3/3600) ' hrs through vid']);
end
frame_n=frame_n+3*20;
k=k+1;
end

mov=mean(r_dif,2);
beep; pause(1/1.61); beep;

%% save video
load(['Y:\hameddata2\EEG-LFP-song learning\Mat_files\' saving_name],'data'); % add light on
data.mov=mov;
save(['Y:\hameddata2\EEG-LFP-song learning\Mat_files\' saving_name],'data'); % add light on

%% crude visualization of channels
% plot channels 
t_lim=randsample(2900,1)+1000+[-.5 20+.5]; % t lim for visualization
inds=time<t_lim(2) & time>t_lim(1); 
% filtering
fs=30000/downsamp_ratio;
bpFilt = designfilt('bandpassiir','FilterOrder',8, ...
         'HalfPowerFrequency1',1,'HalfPowerFrequency2',45, ...
         'SampleRate',fs);
ephys_filt=filtfilt(bpFilt,ephys(inds,:));

% initial figure to figure out the channels
chnls=rec_chnls-rec_chnls(1)+1;   % all channels from desired bird
dist=1000;
figure
for chnl=1:length(chnls)
    plot(time(inds),ephys_filt(:,chnls(chnl))+dist*chnls(chnl)); hold on
end
yticks(chnls*dist);
yticklabels(chnl_labels(chnls))

%% visualization video+EEG
figure
plot(time(1:10:end),data.ephys(1:10:end,1));
figure;
plot(mov);


%% filter EEG in high freq to extract the artefacts

fs=30000/downsamp_ratio;
[b,a] = butter(3,30/(fs/2),'high');
ephys_filt=filtfilt(b,a,data.ephys(:,8));
figure('position',[200 300 1000 400]);
subplot(2,1,1)
plot((1:length(mov))*3/3600-0.21,mov,'color',[.8 0 .2]); hold on
artefact_detect_thresh=median(mov)+3*iqr(mov);
ylim(median(mov)+2*std(mov)*[-.5 3]);
title(['Movement extracted from video, bird ID: ' bird_name])
ylabel('# pixel changes')
xlim([-.1 2])
line(xlim ,artefact_detect_thresh*[1 1],'linestyle','--');

subplot(2,1,2)
plot(time/3600-0.21,ephys_filt,'color',[.2 0 .8]); 
artefact_detect_thresh=median(ephys_filt)+5*iqr(ephys_filt);

title('Frontal Right EEG filtered for above 30 Hz')
ylim(median(ephys_filt)+10*std(ephys_filt)*[-1 1]);
ylabel('Amplitude (\muV)')
xlabel('Time (h)')
xlim([-.1 2])
line(xlim ,artefact_detect_thresh*[1 1],'linestyle','--');


%% similar figure for the smooth traces
figure('position',[200 300 1000 400]);
subplot(2,1,1)
plot((1:length(mov))*3/3600-0.21,movmean(mov,20),'color',[.8 0 .2]);
ylim(median(movmean(mov,5*20/3))+3*std(movmean(mov,20))*[-.1 1.2]);
title('Movement extracted from video')
ylabel('# pixel changes')
xlim([-.3 12.3])
subplot(2,1,2)
plot(time/3600-0.21,movmean(ephys_filt,60*fs),'color',[.2 0 .8]);
title('Frontal Right EEG filtered for above 30 Hz')
ylim(median(movmean(ephys_filt,60*fs))+20*std(movmean(ephys_filt,60*fs))*[-1 1]);
ylabel('Amplitude (\muV)')
xlabel('Time (h)')
xlim([-.3 12.3])

%% diffentiation of sleep from wake
% if 2 consequtive 3-sec windows have move artefact, they are not
% considered sleep
% Besides, the windows with artefact are marked to be excluded from further
% analysis
% calculating EEG power in >30Hz band, in 3-sec windows:
[b,a] = butter(3,30/(fs/2),'high');
ephys_filt=filtfilt(b,a,data.ephys(:,8));
win_len=floor(3*fs);
for current_win=1: (length(ephys_filt)/win_len)
inds=(current_win-1)*win_len +(1:win_len);
pow_30hz(current_win)=rms(ephys_filt(inds))^2;
t_bin(current_win)=time(round(median(inds)));
end

artefact_detect_thresh=median(pow_30hz)+5*iqr(pow_30hz);
% artefact windows:
inds_wake=pow_30hz>artefact_detect_thresh; 

%%  figure for wake detection in smooth traces ...
figure('position',[200 300 1200 200]);
plot((1:length(mov))*3/3600-0.27,movmean(mov,10),'color',[.8 0 .2]); hold on
ylim(median(movmean(mov,5*20/3))+3*std(movmean(mov,20))*[-.1 1.2]);
title('red: movement extracted from video,     black: EEG artefact, pow(>30)>5*iqr,      w025')
ylabel('(#pixel change)')
xlim([-.3 12.3])
plot(t_bin/3600-0.27,2200*inds_artefact,'color',[0 0 0 .1]);

xlabel('Time from sleep onset (h)')
xlim([-.3 12.3])
legend('mov','EEG artefact');




