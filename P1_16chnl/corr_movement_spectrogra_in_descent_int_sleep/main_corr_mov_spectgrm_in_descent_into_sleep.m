%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this code makes the figure for the change at the initiation of sleep. It
% includes total body dispositions, spectrogram of EEG, and correlation
% between channels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('D:\Part 1 PhD\Code\LabCode\LoadEphys_SWRanalysis'));
addpath(genpath('D:\Part 1 PhD\Code\LabCode\Respiration VideoAnalysis'));
addpath(genpath('D:\Part 1 PhD\Code\LabCode\P1_16chnl'));

%% body movement

% loading the video
folder_path='Y:\HamedData\P1\72-94\07-06-2020'; %%%%%%%%%%
fname='07-06-2020_00143_converted'; %%%%%%%%%%%%
f_path=[folder_path '\' fname '.avi']; 
vid=VideoReader(f_path);

% selecting frame range for processig
f0=20*60*10; % 1st frame 
fn=20*60*50; % 50 min %%%%%%%%%%

frames=f0: fn; % frames to be analyzed
roi_y=1:1024;  roi_x=1:1280; % where is the region of interest?
[r_dif,acc_dif, last_im, last_dif] = birdvid_move_extract(f_path,frames,roi_y,roi_x);
save([dir_path ' r_dif'],'r_dif'); 
clear roi_x roi_y  f0 vid
%% time frames for video frames: loading synchroniying ADC channel
dir_path='D:\Part 1 PhD\Data\72_94 07_06_2020'; %%%%%%%%%%%%%
dir_prefix='133'; %%%%%%%%%%%%%%
[ ADC, time_adc, ~]=OpenEphys2MAT_load_save_Data(1, [dir_prefix '_ADC'],1,dir_path);
%Extracting synchroniying times of frames
[peak_indx]=find(ADC.*(ADC>4));
jumps_to_new_frame_indx=[diff(peak_indx)>5; true];
unique_peak_indx=peak_indx(jumps_to_new_frame_indx);
t_frames=time_adc(unique_peak_indx);
save([dir_path ' t_frames'],'t_frames'); 
clear unique_peak_indx jumps_to_new_frame_indx ADC time_adc peak_indx dir_prefix

%% loading EEG
[~,bird,~] = fileparts(dir_path);
eeg_data=load([dir_path '\' bird]);
EEG=eeg_data.EEG;   time=eeg_data.time;   t1=eeg_data.t1;  
clear eeg_data
%% plot body movement and spectrogram 
t_off=.1; % t1(1)*60+t1(2); %%%%%%%%%%%%%%%
t_lim_plot=[t_off t_off+20];  %%%%%%%%%%% time for plotting

figure
subplot(3,1,1)
plot(t_frames(frames(1:end))/60,r_dif(frames(1:end)));  
ylabel({'body dispositions' ;'(pixel)'})
ylim([median(r_dif)-1*iqr(r_dif) median(r_dif)+10*iqr(r_dif)]) ;
xlim(t_lim_plot); title(['Descend into sleep: bird ' 'bird'])

% spectrogram
Fs=2000;
chnl=4; %%%%%%%%% which channel to pick
DownRat=8; %%%%%%%%% down sampling ratio
fs=Fs/DownRat; % samling rate of down-sampled data
eeg=downsample(EEG(1:fn/20*Fs,chnl),DownRat); % as we just focus on < 50Hz 
t=downsample(time(1:fn/20*Fs),DownRat);
f=.25:.25:40;
[s,f_,t_] = spectrogram(eeg,flattopwin(fs*10),round(fs*9.75),f,fs); %%%%%%% overlap
subplot(3,1,2)
h=imagesc((t_+t(1))/60,f_,flipud(abs(s)), ...
    median(abs(s(:)))+2*[-iqr(abs(s(:)))  iqr(abs(s(:)))])
colormap('parula')
axis tight
ylabel({'EEG Spectrogram'; '(Hz)'})
xlim(t_lim_plot); % time constraints, in minute
ylim([0 40]); % frequency constraints
y=yticklabels; yticklabels(flipud(y));

%% correlation over time (calculation) just between 2 chnls
ll_corr=zeros(1,t_lim_plot(end)*60);
rr_corr=zeros(1,t_lim_plot(end)*60);
lr_corr=zeros(1,t_lim_plot(end)*60);

t_corr=t_lim_plot(1)*60:1:t_lim_plot(end)*60;
tic
for k=t_corr
    if (rem(k,50)==0) k
    toc
    tic
    end
indx=time>k-1 & time<=k+1;
ll_corr(k)=(sum(corr(zscore(EEG(indx,1:8)),'type','spearman'),'all')-8)/56;
lr_corr(k)=sum(corr(zscore(EEG(indx,1:8)),EEG(indx,9:16),'type','spearman'),'all')/64;
rr_corr(k)=(sum(corr(zscore(EEG(indx,9:16)),'type','spearman'),'all')-8)/56;

end
subplot(3,1,3)
plot([zeros(1,t_corr(1)-1) t_corr]/60,ll_corr,'color',[0 .8 1]); hold on
plot([zeros(1,t_corr(1)-1) t_corr]/60,rr_corr,'color',[0 .6 .7]); 
plot([zeros(1,t_corr(1)-1) t_corr]/60,lr_corr,'color',[0 .4 .4]); 
xlim(t_lim_plot); % time constraints, in minute

