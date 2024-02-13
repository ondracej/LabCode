clear; clc;
tic
dir_path_ephys='Y:\hameddata2\EEG-LFP-songLearning\w025andw027\w0025-w0027 -just ephys\chronic_2021-08-17_21-47-03'; %%%%%%%%
bird_name='w027'; %%%%%%%%%
dir_prefix='150'; %%%%%%%%%
f_postname=''; % if exists! %%%%%%%%%
[~, fName, ~] = fileparts(dir_path_ephys);
saving_name=[bird_name '_allchans' fName(9:18) ]; %%%%%%%%%%%% saving name in the local computer
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
data_.ephys=ephys__;

data.rec_chnl=rec_chnls;  
data_.time=time;
save(['Y:\hameddata2\EEG-LFP-songLearning\Mat_files\' saving_name],'data_','-v7.3','-nocompression'); % add light on
% light off times