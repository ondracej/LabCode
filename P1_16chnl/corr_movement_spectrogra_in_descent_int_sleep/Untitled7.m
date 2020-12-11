
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