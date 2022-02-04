

%% Reading the EEG
f_path=[folder_path '\' fname '.avi'];
vid=VideoReader(f_path);
frames=f0: fn; % frames to be analyzed

% time frames for video frames: loading synchroniying ADC channel
% downsamp_ratio=1; % must be a power of 2, as the file reader reads blocks of 1024 samples each time
% file_div_adc=1;
% [ ADC, time_adc, ~]=OpenEphys2MAT_load_save_Data(1, [dir_prefix '_ADC'], downsamp_ratio, file_div_adc,...
%     dir_path_ephys);
% % making the flag for ADC: either 1 for ON or 0 for OFF
% k=1; % index of epoch for ADC (also EEG)
% while k*3*30000<length(ADC)
%     ADC_flag_(k)=std(ADC((k-1)*3*30000+1:k*3*30000));
%     k=k+1;
% end
% ADC_flag=ADC_flag_>median(ADC_flag_)-4*iqr(ADC_flag_);
% % finding the time when ADC started the pulses and stopped the pulses:
% flags_1=find(ADC_flag);
% ADC_on=flags_1(1);
% ADC_off=flags_1(end);

% load EEG as .continuous
downsamp_ratio=64; %%%%%%%%% must be a power of 2, as the file reader reads blocks of 1024 samples each time
[ EEG_, time, ~]=OpenEphys2MAT_load_save_Data(chnl_order, [dir_prefix '_CH'], downsamp_ratio, file_dev,...
    dir_path_ephys);
EEG=zscore(EEG_);
clear EEG_

% putting the EEG samples in a matrix of rows corresponding to epoches
fs=30000/downsamp_ratio;
eeg_len=ceil(length(EEG)/round(3*fs));
eeg_=zeros(round(3*fs),length(chnl_order),eeg_len);
k=1;  
while round(k*3*fs)<length(EEG)
EEG_part=EEG(floor((k-1)*3*fs)+1:ceil(k*3*fs),:); 
eeg_(:,:,k) = EEG_part(1:round(3*fs),:);
k=k+1;
end

% EEGs with video
EEG3sec=eeg_(:,:,1:eeg_len);
%% load video
clear r_dif
roi_y=1:1024;  roi_x=1:1280;  % where is the region of interest?
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
%% save the output variables
save(['G:\Hamed\zf\P1\labled sleep\' saving_name],'EEG3sec','f0','fn','mov','-v7.3','-nocompression');