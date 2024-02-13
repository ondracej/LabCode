

%% Reading the EEG

% load EEG as .continuous
[ ephys, time, ~]=OpenEphys2MAT_load_save_Data(rec_chnls, [dir_prefix '_CH'], f_postname, downsamp_ratio, file_dev,...
    dir_path_ephys);
%% save the output variables
% save(['G:\Hamed\zf\P2_EEG_LFP\mat_files\' saving_name],'ephys','time','rec_chnls','-v7.3','-nocompression'); % add light on
% light off times
