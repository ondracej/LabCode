function [SWS_len, IS_len, REM_len] = stage_length_Rev(labels, t_labels)

% stage lengths
% logic of the algorithm:
% We go through all the bins (t_labels), and look at the current label, if it
% is the same as the one of the next bin, we increase the bout leng by
% 3-sec (bin len). If it is different, we end the bout, save it and mark
% the start of a new bout.If there is no label assigned to the current bin
% (it is an artefact), we just mark the end of the current bout.

SWS_len=[];
REM_len=[];
IS_len=[];
bin=1;

while bin<length(labels)-1
    bout_len=3; % first bin is the start of a bout, each bin is 3 sec 
        while t_labels(bin+1)-t_labels(bin)<3.5 & ...
            strcmp(labels(bin+1),labels(bin))
        bout_len=bout_len+3;
        if bin<length(labels)-1
        bin=bin+1; 
        else
            break;
        end
    end

    switch labels{bin}
        
        case 'SWS'
            SWS_len=[SWS_len bout_len];
        case 'REM'
            REM_len=[REM_len bout_len];
        case 'IS'
            IS_len=[IS_len bout_len];
    end
    bin=bin+1;
end
end














