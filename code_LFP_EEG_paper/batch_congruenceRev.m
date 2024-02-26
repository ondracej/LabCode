%% Load data and compute the ongruence and percetage
% reading all Mat files of the scoring results, and run cong code
clear; clc;
 path_directory='Y:\zoologie\HamedData\LocalSWPaper\PaperData\new_scorings'; 

 all_files=dir([path_directory '/*.mat']); 
 for k=1:length(all_files)
     f_name=all_files(k).name;
    filename=[path_directory '/' f_name];
    load(filename);
        bin_label=labels_;
    % now also loading the ref channel for the same bird
    ref_filename=[path_directory '/' f_name(1:4) '_l_a'];
        load(ref_filename);
        bin_label_ref=labels_;
        disp(f_name)
    congAndPercentageRev(bin_label, bin_label_ref)
end