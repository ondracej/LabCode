function [bouts_Wake_len, bouts_SWS_len, bouts_IS_len, bouts_REM_len] = stage_transition(bin_label,valid_bin_inds, t_feat)

% stage lengths
% logic of the algorithm:
% We go through all the bins (t_feat), and look at the current label, if it
% is the same as the one of the previous bin, we increase the bout leng by
% 2-sec (bin len). If it is different, we end the bout, save it and mark
% the start of a new bout.If there is no label assigned to the current bin
% (it is an artefact), we just mark the end of the current bout.

adds=find(valid_bin_inds); % index to valid (labelled) bins
bouts_Wake_len=[];
bouts_SWS_len=[];
bouts_REM_len=[];
bouts_IS_len=[];

bout_len=2; % first bin is the start of a bout, each bin is 2 sec
   
for k=2:length(bin_label)
    if t_feat(adds(k))-t_feat(adds(k-1))>2.1 %  there has abeen an invalid bin between the last bin and the current one
            switch bin_label{k-1}
                case 'Wake'
                    bouts_Wake_len=[bouts_Wake_len bout_len];
                case 'SWS'
                    bouts_SWS_len=[bouts_SWS_len bout_len];
                case 'REM'
                    bouts_REM_len=[bouts_REM_len bout_len];
                case 'IS'
                    bouts_IS_len=[bouts_IS_len bout_len];
            end
        % start of a new bout
            bout_len=2; % 2 sec for the new bin
    else
        if strcmp(bin_label{k},bin_label{k-1})
              bout_len=bout_len+2; % 2 sec for each bin
        else
            switch bin_label{k-1}
                case 'Wake'
                    bouts_Wake_len=[bouts_Wake_len bout_len];
                case 'SWS'
                    bouts_SWS_len=[bouts_SWS_len bout_len];
                case 'REM'
                    bouts_REM_len=[bouts_REM_len bout_len];
                case 'IS'
                    bouts_IS_len=[bouts_IS_len bout_len];
            end
        % start of a new bout
            bout_len=2; % 2 sec for the new bin
        end
    end
end

end




            
        
            
            
            
            
            
            
            
        
