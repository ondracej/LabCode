%% setting addresses and parameters

light_off_frame=31050; %%%%%%%%%%%% lights-off frame number
folder_path='Z:\zoologie\HamedData\P1\73-03\73-03 09_03_2020'; %%%%%%%%%% read video file from here
fname='09_03_2020_00090_converted'; %%%%%%%%%%%%
dir_path_server='Z:\zoologie\HamedData\P1\73-03\73-03 09_03_2020\chronic_2020-03-09_19-18-04'; %%%%%%%%
dir_path='G:\Hamed\zf\P1\73-03\09_03_2020'; %%%%%%%%%%%%% save results here
dir_prefix='133'; %%%%%%%%%%%%%%
file_dev=12; %%%%%%%%%% which prtion of EEG file you want to read? 10 for ane tenth of the file
chnl_order=[1 2 3 4 5 6 8 7 10 9 11 12 13 16 14 15 ];

%% preparing the EEG and video for the GUI

f_path=[folder_path '\' fname '.avi'];
vid=VideoReader(f_path);
f0=1; % 1st frame
fn=vid.NumOfFrames-1000; % last frame
frames=f0: fn; % frames to be analyzed
roi_y=1:1024;  roi_x=1:1280; % where is the region of interest?

mkdir(dir_path);
clear roi_x roi_y   vid

% time frames for video frames: loading synchroniying ADC channel
downsamp_ratio=1; % must be a power of 2, as the file reader reads blocks of 1024 samples each time
file_dev_adc=1; % which poetion of file you want to read? 10 for ane tenth of the file
[ ADC, time_adc, ~]=OpenEphys2MAT_load_save_Data(1, [dir_prefix '_ADC'], downsamp_ratio, file_dev_adc,...
    dir_path_server);
%Extracting synchroniying times of frames
[peak_indx]=find(ADC.*(ADC>4));
jumps_to_new_frame_indx=[diff(peak_indx)>5; true];
unique_peak_indx=peak_indx(jumps_to_new_frame_indx);
t_frames=time_adc(unique_peak_indx);
clear unique_peak_indx jumps_to_new_frame_indx ADC time_adc peak_indx
t_frames=t_frames(frames);
t_light_off=t_frames(light_off_frame-f0+1);

% load EEG as .continuous
downsamp_ratio=16; %%%%%%%%% must be a power of 2, as the file reader reads blocks of 1024 samples each time
tic
[ EEG, time, ~]=OpenEphys2MAT_load_save_Data(chnl_order, [dir_prefix '_CH'], downsamp_ratio, file_dev,...
    dir_path_server);
toc

current_win=t_frames(1)+2; % first window-center time

%% for the SleepScore button press
t_plot=[current_win-1.5 current_win+1.5];  %%%%%%%%%%% time for plotting
win_frames=frames(t_frames>t_plot(1) &t_frames<t_plot(2));
[r_dif,acc_dif, last_im, last_dif] = birdvid_move_extract(f_path,win_frames,roi_y,roi_x);

%% for 3-sec forward button
current_win=current_win+3;


















