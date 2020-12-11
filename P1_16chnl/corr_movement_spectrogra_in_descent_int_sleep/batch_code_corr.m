clear r_dif
tic
f_path=[folder_path '\' fname '.avi'];
vid=VideoReader(f_path);

% selecting frame range for processig
f0=max(1,light_off_frame-10*60*20); % 1st frame
fn=light_off_frame+30*60*20; %'%%%%%%%%%% 30 min after lights-off %%%%%%%%%%

frames=f0: fn; % frames to be analyzed
roi_y=1:1024;  roi_x=1:1280; % where is the region of interest?
[r_dif,acc_dif, last_im, last_dif] = birdvid_move_extract(f_path,frames,roi_y,roi_x);
r_dif=[r_dif(frames(1:end-1)) r_dif(end)];
mkdir(dir_path);
save([dir_path ' r_dif'],'r_dif');
clear roi_x roi_y   vid
toc


% time frames for video frames: loading synchroniying ADC channel
downsamp_ratio=1; % must be a power of 2, as the file reader reads blocks of 1024 samples each time
file_dev_adc=5; % which poetion of file you want to read? 10 for ane tenth of the file
[ ADC, time_adc, ~]=OpenEphys2MAT_load_save_Data(1, [dir_prefix '_ADC'], downsamp_ratio, file_dev_adc,...
    dir_path_server);
%Extracting synchroniying times of frames
[peak_indx]=find(ADC.*(ADC>4));
jumps_to_new_frame_indx=[diff(peak_indx)>5; true];
unique_peak_indx=peak_indx(jumps_to_new_frame_indx);
t_frames=time_adc(unique_peak_indx);
save([dir_path ' t_frames'],'t_frames');
clear unique_peak_indx jumps_to_new_frame_indx ADC time_adc peak_indx
t_frames=t_frames(frames);
t_light_off=t_frames(light_off_frame-f0+1);
% %% loading EEG as mat (or go to the next cell)
% [~,bird,~] = fileparts(dir_path);
% eeg_data=load([dir_path '\' bird]);
% EEG=eeg_data.EEG;   time=eeg_data.time;   t1=eeg_data.t1;
% clear eeg_data

% load EEG as .continuous
downsamp_ratio=16; %%%%%%%%% must be a power of 2, as the file reader reads blocks of 1024 samples each time
tic
[ EEG, time, ~]=OpenEphys2MAT_load_save_Data(chnl_order, [dir_prefix '_CH'], downsamp_ratio, file_dev,...
    dir_path_server);
toc
%% plot body movement and spectrogram
t_lim_plot=[t_frames(1) t_frames(end)-600];  %%%%%%%%%%% time for plotting

figure
subplot(3,1,1)
r_dif_detrend=movmedian(r_dif,20);
plot(t_frames/60, r_dif_detrend);
ylabel({'body movement' ;'(pixel)'})
ylim(median(r_dif_detrend)+[-1*iqr(r_dif_detrend) 8*iqr(r_dif_detrend)]) ; %%%%%%%%%%%%%
xlim(t_lim_plot/60); title(['Descend into sleep in bird: ' dir_path])
xticklabels({})
line([t_light_off t_light_off]/60,[ ylim],'color',[.1 .1 .1],'linestyle','--');

% spectrogram
Fs=30000/downsamp_ratio;
chnl=4; %%%%%%%%% which channel to pick
DownRat=4; %%%%%%%%% down sampling ratio for spectrogram
fs=Fs/DownRat; % samling rate of down-sampled data
eeg=downsample(EEG(f0/20*Fs:fn/20*Fs,chnl),DownRat); % as we just focus on < 50Hz
t=downsample(time(f0/20*Fs:fn/20*Fs),DownRat);
f=.25:.25:40;
[s,f_,t_] = spectrogram(eeg,flattopwin(fs*10),round(fs*9.75),f,fs); %%%%%%% overlap
subplot(3,1,2)
h=imagesc((t_+t(1))/60,f_,flipud(abs(s)), ...
    median(abs(s(:)))+2*[-iqr(abs(s(:)))  iqr(abs(s(:)))])
colormap('parula')
axis tight
ylabel({'EEG Spectrogram'; '(Hz)'})
xlim(t_lim_plot/60); % time constraints, in minute
ylim([0 40]); % frequency constraints
y=yticklabels; yticklabels(flipud(y));
xticklabels({})
line([t_light_off t_light_off]/60,[ ylim],'color',[.1 .1 .1],'linestyle','--');

% correlation over time (calculation) just between 2 chnls
clear ll_corr lr_corr rr_corr t_cor
ll_corr=zeros(1,ceil(t_lim_plot(end)*60));
rr_corr=zeros(1,ceil(t_lim_plot(end)*60));
lr_corr=zeros(1,ceil(t_lim_plot(end)*60));

t_corr=t_lim_plot(1)+1:1:t_lim_plot(end)-1;
tic
n=1; % loop counter
tic
disp('Computing Correlation ...')
for k=t_corr
    
    indx=time>k-1 & time<=k+1;
    if sum(indx)>1
        t_cor(n)=k;
        ll_corr(n)=(sum(corr(zscore(EEG(indx,1:8)),'type','spearman'),'all')-8)/56;
        lr_corr(n)=sum(corr(zscore(EEG(indx,1:8)),EEG(indx,9:16),'type','spearman'),'all')/64;
        rr_corr(n)=(sum(corr(zscore(EEG(indx,9:16)),'type','spearman'),'all')-8)/56;
        n=n+1;
    end

end
toc
L=3; % moving average smoother length for corr, in seconds
ll_corr_=filtfilt(ones(1,L)/L,1,ll_corr(1:n-1));
lr_corr_=filtfilt(ones(1,L)/L,1,lr_corr(1:n-1));
rr_corr_=filtfilt(ones(1,L)/L,1,rr_corr(1:n-1));
subplot(3,1,3)
plot(t_cor/60,ll_corr_,'color',[0 .8 1]); hold on
plot(t_cor/60,rr_corr_,'color',[0 .4 .6]);
plot(t_cor/60,lr_corr_,'color',[0 .6 .4]);
xlim(t_lim_plot/60); % time constraints, in minute
line([t_light_off t_light_off]/60,[ ylim],'color',[.1 .1 .1],'linestyle','--');
legend({'L-L','R-R','R-L'}); ylabel({'Correlation';'between EEGs'})
xlabel('Time (minute)')
