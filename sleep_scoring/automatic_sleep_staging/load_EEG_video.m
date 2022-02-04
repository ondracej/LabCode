

%% Reading the EEG
f_path=[folder_path '\' fname '.avi'];
vid=VideoReader(f_path);
frames=f0: fn; % frames to be analyzed

% time frames for video frames: loading synchroniying ADC channel
downsamp_ratio=1; % must be a power of 2, as the file reader reads blocks of 1024 samples each time
file_div_adc=1;
[ ADC, time_adc, ~]=OpenEphys2MAT_load_save_Data(1, [dir_prefix '_ADC'], downsamp_ratio, file_div_adc,...
    dir_path_ephys);

if ADC_corruption
ADC_teager=teager(ADC,N_teager);
ADC_=ADC_teager.*(ADC_teager<jump_val & ADC_teager>-jump_val);
end
%Extracting synchroniying times of frames
[peak_indx]=find(ADC_.*(ADC_>ADC_thresh));
jumps_to_new_frame_indx=[diff(peak_indx)>1000; true]; % 1000 comes from the jump between the ADC pulses. in case of my recordings ...
% fs=30000, and pulse rate is 20Hz, so the number of samples between two
% consecutive pulses is 30000/20=1500, and 1000 is chosen as a number near
% to that but smaller, considering the time that the pulse is at high state
unique_peak_indx=peak_indx(jumps_to_new_frame_indx);
t_frames_=time_adc(unique_peak_indx);
clear unique_peak_indx jumps_to_new_frame_indx time_adc peak_indx
t_frames=t_frames_(frames);

% load EEG as .continuous
downsamp_ratio=64; %%%%%%%%% must be a power of 2, as the file reader reads blocks of 1024 samples each time
[ EEG_, time, ~]=OpenEphys2MAT_load_save_Data(chnl_order, [dir_prefix '_CH'], downsamp_ratio, file_dev,...
    dir_path_ephys);
EEG=zscore(EEG_);
clear EEG_

% putting the EEG samples in a matrix of rows corresponding to epoches
fs=30000/downsamp_ratio;
eeg=zeros(floor(1.5*fs),length(chnl_order),ceil(length(EEG)/floor(1.5*fs)));
current_win=t_frames(1)+5; % first window-center time
k=1;  
while current_win<t_frames(end)
indx=find(time>(current_win-0.75) & time<=current_win+0.75);
eeg(:,:,k) = EEG(indx(1:floor(1.5*fs)),:); 
current_win=current_win+1.5; % first window-center time
k=k+1;
end
EEG=eeg(:,:,1:k-1); clear eeg
t_bins=t_frames(1)+5:1.5:t_frames(end);
%% load video
clear r_dif
roi_y=1:1024;  roi_x=1:1280;  % where is the region of interest?
current_win=t_frames(1)+5; % first window-center time
k=1;
while current_win<t_frames(end)
win_frames=frames(t_frames>(current_win-0.75) & t_frames<current_win+0.75);
[r_dif(k,:),~, ~, ~] = birdvid_move_extract_app_obj(vid,win_frames,roi_y,roi_x); 
if rem(k,100)==0 
    k
end
k=k+1;
current_win=current_win+1.5; % first window-center time
end
r_dif=r_dif(1:k-1,:);

mov=mean(r_dif,2);
%% save the output variables
save(['G:\Hamed\zf\P1\labled sleep\' saving_name],'EEG','t_bins','mov','-v7.3','-nocompression');
