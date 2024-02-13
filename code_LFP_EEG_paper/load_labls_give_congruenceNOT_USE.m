%% unision of wake times
% load all chnls of one bird in a loop and find the unision of wake times,
%  the bins that at least one of the chnannels says wake:
clear;
bird_name='w025';
myFolder='Z:\HamedData\LocalSWPaper\PaperData\'  ; 

filePattern = fullfile(myFolder, [bird_name '*.mat']); 
theFiles = dir(filePattern);
for k = 1 : 1%length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);

  chnl_data = load(fullFileName);
end
%% %%%%%%%%%% load a channel and the ref channel data manually from: Z:\HamedData\LocalSWPaper\PaperData

% set th bin labels that are 'wake' in the ref
%. 1 congruence and percentages
congruence_analysis;

%. 2 Stage lengths
[bouts_Wake_len, bouts_SWS_len, bouts_IS_len, bouts_REM_len] = stage_length(bin_label,valid_bin_inds,t_feat);
[bouts_Wake_len_ref, bouts_SWS_len_ref, bouts_IS_len_ref, bouts_REM_len_ref] = stage_length(bin_label_ref,valid_bin_ref_inds,t_feat);


