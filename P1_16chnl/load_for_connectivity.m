function [EEG, time, r_dif_med_removed, t_frame] = load_for_connectivity(chnl_order,dir_add,vid_fname, roi)


%% Loading EEG
addpath(genpath('D:\github\Lab Code\P1_16chnl'));
addpath(genpath('D:\github\Lab Code\Respiration VideoAnalysis'));
addpath(genpath('D:\github\Lab Code\LoadEphys_SWRanalysis'));

% loading OpenEphys file:
[ EEG,time,~]=OpenEphys2MAT_load_save_Data(chnl_order, '133_CH',15,dir_add); % downsample ...
% with a factor of 15

% loading synchroniying ADC channel
[ ADC, time_adc, ~]=OpenEphys2MAT_load_save_Data(1, '133_ADC',1,dir_add);

fs=2000;

%Extracting synchroniying times of frames
[peak_indx]=find(ADC.*(ADC>4));
jumps_to_new_frame_indx=[diff(peak_indx)>5; true];
unique_peak_indx=peak_indx(jumps_to_new_frame_indx);
t_frames=time_adc(unique_peak_indx);
clear ADC time_adc peak_indx unique_peak_indx
%% loading video data
vid=VideoReader([dir_add '\' vid_fname '.avi']);

% selecting frame range for processig
% n=vid.NumFrames; % this is an estimation of number of frame, to be safe consider ...
% something like 500 fewer frames as the last frame
n=vid.NumFrames; % this is an estimation of number of frame, to be safe consider ...
f0=floor(1); % 1st frame %%%%%%%%%

fn=floor(n)-1000; % last frame %%%%%%%%%%
f_path=[dir_add '\' vid_fname '.avi'];
frames=f0: fn; % frames to be analyzed
roi.y=1:500;  roi.x=1:1280; %%%%%%%%%%%%% ROI (starting from top left)
[r_dif,~, ~, ~] = birdvid_move_extract(f_path,frames,roi.y,roi.x);
t_frame=t_frames(f0:fn);  clear t_frames;
r_dif=r_dif(f0:fn); % cut the zeroes at the beginning so it matches t_frame
r_dif_med_removed=movmean(r_dif-movmedian(r_dif,.5*20),.5*20); % smooth data for .5 sec

% load handel.mat;sound(y, Fs); % notifying the end of video computation

%% filterong data 
%  [b,a]= butter(2,100/fs);
%  eeg=filtfilt(b,a,EEG);
%%  raw plot of all channels to select best representative L and R chnls

figure;
set(gcf, 'Position',  [100, 50, 1700, 900])
t0=9100; %%%%%%%%%%  starting time for plot in secinds
t_limm=t0 + [0 30]; 
eegs=EEG((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs , :);
t_eegs=time((t_limm(1)-time(1))*fs+1:(t_limm(2)-time(1))*fs);
dist=.6*std( EEG(randi(length(EEG),1,10000),1));
for n=1:size(eegs,2)
    plot(t_eegs,eegs(:,n)+(n-1)*dist);  hold on
end
t_limm=t0 + [0 30]; 
xlim(t_limm); ylim([-1 17]*dist)
title(dir_add)
end

