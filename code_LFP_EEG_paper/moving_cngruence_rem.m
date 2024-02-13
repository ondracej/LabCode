function [REM_congruence, REM_bins_ref, REM_bins] = moving_cngruence(t_feat,t_bin_center,valid_bin_inds,valid_bin_ref_inds,...
    bin_label_ref,bin_label,t_bin_label_ref,t_bin_label)

counter_bin=0;
counter_bin_ref=0;
% counter for number of labels from each stage, and number of congruent
% bins
REM_bins_ref=0; 
REM_bins=0; 
cong_REM=0;
% cut the corresponding piece of the t_label and label variables around the
% bin_center
inds_t_feat_select=t_feat>=t_bin_center-2.5*60 & t_feat<=t_bin_center+2.5*60;
inds_t_bin_ref_select=t_bin_label_ref>=t_bin_center-2.5*60 & t_bin_label_ref<=t_bin_center+2.5*60;
inds_t_bin_select=t_bin_label>=t_bin_center-2.5*60 & t_bin_label<=t_bin_center+2.5*60;
t_bin_label_select=t_bin_label(inds_t_bin_select);
t_bin_label_ref_select=t_bin_label_ref(inds_t_bin_ref_select);
t_feat_select=t_feat( inds_t_feat_select );

for counter_t=1:length(t_feat_select)
    t_bin=t_feat_select(counter_t);

    if ismember(t_bin,t_bin_label_ref_select) & ismember(t_bin,t_bin_label_select)
          if strcmp(bin_label{t_bin_label==t_bin},'REM')==1
                REM_bins=REM_bins+1;
          end
        if strcmp(bin_label_ref{t_bin_label_ref==t_bin},'REM')==1
                REM_bins_ref=REM_bins_ref+1;
                if strcmp(bin_label{t_bin_label==t_bin},'REM')==1
                     cong_REM=cong_REM+1;
                end
        end
    end
       
end

REM_congruence=cong_REM/REM_bins_ref;
if REM_bins_ref==0
    REM_congruence=0;
end
