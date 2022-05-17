clear; clc;

dir_path_ephys='Z:\hameddata2\EEG-LFP-song learning\w038 and w037\chronic_2021-09-03_21-51-46'; %%%%%%%%
bird_name='w038'; %%%%%%%%%
dir_prefix='150'; %
[~, fName, ~] = fileparts(dir_path_ephys);
saving_name=[bird_name '_' fName(9:21) ]; %%%%%%%%%%%% saving name in the local computer
file_dev=1; %%%%%%%%%%%%%%%%% which portion of EEG file you want to read? 10 for ane tenth of the file
eeg_chnls=[21,28];
lfp_chnls=[24:27];

% load EEG data
downsamp_ratio=64;
file_div_adc=1;
read_save_EEG_LFP;
