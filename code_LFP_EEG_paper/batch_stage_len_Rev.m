
%% Load data and compute the stages lengths
% reading all mat files of the scoring results, and run 'length' code
clear; clc;
path_directory='Y:\zoologie\HamedData\LocalSWPaper\PaperData\new_scorings';
path_directory_save='Y:\zoologie\HamedData\LocalSWPaper\PaperData\new_scorings\stage_lengths';
all_files=dir([path_directory '/*.mat']);
for k=1:length(all_files)
    clear t_DG labels_ bin_label t_bin_label
    f_name=all_files(k).name
    filename=[path_directory '/' f_name];
    load(filename);
    bin_label=labels_;
    t_bin_label=t_DG;
    [bouts_SWS_len, bouts_IS_len, bouts_REM_len]=stage_length_Rev(bin_label, t_bin_label);
    % saving results
    fname=[path_directory_save '/' 'stage_len_' f_name];
    save(fname,'bouts_SWS_len', 'bouts_IS_len', 'bouts_REM_len', '-v7.3');
end




