function [sws_congruence, sws_bins_ref, sws_bins] = moving_cngruence_sws(t_feat,t_bin_center,...
    bin_label_ref,bin_label,t_bin_label_ref,t_bin_label)

counter_bin=0;
counter_bin_ref=0;
% counter for number of labels from each stage, and number of congruent
% bins
sws_bins_ref=0; 
sws_bins=0; 
cong_sws=0;
bin_len=2.5; % window length for the moving averaging 
% cut the corresponding piece of the t_label and label variables around the
% bin_center
inds_t_feat_select=t_feat>=t_bin_center-bin_len*60 & t_feat<=t_bin_center+bin_len*60;
inds_t_bin_ref_select=t_bin_label_ref>=t_bin_center-bin_len*60 & t_bin_label_ref<=t_bin_center+bin_len*60;
inds_t_bin_select=t_bin_label>=t_bin_center-bin_len*60 & t_bin_label<=t_bin_center+bin_len*60;
t_bin_label_select=t_bin_label(inds_t_bin_select);
t_bin_label_ref_select=t_bin_label_ref(inds_t_bin_ref_select);
t_feat_select=t_feat( inds_t_feat_select );

for counter_t=1:length(t_feat_select)
    t_bin=t_feat_select(counter_t);

    if ismember(t_bin,t_bin_label_ref_select) & ismember(t_bin,t_bin_label_select)
          if strcmp(bin_label{t_bin_label==t_bin},'SWS')==1
                sws_bins=sws_bins+1;
          end
        if strcmp(bin_label_ref{t_bin_label_ref==t_bin},'SWS')==1
                sws_bins_ref=sws_bins_ref+1;
                if strcmp(bin_label{t_bin_label==t_bin},'SWS')==1
                     cong_sws=cong_sws+1;
                end
        end
    end
       
end

sws_congruence=cong_sws/sws_bins_ref;
if sws_bins_ref==0
    sws_congruence=0;
end
