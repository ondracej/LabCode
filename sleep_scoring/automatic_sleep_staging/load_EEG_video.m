
%% loading the data
% setting addresses and parameters
saving_name='w009_30-04_scoring'; %%%%%%%%%%%% saving name in the local computer
folder_path='Z:\zoologie\HamedData\P1\w0009 juv\30-04-2020'; %%%%%%%%%% read videofile from here
fname='3-04-2020_00125_converted'; %%%%%%%%%%%% video file name
dir_path_ephys='Z:\zoologie\HamedData\P1\w0009 juv\01-05-2020\chronic_2020-05-01_20-43-18'; %%%%%%%%
dir_prefix='133'; %%%%%%%%%%%%%%
app.file_dev=4; %%%%%%%%%%%%%%%%% which portion of EEG file you want to read? 10 for ane tenth of the file
chnl_order=[1 2 3 4 5 7 6 8 9 10 11 12 13 16 14 15]; 
[~,app.data_name,~]=fileparts(folder_path);
%% Reading the EEG
app.f_path=[folder_path '\' fname '.avi'];
app.vid=VideoReader(app.f_path);
f0=1; %1st frame
fn=873000;%%%%%%%  ceil(app.vid.FrameRate*app.vid.Duration/app.file_dev)-1000;  %%%%%%%%%% last frame %%%%%%%%% /10
app.frames=f0: fn; % frames to be analyzed

% app.time frames for app.video frames: loading synchroniying ADC channel
downsamp_ratio=1; % must be a power of 2, as the file reader reads blocks of 1024 samples each app.time
[ ADC, time_adc, ~]=OpenEphys2MAT_load_save_Data(1, [dir_prefix '_ADC'], downsamp_ratio, app.file_dev,...
    dir_path_ephys);
%Extracting synchroniying app.times of frames
[peak_indx]=find(ADC.*(ADC>4));
jumps_to_new_frame_indx=[diff(peak_indx)>5; true];
unique_peak_indx=peak_indx(jumps_to_new_frame_indx);
t_frames_=time_adc(unique_peak_indx);
clear unique_peak_indx jumps_to_new_frame_indx ADC time_adc peak_indx
app.t_frames=t_frames_(app.frames);

% load app.EEG as .continuous
downsamp_ratio=64; %%%%%%%%% must be a power of 2, as the file reader reads blocks of 1024 samples each app.time
[ EEG_, app.time, ~]=OpenEphys2MAT_load_save_Data(chnl_order, [dir_prefix '_CH'], downsamp_ratio, app.file_dev,...
    dir_path_ephys);
EEG=zscore(EEG_);
clear EEG_

% putting the EEG samples in a matrix of rows corresponding to epoches
fs=30000/downsamp_ratio;
eeg=zeros(floor(1.5*fs),16,ceil(length(EEG)/floor(1.5*fs)));
app.current_win=app.t_frames(1)+5; % first window-center app.time
k=1;  
while app.current_win<app.t_frames(end)
indx=find(app.time>(app.current_win-0.75) & app.time<=app.current_win+0.75);
eeg(:,:,k) = EEG(indx(1:floor(1.5*fs)),:); 
app.current_win=app.current_win+1.5; % first window-center app.time
if rem(k,100)==0 
    k
end
k=k+1;
end
EEG=eeg(:,:,1:k-1); clear eeg
t_bins=app.t_frames(1)+5:1.5:app.t_frames(end);
%% load video
clear r_dif
app.roi_y=1:1024;  app.roi_x=1:1280;  % where is the region of interest?
app.current_win=app.t_frames(1)+5; % first window-center app.time
k=1;
while app.current_win<app.t_frames(end)
win_frames=app.frames(app.t_frames>(app.current_win-0.75) & app.t_frames<app.current_win+0.75);
[r_dif(k,:),~, ~, ~] = birdvid_move_extract_app_obj(app.vid,win_frames,app.roi_y,app.roi_x); 
if rem(k,100)==0 
    k
end
k=k+1;
app.current_win=app.current_win+1.5; % first window-center app.time
end
r_dif=r_dif(1:k-1,:);

mov=mean(r_dif,2);
%% save the output variables
save(['G:\Hamed\zf\P1\labled sleep\' saving_name],'EEG','t_bins','mov','-v7.3','-nocompression');
