% open all mat files in PaperData (they iclude the sleep labels), compute
% the stage lengths for each file, and save the results in tje same file.

folder_name=['Z:\HamedData\LocalSWPaper\PaperData\' ]; 
addpath(genpath(folder_name));
mat = dir(fullfile(folder_name,'*.mat'));
for q = 1:2%length(mat) 
    clear data;
    data=load(mat(q).name);
    
    % processig: computing the stage lengths
%     [bouts_Wake_len, bouts_SWS_len, bouts_IS_len, bouts_REM_len] = stage_length(bin_label,valid_bin_inds,t_feat);
% 
%     % saving the result plus the previous content to the file
%     fname=['Z:\HamedData\LocalSWPaper\PaperData\' mat(q).name ]; 
% save(fname,'bin_label_ref','valid_bin_ref_inds','t_feat',...
%     'Delta_ref_', 'Gamma_ref_','feat_ref', 'ref_binned',...
%     'bouts_Wake_len','bouts_SWS_len','bouts_IS_len','bouts_REM_len','t_bin_label_ref', '-v7.3');
end


