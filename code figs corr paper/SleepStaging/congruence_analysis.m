% congruence for each stage
% the logic of the algorithm :
% for each bin, we look at the lables in the reference channel and the
% other channel that is being compared with thr ref chnl. If the bin is
% valid in both channels, i.e. there is no artefact and therefore there is 
% is a label assigned to it, we read the label at the ref channel and
% compare the label in the other channel with it. If the labels match, it
% counts for a congruent bin, otherwise for an incongruent bin.
% See (Ernesto Duran, Sleep, 2018) as the reference to this method.

% we go throgh all the bins in a loop, so we need inices for the labels in
% the ref channel and the comparison channel
counter_bin=0;
counter_bin_ref=0;
% counter for number of labels from each stage, and number of congruent
% bins
sws_bins=0; 
rem_bins=0;
is_bins=0;
cong_sws=0;
cong_rem=0;
cong_is=0;

for counter_t=1:length(t_feat)
    if valid_bin_inds(counter_t)==1 & valid_bin_ref_inds(counter_t)==0
        counter_bin=counter_bin+1;
        continue;
    elseif valid_bin_inds(counter_t)==0 & valid_bin_ref_inds(counter_t)==1
        counter_bin_ref=counter_bin_ref+1;
        continue; 
    elseif valid_bin_inds(counter_t)==0 & valid_bin_ref_inds(counter_t)==0
        continue; 
    elseif valid_bin_inds(counter_t)==1 & valid_bin_ref_inds(counter_t)==1
        counter_bin_ref=counter_bin_ref+1;
        counter_bin=counter_bin+1;
        switch bin_label_ref{counter_bin_ref}
            case 'SWS'
                sws_bins=sws_bins+1;
                if strcmp(bin_label{counter_bin},'SWS')==1
                    cong_sws=cong_sws+1;
                end
            case 'REM'
                rem_bins=rem_bins+1;
                if strcmp(bin_label{counter_bin},'REM')==1
                    cong_rem=cong_rem+1;
                end
            case 'IS'
                is_bins=is_bins+1;
                if strcmp(bin_label{counter_bin},'IS')==1
                    cong_is=cong_is+1;
                end
        end
    end
end

Wake_portion_ref=sum(strcmp(bin_label_ref,'Wake'))/length(bin_label_ref)
SWS_portion_ref=sum(strcmp(bin_label_ref,'SWS'))/length(bin_label_ref)
REM_portion_ref=sum(strcmp(bin_label_ref,'REM'))/length(bin_label_ref)
IS_portion_ref=sum(strcmp(bin_label_ref,'IS'))/length(bin_label_ref)

disp(' ###################################')
Wake_portion=sum(strcmp(bin_label,'Wake'))/length(bin_label)
SWS_portion=sum(strcmp(bin_label,'SWS'))/length(bin_label)
REM_portion=sum(strcmp(bin_label,'REM'))/length(bin_label)
IS_portion=sum(strcmp(bin_label,'IS'))/length(bin_label)
% congruence for each stage, and in each channel, is defined as the number of
% bins with the same lable in both the ref and that given channel devided
% by the total number of bins in the ref chnl having that specific label
sws_congruence=cong_sws/sws_bins
rem_congruence=cong_rem/rem_bins
is_congruence=cong_is/is_bins
                


        
        
        
        
        
        
        
        
        
        



