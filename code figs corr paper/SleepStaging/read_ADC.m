%% Reading the ADC

% load EEG as .continuous
[ ephys, time, ~]=OpenEphys2MAT_load_save_Data(rec_chnls, [dir_prefix '_ADC'], f_postname, downsamp_ratio, file_dev,...
    dir_path_ephys);